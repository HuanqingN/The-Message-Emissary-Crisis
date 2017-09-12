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
 *  纳税 黑文本
 * 从牌库抽到该牌后须展示，然后选择一项执行：
 * ①将该牌放置在自己面前，然后抽一张牌；
 * ②将该牌和一张非纳税手牌交给税务局长。
  **/
public class Skill162 extends Skill {
	public Skill162(){
		auto = true;
	}
	@Override
	public Boolean check() {
		if(bf.thirdStep==StepCons.AfterDrawFromDeck){
			SmartFoxServer.log.info("Check Skill162");
			return true;
		}
		return false;
	}
	
	@Override
	public void play(SkillVO tvo) {
		tvo.sponsor=getOwner().getUid();
		tvo.target=bf.drawingPlayer.getUid();
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
		/*要给另一张手牌的版本
		for(Card c: bf.drawingPlayer.handcards){
			if(c.getId()!=22){
				temp2.add(c);
			}
		}
		*/
		
		//----不给另一张手牌的版本----
		for(Card c: bf.drawingPlayer.handcards){
			if(c.getId()==22){
				temp2.add(c);
			}
		}
		//-----------------------------
		
		ActionscriptObject arr = new ActionscriptObject();
		ActionscriptObject resp=new ActionscriptObject();
		bf.setCardsResp(arr, temp2);
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.put("cards",arr);
		resp.putBool("nashui",true);
		resp.putNumber("targetuid", tvo.target);
		bf.SendToALL(resp);
		
		if(getOwner().getIsDead()){
			bf.waitfor(1000);
			getInfo(ca);
		}else{
			bf.sResult.dispose();
			bf.waitfor(10000);
			userSelected(bf.sResult, ca);
		}
	}
	
	
	public void userSelected(SelectVO svo, Card ca){
		/*要给另一张手牌的版本
		if (ca == null)return;
		else{
			Player target = bf.roleMap.get(getTvo().target);//抽到纳税的人
			Player sponsor = getOwner();//税务局长
			if(svo.type==0){//玩家选择放置
				getInfo(ca);
			}else{//玩家选择交出
				SmartFoxServer.log.info("玩家选择交出");
				ArrayList<Card> giveJuzhang = new ArrayList<Card>();
				if(svo.cards==null){//若玩家没有选牌
					int notnsc = 0;//手里的非纳税数目 not nashui count
					ArrayList<Integer> index = new ArrayList<Integer>(); //非纳税牌在手里的index的数组
					int i = 0;
					for (Card c : target.handcards){
						if(c.getId()!=22){
							index.add(i);
							notnsc++;
						}
						i ++;
					}
					if(notnsc == 0){//玩家手里只有纳税牌
						//只交出纳税牌
						giveJuzhang.add(ca);
					}else{//玩家手里不只有纳税牌
						//交出纳税牌和一张随机手牌
						giveJuzhang.add(ca);
						int random = (int)(Math.random()*(index.size()));
						giveJuzhang.add(target.handcards.get(index.get(random)));
					}
				}else{//若玩家选了牌
					giveJuzhang.add(ca);
					Card c =bf.cardsMap.get(svo.cards.get(0));
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
				*/
		if (ca == null)return;
		else{
			Player target = bf.roleMap.get(getTvo().target);//抽到纳税的人
			Player sponsor = getOwner();//税务局长
			if(svo.type==0){//玩家选择放置
				getInfo(ca);
			}else{//玩家选择交出
				SmartFoxServer.log.info("玩家选择交出");
				ArrayList<Card> giveJuzhang = new ArrayList<Card>();
				giveJuzhang.add(ca);
				
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
		bf.getCard(target,temp, 4);
		bf.waitfor(2000);
//		if(target.getIsDead()==false){
//			bf.drawCard(target, bf.getCardFromCardPack(1), 1, null);
//			bf.waitfor(1000);
//		}
	}
}
