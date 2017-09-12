package extension.tasks;
/**
 *一回合内亲手杀死两个玩家
 */
public class Task18 extends TaskBase{
	@Override
	public Boolean check() {
		if(bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer.getIsDead() && !owner.getIsDead() && bf.nowGetCards.get(0).getOwner()==owner){
			if(owner.nowTurnKillCount>=2){
				return true;
			}
		}
		return super.check();
	}
}
