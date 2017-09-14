#include <stdio.h>
#include <malloc.h>
#include <math.h>

#define PI 3.14159265358979323846

int n; //����ѡ��ĵ���
double a; //��������
double b; //��������

double *ploy_coefs( int n ); //���ڵõ�һ�����õ¶���ʽ
//double *poly_coefs_D( double * , int n ); //���ڵõ�һ������ʽ�ĵ�����ʽ
//double value_of_poly( double * ); //���ڼ���һ ������ʽ�����ĺ���ֵ

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
    //��ʼ����ȫ���㻯
    for (i = 0; i <= n; i++){
        for (j = 0; j <= n; j++){
            a[i][j] = 0;
        }
        Temp[i] = 0;
    }
    //�������õ¶���ʽ
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
    printf( "%d�����õ¶���ʽΪ:\n", n );
    for (i = 0; i <= n; i++) {
        printf( "%lf ", Temp[i] );
    }
    printf( "\n" );
    //�ͷŶ�̬���ٵĿռ�
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
    printf( "�������������:" );
    scanf( "%lf" , &a );
    printf( "�������������:" );
    scanf( "%lf" , &b );
    printf( "ѡ�񼸵����?" );
    scanf( "%d" , &n );
    printf( "��������Ϊ [%lf,%lf]\n%d ���˹����\n���۴�������Ϊ: %d\n" , a , b , n , 2 * n + 1 );
    poly_coefs( n );
    /*
    printf( "%d�����õ¶���ʽΪ:\n", n );
    for (i = 0; i <= n; i++) {
        printf( "%lf ",  );
    }
    printf( "\n" );
    */

    return 0;
}
