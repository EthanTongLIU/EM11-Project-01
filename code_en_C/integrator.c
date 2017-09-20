#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define PI 3.14159265358979323846

int n; //����ѡ��ĵ���
double a; //��������
double b; //��������

double poly_value( double *poly , double root ); //���ڼ���һ������ʽ�����ĺ���ֵ

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
    double **p, *Lege, *Lege_D , *Roots, *int_coefs, root_temp, value;
    printf( "�������������:" );
    scanf( "%lf" , &a );
    printf( "�������������:" );
    scanf( "%lf" , &b );
    printf( "ѡ�񼸵����?" );
    scanf( "%d" , &n );
    printf( "\n��������Ϊ:[%lf,%lf]\n%d���˹����\n���۴�������Ϊ: %d\n\n" , a , b , n , 2 * n + 1 );

    //��̬�ڴ���䲢��ʼ��
    p = ( double** )malloc( sizeof( double* ) * ( n + 1 ) );
    for ( i = 0; i <= n; i++ ) {
        p[i] = ( double* )malloc( sizeof( double ) * ( n + 1 ) );
    }
    Lege = ( double* )malloc( sizeof( double ) * ( n + 1 ) ); //���õ¶���ʽ
    Lege_D = ( double* )malloc( sizeof( double ) * ( n + 1 ) ); //���õ¶���ʽ�ĵ�����ʽ
    Roots = ( double* )malloc( sizeof(double) * n ); //���õ¶���ʽ�ĸ�
    int_coefs = ( double* )malloc( sizeof(double) * n ); //��ֵ���ֶ���ʽ��ϵ��

    for (i = 0; i <= n; i++){
        for (j = 0; j <= n; j++){
            p[i][j] = 0;
        }
        Lege[i] = Lege_D[i] = 0;
    }
    for (i = 0; i < n; i++) {
        Roots[i] = int_coefs[i] = 0;
    }

    //�������õ¶���ʽ
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
    printf( "%d�����õ¶���ʽΪ:\n", n );
    for (i = 0; i <= n; i++) {
        printf( "%lf ", Lege[i] );
    }
    printf( "\n\n" );

    //�õ����õ¶���ʽ�ĵ�����ʽ
    for (i = 0; i <= n-1; i++) {
        Lege_D[i] = ( i + 1 ) * Lege[i+1];
    }
    Lege_D[n] = 0;
    printf( "%d�����õ¶���ʽ�ĵ�����ʽΪ:\n", n );
    for (i = 0; i <= n; i++) {
        printf( "%lf ", Lege_D[i] );
    }
    printf( "\n\n" );

    //����ţ��-����ѷ�������õ� n ����
    for (i = 0; i < n; i++ ) {
        Roots[i] = cos( PI * ( i + 1 - 0.25 ) / ( n + 0.5 ) );
        j = 0;
        while (j <= 100) {
            root_temp = Roots[i] - poly_value( Lege , Roots[i] ) / poly_value( Lege_D , Roots[i] );
            if ( fabs( Roots[i] - root_temp ) > 0.000001 )
                Roots[i] = root_temp;
            else
                break;
            j++;
        }
    }

    printf( "���õ¶���ʽ��%d����Ϊ:\n", n );
    for (i = 0; i < n; i++) {
        printf( "%lf ", Roots[i] );
    }
    printf( "\n\n" );


    //����ֲ�ֵ����ʽ��ϵ�����Ҽ������ֵ
    for (i = 1; i < n; i++) {
        int_coefs[i] = 2 / ( ( 1 - pow( Roots[i] , 2 ) ) * pow( poly_value( Lege_D , Roots[i] ) , 2 ) );
    }
    value = 0;
    for (i = 0; i < n; i++) {
        value += ( b - a ) / 2 * int_coefs[i] * exp( ( b - a ) / 2 * Roots[i] + ( a + b ) / 2 );
    }
    printf( "����ֵ��:%.7lf\n", value );

    //�ͷŶ�̬�ڴ�
    for (i = 0; i <= n; ++i){
        free(p[i]);
    }
    free(p);
    free(Lege);
    free(Lege_D);
    free(Roots);
    free(int_coefs);

    return 0;
}
