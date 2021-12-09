COMPILER	= g++
CFLAGS		= -g -MMD -MP -Wall -Wextra -Winit-self -Wno-missing-field-initializers -std=c++0x -Wno-unused-function -DBOOST_LOG_DYN_LINK
LDFLAGS = -L../../boost_1_66_0/stage/lib
LIBS			= -lboost_system -lboost_thread -lboost_math_c99 -lboost_program_options -lboost_log -lboost_log_setup -lpthread -lgtest
INCLUDE	 = -I/usr/local/include
TARGET		= ./a.out
SRCDIR		= ./src
ifeq "$(strip $(SRCDIR))" ""
	SRCDIR	= .
endif
SOURCES	 = $(wildcard $(SRCDIR)/*.cpp)
OBJDIR		= ./obj
ifeq "$(strip $(OBJDIR))" ""
	OBJDIR	= .
endif
OBJECTS	 = $(addprefix $(OBJDIR)/, $(notdir $(SOURCES:.cpp=.o)))
DEPENDS	 = $(OBJECTS:.o=.d)

$(TARGET): $(OBJECTS)
	$(COMPILER) -o $@ $^ $(LDFLAGS) $(LIBS)

$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	-mkdir -p $(OBJDIR)
	$(COMPILER) $(CFLAGS) $(INCLUDE) -o $@ -c $<

TEST_TARGET=./gtest
LIB_DIR=./lib
TEST_DIR=./test
TEST_SRC= $(wildcard $(TEST_DIR)/*.cpp)
TEST_OBJS	= $(addprefix $(OBJDIR)/, $(notdir $(TEST_SRC:.cpp=.o)))
GTEST_INC= $(INCLUDE)
GTEST_LIBS = /usr/local/lib/libgtest.a /usr/local/lib/libgtest_main.a

.PHONY: test
OBJS_EXCEPT_MAIN = $(addprefix $(OBJDIR)/, $(filter-out main.o, $(notdir $(SOURCES:.cpp=.o))))
SRCDIR=./public_src
test: $(TEST_TARGET)
$(TEST_TARGET) : $(TARGET) $(TEST_OBJS) 
	$(COMPILER) $(LDFLAGS) -o $@ $(TEST_OBJS) $(OBJS_EXCEPT_MAIN) $(LIBS)

$(OBJDIR)/%.o: $(TEST_DIR)/%.cpp $(GTEST_HEADERS)
	@[ -d $(OBJDIR) ] || mkdir -p $(OBJDIR)
	$(COMPILER) $(CFLAGS) -I$(GTEST_INC) -I$(SRCDIR) -I$(INCLUDE) -o $@ -c $<

all: clean $(TARGET)

clean:
	-rm -f $(OBJECTS) $(DEPENDS) $(TARGET)

-include $(DEPENDS)
# @[ -d $(BIN_DIR) ] || mkdir -p $(BIN_DIR)
