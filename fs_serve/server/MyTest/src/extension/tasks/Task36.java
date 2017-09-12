package extension.tasks;

import extension.cards.Card;

/**
 * 在你面前没有黑情报的前提下  ，亲手杀死一位其他玩家
 */
public class Task36 extends TaskBase{

	@Override
	public Boolean check() {
		if(bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer.getIsDead() && bf.nowGetCards.size()>0 && bf.nowGetCards.get(0).getOwner()==owner){
			if(owner.blackCards.size()==0){
				return true;
			}
		}
		return super.check();
	}

}
