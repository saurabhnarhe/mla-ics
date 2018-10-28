import java.util.*;
public class CRT_JAVA {
 
    public static int chineseRemainder(int[] n, int[] a, int l) {
 
        // Compute product of all numbers 
        int M = 1; 
        for (int i = 0; i < l; i++) 
            M *= n[i]; 
  
        int p, sm = 0;
        for (int i = 0; i < n.length; i++) {
            p = M / n[i];
            sm += a[i] * mulInv(p, n[i]) * p;
        }
        return sm % M;
    }
 
    private static int mulInv(int a, int b) {
        int b0 = b;
        int x0 = 0;
        int x1 = 1;
 
        if (b == 1)
            return 1;
 
        while (a > 1) {
            int q = a / b;
            int amb = a % b;
            a = b;
            b = amb;
            int temp = x1 - q * x0;
            x1 = x0;
            x0 = temp;
        }
 
        if (x1 < 0)
            x1 += b0;
 
        return x1;
    }
 
    public static void main(String[] args) {
        int[] n = {3, 5, 7};
        int[] a = {2, 3, 2};
        int l=3;
        System.out.println("The Value of X is : "+chineseRemainder(n, a, l));
    }
}
