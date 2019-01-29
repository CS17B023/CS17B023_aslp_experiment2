int IsEven(int n)
{
   if ((n%2) == 0)
      return 1;
   else 
      return 0;
}


int IsPrime(int n)
{
    int count = 1;
        for(int i=2;i<=n/2;i++)
        {
              if(n%i==0)
                  {
                    count = 0;
                    break;
                  }
        }
    if(count == 1)
        return 1;
    else
       return 0;
}

int op(int n)
{
  int m;
  if(IsPrime(n) == 1)
      {
        m = 1;
      }
  else 
    m = -1;
  if(m == -1)
     {
       if(IsEven(n) == 1)
          m = 2;
       else
          m = 3; 
     }
return m;

}



int main()
{ 
   int n,num,res1,res2,res3,res4,res5,res6,l,m;
   num=481;
   int x = op(num);
   switch(x)
    {
       case 1:
         {
           if(num == 2)
           res1 = 2;
           else
           res1 = num + 1;
           break;
         }
      case 2:
         {
           res2 = num + 1;
           break;
         }
      case 3:
         { 
           
          if(IsPrime(num))
              res3 = num;
          if(!IsEven(num) && !IsPrime(num))
              {
                l = num;
                m = num;
                while(1)
                   {
                     if(IsPrime(l))
                       {
                         break;
                       }
                     else
                       l++;
                   }
                while(1 && m>=2)
                   {
                       if(IsPrime(m))
                         {
                           break ;
                         }
                       else 
                        m--;
                   }
                 if((l-num)>(num-m))
                      {
                        res3 = l;
                      }
                 else
                        res3 = m;
                
              }
           break;
         }
    
    case 4:
         {
          
          break;
         }
  
}
return 0;
}   
