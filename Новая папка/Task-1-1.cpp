// Task-1-1.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <cmath>

using namespace std;

int main()


{
	const double x = 0.335;
	const double y = 0.025;

	auto a = 1 + x + pow(x, 2) / 2 + pow(x, 3) / 3 + pow(x, 4) / 4;
	auto b = x * (pow(sin(x), 3) + (cos(y) * cos(y)));

	cout << a << ' ' << b;


}