package extension.actions;

import extension.Player;
import extension.cards.Card;
import extension.vo.SelectVO;

public class CardAction extends Action implements ICardAction {
	private int card;
	public Boolean noSkill(){
		return !(bf.skillstep>0);
	}
	public void useEnd() {
		getTvo().dispose();
		bf.waitfor(2000);
//		bf.CardSettlementAnswer();
	}
	@Override
	public void DiscardResult(SelectVO svo) {
	}
	
	public Boolean isAlive(int uid){
		return !bf.roleMap.get(uid).getIsDead();
	}
	
	public Boolean hasInfoCard(int vid,int uid){
		return hasInfoCard(vid,bf.roleMap.get(uid));
	}
	public Boolean hasInfoCard(int vid,Player p){
		Card c=bf.cardsMap.get(vid);
		int index=p.blackCards.indexOf(c);
		if(index<0)index=p.blueCards.indexOf(c);
		if(index<0)index=p.redCards.indexOf(c);
		return index>=0;
	}
}
