// Task 1-2.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <cmath>

using namespace std;

int main()

{
	const double Pi = 3.14;
	double radius, volume, square;

	cout << "Vvedite radius shara:\n";
	cin >> radius;
	volume = (4 / 3) * Pi * (radius * radius * radius);
	square = Pi * (radius * radius);
	cout << "Ob'yom shara = " << volume << " Ploshad' shara = " << square;

}