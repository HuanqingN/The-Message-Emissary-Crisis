package extension.skills;

import java.util.ArrayList;

import javax.security.auth.callback.LanguageCallback;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**嗜血**/
public class Skill36 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead())return false;
		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.deadman!=null && bf.thirdStep==StepCons.AfterDead) return true;
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
//		getOwner().skillhash.get(this.id).launchCount++;
		ArrayList<Card> cards=bf.getCardFromCardPack(4);
		bf.roleMap.get(tvo.sponsor).addToHand(cards);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		tvo.dur=6000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",1);
		resp.putNumber("oid",bf.operId);
		int index=0;
		for(Card c:cards){
			ActionscriptObject ca=new ActionscriptObject();
			c.setResponse(ca);
			arr.put(index++, ca);
		}
		for(Player p:bf.roleSeq){
			if(p.getUid()==getOwner().getUid()){
				resp.put("cards",arr);
			}else{
				resp.putNumber("num", 4);
			}
			bf.trigger.sendResponse(resp, -1,null, p.getChannel());
			resp.removeElement("cards");
		}
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult);
	}
	
	public void userSelected(SelectVO svo){
		bf.isExcute=true;
		if(svo.type==0){
			svo.target=bf.getRandomPlayer().getUid();
			int num=getOwner().handcards.size();
			svo.card=getOwner().handcards.get((int)Math.floor(Math.random()*num)).getVid();
		}
		Card card=bf.cardsMap.get(svo.card);
		Player p=bf.roleMap.get(svo.target);
		p.addToHand(card);
		getOwner().removeCardFromHand(svo.card,false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		card.setResponse(ca);
		arr.put(0,ca);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",svo.target);
		resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		goNext();
	}
	
}
