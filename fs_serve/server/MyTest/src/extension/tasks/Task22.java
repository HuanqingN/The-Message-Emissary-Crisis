package extension.tasks;

import extension.Player;
import extension.cons.StepCons;

/**
 *亲手杀死一位酱油玩家，或者潜伏与军情其中一方全灭
 */
public class Task22 extends TaskBase{
	@Override
	public Boolean check() {
		if((bf.thirdStep==StepCons.AfterDeadTaskCheck || bf.thirdStep==StepCons.Victory) && bf.nowGetCards.size()>0 && bf.nowGetCards.get(0).getOwner()==owner && !owner.getIsDead()){
			if(bf.deadman != null && bf.deadman.getIndentity()==2){
				return true;
			}
		}	
		
		if(bf.thirdStep==StepCons.AfterDeadTaskCheck || bf.thirdStep==StepCons.Victory){
			int a=0;
			int b=0;
			for(Player p:bf.roleSeq){
				if(!p.getIsDead() && p.getIndentity()==0)a++;
				if(!p.getIsDead() && p.getIndentity()==1)b++;
			}
		return (a==0 || b==0);
		}
		return false;
	}
}
