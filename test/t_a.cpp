#include "gtest/gtest.h"
#include "a.h"

namespace {
  class a_test : public testing::Test{};
  TEST_F(a_test, 1)
	{
   	a a_;
		a_.print();
		bool b = true;
    EXPECT_EQ(true, b);
  }
}
