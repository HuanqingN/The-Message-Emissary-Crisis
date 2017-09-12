package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;


/**英雄本色**/
public class Skill20 extends Skill {
	public Skill20(){
		auto=true;
	}
	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer==getOwner() && !getOwner().getIsDead()){
			for(Card c:bf.nowGetCards){
				if(c.getColor()>2)return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
//		if(getOwner().getIsDead() && bf.thirdStep==StepCons.BeforeDead){
//			SkillVO s=new SkillVO();
//			s.sponsor=getOwner().getUid();
//			s.sid=55;
//			getOwner().skillhash.get(55).play(s);
//			getOwner().skillhash.get(this.id).launchCount++;
//			bf.waitfor(3000);
////			getOwner().setIsDead(false);
////			bf.willDead=null;
////			bf.deadman.removeLast();
//			if(bf.VictoryInfoSettlement(getOwner())){  //判断收集收报胜利
//				bf.VictoryExcute(getOwner());
//				return;
//			}
//		}
		
		
		ArrayList<Card> cards=bf.getCardFromCardPack(2);
		getOwner().addToHand(cards);
		Boolean haveBlackCard=false;
		for(Card c:getOwner().handcards){
			if(c.getColor()>2){
				haveBlackCard=true;
				break;
			}
		}
		
		
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
		resp.putBool("pass",!haveBlackCard);
		for(Player p:bf.roleSeq){
			resp.putNumber("oid",bf.operId);
			if(p.getUid()==getOwner().getUid()){
				resp.put("cards", arr);
			}else{
				resp.putNumber("num", cards.size());
			}
			bf.trigger.sendResponse(resp, -1, null, p.getChannel());
			resp.removeElement("cards");
		}
		
		if(haveBlackCard){
			bf.sResult.dispose();
			bf.waitfor(10*1000);
			userSelected(bf.sResult);
		}else{
			goNext();
		}
	}
	
	public void userSelected(SelectVO svo){
		if(svo.type==0 || svo.card==0){
			return;
		}
		Card card=bf.cardsMap.get(svo.card);
		getOwner().removeCardFromHand(svo.card,false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		card.setResponse(ca);
		arr.put(0,ca);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",svo.target);
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("SkillID",this.id);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(3000);
		excuteSkill(svo);
		
	}
	public void excuteSkill(SelectVO svo){
		Player target=bf.roleMap.get(svo.target);
		ArrayList<Card> cards=new ArrayList<Card>();
		cards.add(bf.cardsMap.get(svo.card));
		bf.getCard(target, cards, 1);
//		if(launchCount>0){
//			getOwner().setIsDead(true);
////			bf.willDead=getOwner();
//			bf.deadman.add(getOwner());
//		}
	}
}
