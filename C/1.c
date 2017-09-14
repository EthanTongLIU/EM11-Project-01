#include <stdio.h>
#include <math.h>

#define N 5
double Pi;
double lroots[N];
double weight[N];
double lcoef[N + 1][N + 1] = {{0}};

void lege_coef() /*勒让德多项式的系数，这里由于是前6个勒让德多项式，构造一个6x6的矩阵*/
{
	int n, i;
	lcoef[0][0] = lcoef[1][1] = 1;
	for (n = 2; n <= N; n++) {
		lcoef[n][0] = -(n - 1) * lcoef[n - 2][0] / n;
		for (i = 1; i <= n; i++)
			lcoef[n][i] = ((2 * n - 1) * lcoef[n - 1][i - 1]
					 - (n - 1) * lcoef[n - 2][i] ) / n;
	}
}

double lege_eval(int n, double x) /*勒让德区间*/
{
	int i;
	double s = lcoef[n][n];
	for (i = n; i; i--)
		s = s * x + lcoef[n][i - 1];
	return s;
}

double lege_diff(int n, double x) /*微分方程*/
{
	return n * (x * lege_eval(n, x) - lege_eval(n - 1, x)) / (x * x - 1);
}

void lege_roots() /*求解勒让德根，即区间的节点，并计算权重*/
{
	int i;
	double x, x1;
	for (i = 1; i <= N; i++) {
		x = cos(Pi * (i - .25) / (N + .5));
		do {
			x1 = x;
			x -= lege_eval(N, x) / lege_diff(N, x);
		} while (x != x1);
		/*  x != x1 is normally a no-no, but this task happens to be
		 *  well behaved. */
		lroots[i - 1] = x;

		x1 = lege_diff(N, x);
		weight[i - 1] = 2 / ((1 - x * x) * x1 * x1);
	}
}

double lege_inte(double (*f)(double), double a, double b) /*函数指针，传入积分区间的端点值和函数，做变量替换进行计算*/
{
	double c1 = (b - a) / 2, c2 = (b + a) / 2, sum = 0;
	int i;
	for (i = 0; i < N; i++)
		sum += weight[i] * f(c1 * lroots[i] + c2);
	return c1 * sum;
}

int main()
{
	int i;
	Pi = atan2(1, 1) * 4;

	lege_coef();
	lege_roots();

	printf("Roots: ");
	for (i = 0; i < N; i++)
		printf(" %g", lroots[i]);

	printf("\nWeight:");
	for (i = 0; i < N; i++)
		printf(" %g", weight[i]);

	printf("\nintegrating Exp(x) over [-3, 3]:\n\t%10.8f,\n"
		"compred to actual\n\t%10.8f\n",
		lege_inte(exp, -3, 3), exp(3) - exp(-3));
	return 0;
}
