package extension.tasks;

import java.util.ArrayList;
import java.util.Arrays;

import extension.cards.Card;

/**
 *��һ�غ��ڳɹ���ͬһ��ɫ�������Ρ��������꡿
 */
public class Task41 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead()){
			for(int i : owner.jifengzhouyu.values()){
				if (i >= 3) return true;
			}
		}
		return super.check();
	}
}
