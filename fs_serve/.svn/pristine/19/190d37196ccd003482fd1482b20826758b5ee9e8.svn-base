package extension.tasks;

import extension.Player;

/**
 *在已有玩家死亡的情况下，集齐九张手牌
 */
public class Task20 extends TaskBase{
	@Override
	public Boolean check() {
		if(!owner.getIsDead() && owner.handcards.size()>=9){
			int d=0;
			for(Player p:bf.roleSeq){
				if(p.getIsDead()){
					d++;
				}
			}
			return d>0;
		}		
		return super.check();
	}
}
