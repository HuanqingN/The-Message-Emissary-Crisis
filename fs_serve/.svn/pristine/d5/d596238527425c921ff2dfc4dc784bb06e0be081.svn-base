import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class Test {
	public static void main(String[] args) {
//		int[] result=new int[4];
//		System.out.println(result[1]);
//		Dog d=null;
//		
//		System.out.println(Animal.launchcount);
		//查找以Java开头,任意结尾的字符串
		int uid=2;
		  Pattern pattern = Pattern.compile(uid+"_.*");
		  Matcher matcher = pattern.matcher("a1_100,4_20,3_11,2_123");
		  if(matcher.find()){
			  System.out.println(matcher.groupCount());
			  System.out.println(matcher.group(0));
			  String s=matcher.group(0);
			  s=s.substring(s.indexOf("_")+1,s.length());
			  System.out.println(s);
			  String nstr=matcher.replaceAll(2+"_"+(Integer.valueOf(s)+1));
			  System.out.println(nstr);
		  }
//		  boolean b= matcher.matches();
//		  //当条件满足时，将返回true，否则返回false
//		  System.out.println(b);
//		  Pattern pattern1 = Pattern.compile("[, |]+");
//		  String[] strs = pattern1.split("Java Hello World  Java,Hello,,World|Sun");
//		  for (int i=0;i<strs.length;i++) {
//		      System.out.println(strs[i]);
//		  } 
		  
//		  Pattern pattern = Pattern.compile("href=\"(.+?)\"");
//		  Matcher matcher = pattern.matcher("<a href=\"index.html\">主页</a>");
//		  if(matcher.find()){
//		    System.out.println(matcher.group(0));
//		  }
//		String ssss="1,2,3,4,5,6,7,8,9";
//	String[] str=ssss.split(",");
//	System.out.println(str.length);
//	String[] temp=new String[15];
//System.arraycopy(str, 0, temp, 0, str.length);		
//for(String s:temp){
//	System.out.println(s);
//}
//temp[10]="0";
//		ArrayList<Integer> temp=new ArrayList<Integer>();
//		temp.add(1);
//		temp.add(2);
//		temp.add(3);
//		temp.add(4);
//		temp.add(5);
//		temp.add(6);
//		temp.add(7);
//		temp.add(8);
//		temp.add(9);
//		temp.add(10);
////		ArrayList<Integer> aaa=(ArrayList<Integer>)temp.clone();
//		ArrayList<Integer> aaa=new ArrayList<Integer>();
//				aaa.addAll(temp.subList(temp.size()-5, temp.size()));
//		Collections.reverse(aaa);
//		System.out.println(aaa);
//		System.out.println(temp);
//		System.out.println(temp.size());
	}
	public void AAA(){
		
	}
	public void BBB(){
		System.out.println("调用了BBB()");
		CCC();
	}
	public void CCC(){
		System.out.println("调用了CCC()");
		End();
	}
	
	public void End(){
		System.out.println("调用了End()");
	}
}
