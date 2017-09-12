package extension.tasks;

/**
 *使用殉道的效果让另一位玩家死亡
 */
public class Task32 extends TaskBase{
	@Override
	public Boolean check() {
		if(bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer.getIsDead() && bf.nowGetCards.size()>0 && bf.nowGetCards.get(0).byXundao==true){
				return true;
		}
		return super.check();
	}
}
