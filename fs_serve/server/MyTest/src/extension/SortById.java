package extension;

import java.util.Comparator;

public class SortById implements Comparator<UserRoom>{
	 public int compare(UserRoom o1, UserRoom o2) {
		  if (o1.getUserlist().size() > o2.getUserlist().size())
		   return 1;
		  return 0;
	}
}
