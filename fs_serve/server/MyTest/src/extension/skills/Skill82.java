package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.vo.SkillVO;
/**
 *ÃÔ×Ù
 */
public class Skill82 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && getOwner().getIsOpen()==true && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer==getOwner() && !getOwner().getIsDead()){
			return true;
		}
		return false;
	}
	
	@Override
	public void reset() {
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		getOwner().setIsOpen(false);
		Card c=bf.getCardFromCardPack();
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(c);
		getOwner().addToHand(c);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("cards",arr);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		bf.SendToALL(resp);
		bf.waitfor(6000);
	}
	
}
