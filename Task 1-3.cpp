// Task 1-3.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
#include <cmath>

using namespace std;

float  R, R1, R2, R3;

int main(int argc, char* argv[])
{
	cout << "R1 = "; cin >> R1;
	cout << "R2 = "; cin >> R2;
	cout << "R3 = "; cin >> R3;

	R = 1 / ((1 / R1) + (1 / R2) + (1 / R3));

	cout << "R = " << R << endl;

	system("PAUSE");
	return EXIT_SUCCESS;
}