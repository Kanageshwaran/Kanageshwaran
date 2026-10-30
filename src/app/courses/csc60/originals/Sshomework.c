#include <stdio.h>
#include <math.h>


double area(double, double);

int main(){
    double a = 0 ;
    double b = 0 ;
    double c = 0 ;

    printf("please insert value for a: ");
    scanf("%lf" ,&a);
    printf("please insert value for b: ");
    scanf("%lf" ,&b);

    c = (a*a)+(b*b);
    c= sqrt(c);
    c =round(c);

    printf("value of C: %.lf\n", c);
    printf("area of the triangle: %.3lf\n", area(a,b));

    return 0;
}
