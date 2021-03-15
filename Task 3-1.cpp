// Task 3-1.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
#define _USE_MATH_DEFINES // for C++

#include <iostream>
#include <cmath>
#include <iomanip>


using namespace std;

double y(const double x);

int main()
{
    const auto leftBound = 0.0;
    const auto rightBound = 2.0;
    const auto step = 0.2;

    auto x = leftBound;
    while ((x < rightBound) || (abs(x - rightBound) < step))
    {
        cout << "x = " << setprecision(2) << x << " y =  " << setprecision(5) << y(x) << endl;
        x += step;
    }
    return 0;
}

double y(const double x)
{
    return 0.29 * x * x * x + x - 1.2502;
}
