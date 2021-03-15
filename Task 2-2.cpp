// Task 2-2.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
#define _USE_MATH_DEFINES 

#include <iostream>
#include <cmath>
#include <iomanip>
#include <limits>

using namespace std;

double f1(const double x, const double a);
double f2(const double x, const double a);

int main()

{
	const auto a = 2.8;
	double x;
	cout << "Vvedite peremennuyu x = ";
	cin >> x;
	if (x < 1.2)
	{
		cout << " y = " << f1(x, a);
	}
	else
	{
		cout << " y = " << f2(x, a);
	}

	return 0;
}

double f1(const double x, const double a)
{
	return a * x * x + 4;
}


double f2(const double x, const double a)
{
	return (a + 4 * x) * sqrt(pow(x, 2 * a));
}


