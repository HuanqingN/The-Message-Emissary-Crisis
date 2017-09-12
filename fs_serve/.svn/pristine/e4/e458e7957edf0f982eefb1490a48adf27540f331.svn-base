package extension.tasks;

/**
 *通过迷局使一位玩家获得胜利
 */
public class Task29 extends TaskBase{
	@Override
	public Boolean check() {
		if(bf.victoryMan!=null && bf.nowGetCards.size()>0 && bf.nowGetCards.get(0).byMiju==true){		
			return true;
		}
		return super.check();
	}
}
