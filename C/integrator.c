#include <stdio.h>
#include <malloc.h>
#include <math.h>

#define PI 3.14159265358979323846

int n; //区间选择的点数
double a; //积分下限
double b; //积分上限

double *ploy_coefs( int n ); //用于得到一个勒让德多项式
//double *poly_coefs_D( double * , int n ); //用于得到一个多项式的导多项式
//double value_of_poly( double * ); //用于计算一 个多项式函数的函数值

double *poly_coefs( int n )
{
    double **a;
    double *Temp;
    int i, j;
    a = ( double** )malloc( sizeof( double* ) * ( n + 1 ) );
    for ( i = 0; i <= n; i++ ) {
        a[i] = ( double* )malloc( sizeof( double ) * ( n + 1 ) );
    }
    Temp = ( double* )malloc( sizeof( double* ) * ( n + 1 ) );
    //初始化，全部零化
    for (i = 0; i <= n; i++){
        for (j = 0; j <= n; j++){
            a[i][j] = 0;
        }
        Temp[i] = 0;
    }
    //构造勒让德多项式
    a[0][0] = a[1][1] = 1;
    for (i = 2; i <= n; i++) {
        for (j = n; j >= 1; j--) {
            Temp[j] = a[i-1][j-1];
        }
        Temp[0]=0;
        for (j = 0; j <= n; j++) {
            a[i][j] = ( ( 2 * i - 1 ) * Temp[j] - ( i - 1 ) * a[i-2][j] ) / ( i );
        }
    }
    for (i = 0; i <= n; i++) {
        Temp[i] = a[n][i];
    }
    printf( "%d阶勒让德多项式为:\n", n );
    for (i = 0; i <= n; i++) {
        printf( "%lf ", Temp[i] );
    }
    printf( "\n" );
    //释放动态开辟的空间
    for (i = 0; i <= n; ++i){
        free(a[i]);
    }
    free(a);

    return Temp;
}
/*
double *poly_coefs_D(  )
{

}

double value_of_poly(  )
{

}
*/

int main()
{
    int i, j;
    printf( "请输入积分下限:" );
    scanf( "%lf" , &a );
    printf( "请输入积分上限:" );
    scanf( "%lf" , &b );
    printf( "选择几点积分?" );
    scanf( "%d" , &n );
    printf( "积分区间为 [%lf,%lf]\n%d 点高斯积分\n理论代数精度为: %d\n" , a , b , n , 2 * n + 1 );
    poly_coefs( n );
    /*
    printf( "%d阶勒让德多项式为:\n", n );
    for (i = 0; i <= n; i++) {
        printf( "%lf ",  );
    }
    printf( "\n" );
    */

    return 0;
}
