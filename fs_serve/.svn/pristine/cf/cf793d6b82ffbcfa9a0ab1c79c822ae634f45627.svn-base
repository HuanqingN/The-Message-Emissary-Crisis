package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;

/**运筹帷幄
 * 当你获得情报时，你可以抽一张牌
**/
public class Skill18 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead())return false;
		if(bf.nowGetCards.size()>0 && bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer==getOwner() && bf.thirdStep!=StepCons.Victory){
			if(!bf.nowGetCardPlayer.getIsDead())
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		ArrayList<Card> cards=bf.getCardFromCardPack(1);
		getOwner().addToHand(cards);
		ActionscriptObject arr=new ActionscriptObject();
		int index=0;
		for(Card c:cards){
			ActionscriptObject o=new ActionscriptObject();
			c.setResponse(o);
			arr.put(index++,o);
		}
		
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",1);
		for(Player p:bf.roleSeq){
			if(p.getUid()==getOwner().getUid()){
				resp.put("cards", arr);
			}else{
				resp.putNumber("num", cards.size());
			}
			bf.trigger.sendResponse(resp, -1, null, p.getChannel());
			resp.removeElement("cards");
		}
		
		goNext();
	}
	
}
