#include <stdio.h>
class a {
public:
	a() = default;
	void print(){printf("this is a.\n");}
private:
	int return_private();
};
