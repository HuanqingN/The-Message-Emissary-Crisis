package extension.tasks;

import java.util.ArrayList;
import java.util.Arrays;

import extension.cards.Card;

/**
 *在一回合内成功对同一角色发动三次【疾风骤雨】
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
