package extension.skills;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *猎杀：当你成功使用锁定时，你可以展示牌库顶的第一张牌，若为黑色，你可以在该玩家面前放置一张黑情报（每回合限发动一次）
 *猎杀（旧版）：当你成功使用锁定时，你可以展示牌库顶的第一张牌，并检视目标的手牌，若其中有与被展示牌名字相同（试探均视为相同）的卡牌，你可以在该玩家面前放置一张黑情报
 */
public class Skill153 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount>0) return false;
		if(bf.thirdStep==0 && bf.subStep==StepCons.CardSettlement && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).disabled==false && ((TargetVO)bf.nowSettlement).sponsor==getOwner().getUid()){
			if(bf.cardsMap.get(((TargetVO)bf.nowSettlement).cvid).getId()==1)return true;
		}
		return false;
	}

	
	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		tvo.target=((TargetVO)bf.nowSettlement).target;
		ArrayList<Card> cards=bf.getCardFromCardPack(1);
		boolean isBlack=false;//展示牌是否为黑色
		isBlack=cards.get(0).getColor()>=3?true:false;
		bf.cards.addAll(0, cards);
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, cards);
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.put("cards",arr);
		resp.putBool("goOn", isBlack);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		if(isBlack){
			bf.waitfor(12500);
			userSelected(bf.sResult);
		} else bf.waitfor(2500);
	}

	/*
	 * svo.type: 0=放置 1=不放置
	 */
	private void userSelected(SelectVO svo) {		
		Player target=bf.roleMap.get(getTvo().target);
//		if(svo.cards==null || svo.cards.size()==0 || !hasCardColor(6, getOwner())){
//			return;
//		}
		if(svo.type==1) return;
		ArrayList<Card> temp=bf.getCardFromCardPack(1);
		temp.get(0).setOwner(getOwner());
//		Card card=bf.cardsMap.get(svo.cards.get(0));
//		getOwner().removeCardFromHand(card.getVid(),false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
//		resp.putNumber("from",getOwner().getUid());
//		resp.putNumber("to",target.getUid());
		resp.putNumber("from",target.getUid());
		resp.putNumber("type",9); //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5手卡到牌库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
//		bf.waitfor(2500);
		bf.waitfor(2000);
//		ArrayList<Card> temp=new ArrayList<Card>();
//		temp.add(card);
		
		bf.getCard(target, temp, 1);
		getOwner().skillhash.get(this.id).launchCount++;
	}
		
}


/*以下是旧版猎杀代码*/
//public class Skill153 extends Skill {
//
//	@Override
//	public Boolean check() {
//		if(bf.thirdStep==0 && bf.subStep==StepCons.CardSettlement && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).disabled==false && ((TargetVO)bf.nowSettlement).sponsor==getOwner().getUid()){
//			if(bf.cardsMap.get(((TargetVO)bf.nowSettlement).cvid).getId()==1)return true;
//		}
//		return false;
//	}
//
//	int scid=0;//showCardID被展示牌的id
//	@Override
//	public void play(SkillVO tvo) {
//		super.play(tvo);
////		getOwner().skillhash.get(this.id).launchCount++;
////		bf.nowSettlement.target
//		tvo.target=((TargetVO)bf.nowSettlement).target;
////		Player target=bf.roleMap.get(tvo.target);
//		ArrayList<Card> cards=bf.getCardFromCardPack(1);
//		scid=cards.get(0).getId();
//		bf.cards.addAll(0, cards);
//		ActionscriptObject arr=new ActionscriptObject();
//		int index=0;
//		for(Card c:cards){
//			ActionscriptObject o=new ActionscriptObject();
//			c.setResponse(o);
//			arr.put(index++,o);
//		}
//		
//		ActionscriptObject resp=new ActionscriptObject();
//		ActionscriptObject obj=new ActionscriptObject();
//		ActionscriptObject arr2=new ActionscriptObject();
//		LinkedList<Card> temp=bf.roleMap.get(tvo.target).handcards;
//		bf.setCardsResp(arr2, temp);
//		
//		tvo.dur=10000;
//		tvo.setResponse(obj);
//		resp.put("tvo",obj);
//		resp.putNumber("h",2);
//		resp.putNumber("f",25);
//		resp.putNumber("oid",bf.operId);
//		resp.put("cards",arr);
//		resp.put("cards2",arr2);
//		bf.SendToALL(resp);
//		bf.sResult.dispose();
//		bf.waitfor(11500);
//		chooseCard();
//	}
//	
//	public void chooseCard(){//将进入等待选择要放置的黑情报
//		Player target=bf.roleMap.get(getTvo().target);
//		ActionscriptObject resp1=new ActionscriptObject();
//		ActionscriptObject obj=new ActionscriptObject();
//		ActionscriptObject arr1=new ActionscriptObject();
//		ArrayList<Card> snc=new ArrayList<Card>();//snc=sameNameCards
//		getTvo().dur=10000;
//		getTvo().setResponse(obj);
//		resp1.put("tvo",obj);
//		resp1.putNumber("h",2);
//		resp1.putNumber("f",25);
//		resp1.putBool("goOn", true); 
//		resp1.putNumber("oid",bf.operId);
//		resp1.put("cards", arr1);
//		
//		if(target.handcards.size()>0){
////			ActionscriptObject arr1=new ActionscriptObject();
////			ArrayList<Card> snc=new ArrayList<Card>();//snc=sameNameCards
//			for(Card ca:target.handcards){
//				if(scid>=13 && scid<=18){
//					if(ca.getId()>=13 && ca.getId()<=18)
//						snc.add(ca);
//				}else if(scid>=19 && scid<=21){
//					if(ca.getId()>=19 && ca.getId()<=21)
//						snc.add(ca);
//				}else{
//					if(ca.getId()==scid)
//						snc.add(ca);
//				}
//			}	
//			if(snc.size()>0 && getOwner().skillhash.get(this.id).launchCount<1){
//				bf.setCardsResp(arr1, snc);
//				resp1.put("cards1",arr1);
//			}
//		
//		bf.SendToALL(resp1);
//		
//		scid=0;
//		if(snc.size()>0 && getOwner().skillhash.get(this.id).launchCount<1){
//			bf.sResult.dispose();
//			bf.waitfor(10000);
//			userSelected(bf.sResult);
//		}else{
////			bf.waitfor(1500);
//		}
//	}
//}
//
//	private void userSelected(SelectVO svo) {
////		Player target=bf.roleMap.get(getTvo().target);
////		if(svo.cards==null){
////			return;
////		}
////
////		ArrayList<Card> temp=new ArrayList<Card>();
////		for(Integer i:svo.cards){
////			temp.add(bf.cardsMap.get(i));
////		}
////		bf.disCard(target, temp, 1,null);
////		bf.waitfor(2000);
//		
//		
//		Player target=bf.roleMap.get(getTvo().target);
//		if(svo.cards==null || svo.cards.size()==0 || !hasCardColor(6, getOwner())){
//			return;
//		}
//		Card card=bf.cardsMap.get(svo.cards.get(0));
//		getOwner().removeCardFromHand(card.getVid(),false);
//		ActionscriptObject resp=new ActionscriptObject();
//		ActionscriptObject ca=new ActionscriptObject();
//		ActionscriptObject arr=new ActionscriptObject();
//		card.setResponse(ca);
//		arr.put(0,ca);
//		resp.putNumber("from",getOwner().getUid());
//		resp.putNumber("to",target.getUid());
//		resp.putNumber("type",3); //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5手卡到牌库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
//		resp.put("cards",arr);
//		resp.putNumber("h",2);
//		resp.putNumber("f",27);
//		bf.SendToALL(resp);
//		
//		bf.waitfor(2500);
//		ArrayList<Card> temp=new ArrayList<Card>();
//		temp.add(card);
//		
//		bf.getCard(target, temp, 1);
//		getOwner().skillhash.get(this.id).launchCount++;
//	}
//		
//}


