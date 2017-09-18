#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <math.h>

#define PI 3.1415926535

int n; //区间选择的点数
double a; //积分下限
double b; //积分上限

double poly_value( double *poly , double root ); //用于计算一个多项式函数的函数值

double poly_value( double *poly , double root )
{
    int i;
    double result;
    result = 0;
    for (i = 0; i <= n; i++) {
        result += poly[i] * pow( root , i );
    }
    return result;
}

int main()
{
    int i, j;
    double **p, *Lege, *Lege_D , *Roots, *W;
    double root_temp, v;
    printf( "请输入积分下限:" );
    scanf( "%lf" , &a );
    printf( "请输入积分上限:" );
    scanf( "%lf" , &b );
    printf( "选择几点积分?" );
    scanf( "%d" , &n );
    printf( "\n积分区间为:[%lf,%lf]\n%d点高斯积分\n理论代数精度为: %d\n\n" , a , b , n , 2 * n + 1 );

    p = ( double** )malloc( sizeof( double* ) * ( n + 1 ) );
    for ( i = 0; i <= n; i++ ) {
        p[i] = ( double* )malloc( sizeof( double ) * ( n + 1 ) );
    }

    Lege = ( double* )malloc( sizeof( double* ) * ( n + 1 ) );
    Lege_D = ( double* )malloc( sizeof( double* ) * ( n + 1 ) );    Roots = ( double* )malloc( sizeof( double* ) * n );
    W = ( double* )malloc( sizeof( double* ) * n );

    for (i = 0; i <= n; i++){
        for (j = 0; j <= n; j++){
            p[i][j] = 0;
        }
        Lege[i] = Lege_D[i] = 0;
    }
    for (i = 0; i < n; i++) {
        Roots[i] = W[i] = 0;
    }

     p[0][0] = p[1][1] = 1;
    for (i = 2; i <= n; i++) {
        for (j = n; j >= 1; j--) {
            Lege[j] = p[i-1][j-1];
        }
        Lege[0]=0;
        for (j = 0; j <= n; j++) {
            p[i][j] = ( ( 2 * i - 1 ) * Lege[j] - ( i - 1 ) * p[i-2][j] ) / ( i );
        }
    }
    for (i = 0; i <= n; i++) {
        Lege[i] = p[n][i];
    }
    printf( "%d阶勒让德多项式为:\n", n );
    for (i = 0; i <= n; i++) {
        printf( "%lf ", Lege[i] );
    }
    printf( "\n\n" );

    //得到勒让德多项式的导多项式
    for (i = 0; i <= n-1; i++) {
        Lege_D[i] = ( i + 1 ) * Lege[i+1];
    }
    Lege_D[n] = 0;
    printf( "%d阶勒让德多项式的导多项式为:\n", n );
    for (i = 0; i <= n; i++) {
        printf( "%lf ", Lege_D[i] );
    }
    printf( "\n\n" );

    for (i = 0; i < n; i++ ) {
        Roots[i] = cos( PI * ( i + 1 - 0.25 ) / ( n + 0.5 ) );
        root_temp = 0;
        while (root_temp != Roots[i]) {
            root_temp = Roots[i];
            Roots[i] = Roots[i] - poly_value( Lege , Roots[i] ) / poly_value( Lege_D , Roots[i] );
        }
    }

    printf( "勒让德多项式的%d个根为:\n", n );
    for (i = 0; i < n; i++) {
        printf( "%lf ", Roots[i] );
    }
    printf( "\n\n" );

    for (i = 0; i < n; i++) {
        W[i] = 2 / ( ( 1 - pow( Roots[i] , 2 ) ) * pow( poly_value( Lege_D , Roots[i] ) , 2 ) );
    }

    for (i = 0; i < n; i++) {
        printf( "%lf ", W[i] );
    }
    printf("\n");
    v = 0;
    for (i = 0; i < n; i++) {
        v += ( b - a ) / 2 * W[i] * exp( ( b - a ) / 2 * Roots[i] + ( a + b ) / 2 );
    }
    printf( "积分值是:%lf\n", v );

    for (i = 0; i <= n; ++i){
        free(p[i]);
    }
    free(p);

    free(Lege);
    free(Lege_D);
    free(Roots);
    free(W);

    return 0;
}
