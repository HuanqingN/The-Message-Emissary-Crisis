package extension.tasks;

import java.util.ArrayList;
import java.util.Arrays;

import extension.cards.Card;

/**
 *手里集齐五张名字相同的卡牌（公开文档均视为相同，试探均视为相同）
 */
public class Task39 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead()){
//			ArrayList<Integer> temp=new ArrayList<Integer>();
			int[] temp1=new int[owner.handcards.size()];
			if(owner.handcards.size()>=5){
				for(int i=0; i<owner.handcards.size(); i++){
					int j=owner.handcards.get(i).getId();
					if(j>=13 && j<=18)j=13;
					if(j>=19)j=19;
					temp1[i]=j;
				}
			}
			Arrays.sort(temp1);
			int count = 1;
			int longest = 0;
			int mode = 0;
			for (int i = 0; i < temp1.length - 1; i++) {
				if (temp1[i] == temp1[i + 1]) {
				count++;
				} else {
				count = 1;//如果不等于，就换到了下一个数，那么计算下一个数的次数时，count的值应该重新符值为一
				continue;
				}
				if (count > longest) {
				    mode = temp1[i];
				    longest = count;
				    }
			}
			return longest>=5;
		}

		return super.check();
	}
}
