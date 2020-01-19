

unsigned int converttobinary1(unsigned int num)   
{
	unsigned int res=0;
	unsigned int level=1;
for(int i=0;num>0;i++)    
{    
	
res=((num%2) * level)+res; 
level*=2;   
num=num/2;    
}
return res;
}	
  
 