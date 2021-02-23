#include <stdio.h>

int main()
{
    int a, b;
    scanf("%d %d", &a, &b);
    if(a >= b)
    {
        printf("a, %d, is >= b\n", a);
        if(b > 0)
            printf("b, %d, is positive\n", b);
        else
            printf("b, %d, is non-positive\n", b);
    }
    else
    {
        printf("b, %d, is > a\n", b);
        if(a < 0)
            printf("a, %d, is negative\n", a);
        else
            printf("a, %d, is non-negative\n", a);
    }

    if(a % 2 == 0)
    {
        if (b % 2 == 0)
            printf("Both a and b are even\n");
        else
            printf("only a is even\n");
    }
    else if(a % 3 == 0)
    {
        if(b % 3 == 0)
            printf("a mod 3==0, b mod 3==0\n");
        else if(b % 2 == 0)
            printf("a mod 3==0, b mod 2==0\n");
        else
            printf("a mod 3==0, no idea about b");
    }
    else if(a % 5 == 0)
    {
        if(b % 5 == 0)
            printf("a mod 5==0, b mod 5==0\n");
        else if(b % 4 == 0)
            printf("a mod 5==0, b mod 4==0\n");
        else if(b % 3 == 0)
            printf("a mod 5==0, b mod 3==0\n");
        else if(b % 2 == 0)
            printf("a mod 5==0, b mod 2==0\n");
        else
            printf("a mod 5==0, no idea about b");
    }
    else if(a % 7 == 0)
    {
        if (b % 7 == 0)
            printf("a mod 7==0, b mod 7==0\n");
        else if(b % 6 == 0)
            printf("a mod 7==0, b mod 6==0\n");
        else if(b % 5 == 0)
            printf("a mod 7==0, b mod 5==0\n");
        else if(b % 4 == 0)
            printf("a mod 7==0, b mod 4==0\n");
        else if(b % 3 == 0)
            printf("a mod 7==0, b mod 3==0\n");
        else if(b % 2 == 0)
            printf("a mod 7==0, b mod 2==0\n");
        else
            printf("a mod 7==0, no idea about b");
    }
    else if (b % 2 == 0)
        printf("only b is even\n");
    else
        printf("both a and b are odd\n");

    if (a%11 == b%11)
        printf("a mod 11 == b mod 11");
    else if (a%13 == b%13)
        printf("a mod 13 == b mod 13");
    else if (a%17 == b%17)
        printf("a mod 17 == b mod 17");
    else
        printf("No idea");

    return 0;
}