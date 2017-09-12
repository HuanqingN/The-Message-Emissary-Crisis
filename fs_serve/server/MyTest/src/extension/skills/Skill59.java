package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**隔墙有耳**/
public class Skill59 extends Skill {

	@Override
	public Boolean check() {
		if(bf.thirdStep==0 && bf.subStep==StepCons.CardSettlement && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).disabled==false && ((TargetVO)bf.nowSettlement).sponsor==getOwner().getUid()){
			int cindex=bf.cardsMap.get(((TargetVO)bf.nowSettlement).cvid).getId();
			if(cindex>=13 && cindex<=18)return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		ArrayList<Card> cards=bf.getCardFromCardPack(2);
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
		resp.putNumber("oid",bf.operId);
		for(Player p:bf.roleSeq){
			if(p.getUid()==getOwner().getUid()){
				resp.put("cards", arr);
			}else{
				resp.putNumber("num", cards.size());
			}
			bf.trigger.sendResponse(resp, -1, null, p.getChannel());
			resp.removeElement("cards");
		}
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult);
	}
	
	public void userSelected(SelectVO svo){
		bf.isExcute=true;
		if(svo.type==0){
			int num=getOwner().handcards.size();
			svo.card=getOwner().handcards.get((int)Math.floor(Math.random()*num)).getVid();
		}
		Card card=bf.cardsMap.get(svo.card);
		getOwner().removeCardFromHand(svo.card,false);
		bf.cards.addFirst(card);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		card.setResponse(ca);
		arr.put(0,ca);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("type",5);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		goNext();
	}
	
}
