class A{
	public static void main (String [] args)	{		
		int i[ ] = {1,2,3};
		int c;
		try{
			c=10/0;
			System.out.println(c + "  "+ i[4]);
			return;

		}catch (ArrayIndexOutOfBoundsException e)	{
			 System.out.println("Don't you know arrays" );
			 return;
		}catch (ArithmeticException e) {
			 System.out.println("Don't you know  math" );
		}
      catch (Exception e) {
			 System.out.println("Generic catch all" );
		
		}finally{
			System.out.println("hi");
}

		System.out.println ("we are done");
	}
}
