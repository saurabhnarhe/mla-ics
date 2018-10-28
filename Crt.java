import java.util.*;

public class Crt 
{
	public static void main(String[] args) 
	{	
	    Scanner s=new Scanner(System.in);
	    System.out.println("Enter number of values in array");
		int xx=s.nextInt();
	    int m[]=new int[xx];
	    int a[]=new int[xx];
	    
	    System.out.println("\n Enter to m: ");
	    for(int i=0;i<xx;++i)
	    	m[i]=s.nextInt();
	    
	    System.out.println("\n Enter to a: ");
	    for(int i=0;i<xx;++i)
	    	a[i]=s.nextInt();
	    
	    System.out.println("\n The Value of X is : " +crt(m, a));
	}
	public static int crt(int[] m, int[] a) 
	{
		int M=1;
		int p=0;
		int sum=0;
		for (int i = 0; i < m.length; i++)
			M=M*m[i];

		for (int i = 0; i < m.length; i++) 
		{
			p=M/m[i];
			sum += a[i] * mulInv(p, m[i]) * p;
		}
		return sum%M;
	}
	private static int mulInv(int a, int b) {
		int b0 = b;
		int s0 = 0;
		int s1 = 1;
		int temp=0;
		if (b == 1)
			return 1;

		while (a > 1) {
			int q = a / b;
			int amb = a % b;
			a = b;
			b = amb;
			temp = s1 - q * s0;
			s1 = s0;
			s0 = temp;
		}

		if (s1 < 0)
			s1 += b0;

		return s1;
	}
}
