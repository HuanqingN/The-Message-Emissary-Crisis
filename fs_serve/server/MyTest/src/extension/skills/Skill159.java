package extension.skills;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

import extension.Player;
import extension.cards.ACard;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.data.DCards;
import extension.data.DCardsChild;
import extension.data.Globle;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;




/**
 * 定税：你的回合开始时以及当你获得情报时，你可以将一张【纳税】洗入牌库。
 * 纳税 黑文本
 * 从牌库抽到该牌后须展示，然后选择一项执行：
 * ①将该牌放置在自己面前。
 * ②将该牌和一张非纳税手牌交给税务局长。（不足则全给）
  **/
public class Skill159 extends Skill {
	//skillType: 0定税 1纳税
	//纳税部分已经在skill162实现，所以这个类里的skillType为1的部分都已经废置了。
	@Override
	public Boolean check() {
			if((getOwner().getIsOpen()==true && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer==getOwner() && !getOwner().getIsDead() && bf.thirdStep!=StepCons.Victory)
					||(getOwner().skillhash.get(this.id).launchCount<1 && selfturn() && bf.nowStep==StepCons.StepBegin)){
				return true;
			}
			return false;
	}
	
	@Override
	public void play(SkillVO tvo) {
//		SmartFoxServer.log.info("type"+tvo.skillType);
		if(tvo.skillType==0){ //执行定税技能，将纳税牌洗入牌库
			super.play(tvo);
			
			ActionscriptObject arr = new ActionscriptObject();
			ArrayList<Card> temp = new ArrayList<Card>();
			int index=(int)(Math.random()*(bf.cards.size()));
			ACard ac=new ACard();
			ac.setId(22);
			ac.setVid(++getOwner().skillhash.get(this.id).nsvid);
			ac.setColor(3);
			ac.setSend(2);
			temp.add(ac);
			
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			tvo.dur=10000;
			bf.setCardsResp(arr, temp);
			tvo.setResponse(obj);
			resp.put("tvo",obj);
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",25);
			resp.putNumber("oid",bf.operId);
			resp.putBool("nashui",false);
			bf.SendToALL(resp);
			
			bf.cards.add(index, ac);
			Collections.shuffle(bf.cards);//洗牌
			bf.cardsMap.put(getOwner().skillhash.get(this.id).nsvid, ac);
			bf.waitfor(4500);
		}else{//有玩家抽到纳税牌（skillType==1）
//			tvo.target=bf.drawingPlayer.getUid();
			super.play(tvo);
			Card ca = null; //纳税牌
			for(Card c: bf.drawingPlayer.handcards){
				if(c.getId()==22){
					ca=c;
					break;
				}
			}
			
			ActionscriptObject obj=new ActionscriptObject();
			ArrayList<Card>temp2 = new ArrayList<Card>();
			for(Card c: bf.drawingPlayer.handcards){
				if(c.getId()!=22){
					temp2.add(c);
				}
			}
			ActionscriptObject arr2 = new ActionscriptObject();
			ActionscriptObject resp2=new ActionscriptObject();
//			ActionscriptObject obj2=new ActionscriptObject();
			bf.setCardsResp(arr2, temp2);
			tvo.dur=10000;
			tvo.setResponse(obj);
			resp2.put("tvo",obj);
			resp2.putNumber("h",2);
			resp2.putNumber("f",25);
			resp2.putNumber("oid",bf.operId);
			resp2.put("cards",arr2);
			resp2.putBool("nashui",true);
			resp2.putNumber("targetuid", tvo.target);
			bf.SendToALL(resp2);
			
			if(getOwner().getIsDead()){
				bf.waitfor(0);
				getInfo(ca);
			}else{
				bf.sResult.dispose();
				bf.waitfor(10000);
				userSelected(bf.sResult, ca);
			}
		}
	}
	
	
	public void userSelected(SelectVO svo, Card ca){
		if (ca == null)return;
		else{
			Player target = bf.roleMap.get(getTvo().target);//抽到纳税的人
			Player sponsor = getOwner();//税务局长
			if(svo.type!=1){//玩家选择放置
				getInfo(ca);
			}else{//玩家选择交出
				ArrayList<Card> giveJuzhang = new ArrayList<Card>();
				if(svo.cards==null){//若玩家没有选牌
//					svo.cards=new ArrayList<Integer>();
					int notnsc = 0;//手里的纳税数目 not nashui count
					ArrayList<Integer> index = new ArrayList<Integer>(); //非纳税牌在手里的index的数组
					for (int i = 0; i <target.handcards.size(); i++){
						if(target.handcards.get(i).getId()!=22){
							index.add(i);
							notnsc++;
						}
					}
					if(notnsc == 0){//玩家手里只有纳税牌
						//只交出纳税牌
						giveJuzhang.add(ca);
					}else{//玩家手里不只有纳税牌
						//交出纳税牌和一张随机手牌
						giveJuzhang.add(ca);
						int random = (int)(Math.random()*(index.size()));
						giveJuzhang.add(target.handcards.get(random));
					}
				}else{//若玩家选了牌
					giveJuzhang.add(ca);
					Card c =target.handcards.get(svo.cards.get(0));
					giveJuzhang.add(c);
				}
				target.removeCardFromHand(giveJuzhang,false);
				getOwner().addToHand(giveJuzhang);
			
				ActionscriptObject resp=new ActionscriptObject();
				ActionscriptObject arr=new ActionscriptObject();
				bf.setCardsResp(arr, giveJuzhang);
				resp.putNumber("from",target.getUid());
				resp.putNumber("to",getOwner().getUid());
				resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5情报到库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
				resp.put("cards",arr);
				resp.putNumber("h",2);
				resp.putNumber("f",27);
				bf.SendToALL(resp);
				bf.waitfor(2000);
			}
		}
	}
	
	public void getInfo(Card ca){
		Player target = bf.roleMap.get(getTvo().target);//抽到纳税的人
		target.removeCardFromHand(ca.getVid(), false);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(ca);
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getTvo().target);
		resp.putNumber("to",getTvo().target);
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5情报到库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.getCard(target,temp, 1);
		bf.waitfor(2000);
		bf.drawCard(target, bf.getCardFromCardPack(1), 1, null);
		bf.waitfor(1000);
	}
}
