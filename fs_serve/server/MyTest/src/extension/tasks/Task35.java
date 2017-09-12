package extension.tasks;

import extension.cards.Card;

/**
 *一位玩家因你的情报宣告胜利时，其面前的黑情报不少于二张
 */
public class Task35 extends TaskBase{

	@Override
	public Boolean check() {
		if(bf.victoryMan!=null && bf.nowGetCards.size()>0 && bf.nowGetCards.get(0).getOwner()==owner){		
			return bf.victoryMan.blackCards.size()>=2;
		}
		return super.check();
	}

}
