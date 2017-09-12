package extension;

import java.lang.reflect.InvocationTargetException;

public class BBB {
	public Test test;
	public void aaa(Object... args){
		
	   System.out.println(args[0].getClass());
	}
	
	public Object[] ccc(Object... args){
		return args;
	}
}
