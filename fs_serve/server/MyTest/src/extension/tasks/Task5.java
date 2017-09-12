package extension.tasks;

import extension.Player;

/**
 * 当一位玩家宣告胜利时，没有玩家死亡，你的胜利会导致他的宣告失败
 */
public class Task5 extends TaskBase{

	@Override
	public Boolean check() {
		if(bf.victoryMan!=null){
			int b=0;
			for(Player p:bf.roleSeq){
				if(p.getIsDead()){
					b++;
					break;
				}
			}
			if(b==0){
				bf.winners.clear();
				bf.victoryMan=owner;
			}
			return b==0;
		}
		return super.check();
	}

}
