package extension.tasks;

import extension.Player;
import extension.cons.StepCons;

/**
 *你成为第二位或以后死亡的玩家
 */
public class Task11 extends TaskBase{
	@Override
	public Boolean check() {
		if(owner.getIsDead()){
			int b=0;
			for(Player p:bf.roleSeq){
				if(p.getIsDead()){
					b++;
				}
			}
			return b>1;
		}
		return super.check();
	}
}
