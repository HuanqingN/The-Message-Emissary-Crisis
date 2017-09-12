package extension.tasks;

import extension.Player;
import extension.cons.StepCons;

/**
 *一位潜伏玩家和一位军情玩家死亡
 */
public class Task9  extends TaskBase{

	@Override
	public Boolean check() {
//		if(bf.deadman!=null){
		if(bf.thirdStep==StepCons.AfterDeadTaskCheck || bf.thirdStep==StepCons.Victory){
			int a=0;
			int b=0;
			for(Player p:bf.roleSeq){
				if(p.getIsDead() && p.getIndentity()==0)a++;
				if(p.getIsDead() && p.getIndentity()==1)b++;
			}
			return (a>0 && b>0);
		}
		return super.check();
	}

}
