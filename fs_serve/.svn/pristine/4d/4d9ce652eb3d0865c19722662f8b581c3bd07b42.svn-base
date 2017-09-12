package extension.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Rand {
	public static List getRand(int min,int max,int many){
		List<Integer> temp=new ArrayList<Integer>();
		Random rd = new Random();
		while (temp.size()<many){
			int num = rd.nextInt(max+1-min)+min;
			if(!temp.contains(num)){
				temp.add(num);
			}
		}
		return temp;
	}
}
