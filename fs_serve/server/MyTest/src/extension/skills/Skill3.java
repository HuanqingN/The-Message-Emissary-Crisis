package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**¾Í¼Æ**/
public class Skill3 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsOpen() && bf.subStep==StepCons.CardSettlement && bf.thirdStep==0 && bf.nowSettlement instanceof TargetVO && 
				((TargetVO)bf.nowSettlement).disabled==false && ((TargetVO)bf.nowSettlement).target==getOwner().getUid()){
			int cindex=bf.cardsMap.get(((TargetVO)bf.nowSettlement).cvid).getId();
			if(cindex==1 || (cindex>=13 && cindex<=18))return true;
					
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		ArrayList<Card> cards=bf.getCardFromCardPack(2);
		getOwner().addToHand(cards);
		getOwner().setIsOpen(true);
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
		resp.putNumber("rid", getOwner().getRoleId());
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
