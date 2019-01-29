#include<stdio.h>
#include<math.h>

int main()
{
   int t = 2;
   int i;
   int count;
   int x = 0;
   int res[30]={0};
   while(t<=100)
      {
        count = 1;
        i = 2;
        while(i<t)
           {
              if(t%i == 0)
                 {
                  count=0;
                  break;
                 }
               i++;
           }
        if(count == 1)
         res[x++] = t; 
        t++;
      }


}
