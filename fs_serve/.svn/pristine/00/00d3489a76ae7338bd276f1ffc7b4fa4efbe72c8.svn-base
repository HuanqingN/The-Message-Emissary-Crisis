package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *治愈天籁
 */
public class Skill108 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.nowStep==StepCons.InfoSend && getOwner().getIsOpen()==false && noSkill()){
			for(Player p : bf.roleSeq){
				if(p.isSkip || p.getIsLock())	return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(true);
		playAni(true);
		getOwner().skillhash.get(this.id).launchCount++;
		bf.waitfor(1500);
	}
	
	@Override
	public void excute() {
		if(getOwner().getIsDead()){
			return;
		}
		Player target = bf.roleMap.get(getTvo().target);
		target.isSkip = getOwner().isSkip = false;
		target.setIsLock(false);
		getOwner().setIsLock(false);
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn", true);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}
	
	private void userSelected(SelectVO svo){//type:1探寻分牌 2弃牌盖伏
		if(svo.type==0)svo.type=1;
		switch(svo.type){
		case 1:
			ArrayList<Card> cards=bf.getCardFromCardPack(4);//要展示的牌库顶的四张牌
			ArrayList<Card> cardsLeft = new ArrayList<Card>();//不能被探寻入手牌的，稍后要置入弃牌堆的牌
			cardsLeft.addAll(cards);
			ArrayList<Card> cards2=new ArrayList<Card>();//能选择加入手牌的牌
			for(int i = 0; i < cardsLeft.size(); i++){//构筑cards2
				if(cardsLeft.get(i).getColor() != 3) {
					cards2.add(cardsLeft.remove(i));
					i--;
				}
			}
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			ActionscriptObject arr2=new ActionscriptObject();
			bf.setCardsResp(arr, cards);
			bf.setCardsResp(arr2, cards2);
			
			getTvo().dur=10000;
			getTvo().setResponse(obj);
			resp.put("tvo",obj);
			resp.putNumber("h",2);
			resp.putNumber("f",25);
			resp.putNumber("oid",bf.operId);
			resp.put("cards",arr); //要展示的牌库顶的四张牌
			resp.put("cards2",arr2); //能选择加入手牌的牌
			resp.putBool("tanxun", true);
			bf.SendToALL(resp);
			bf.sResult.dispose();
			bf.waitfor(12000);
			
//			target.addToHand(cardsLeft);//将cardsLeft置入目标手牌
			drawCard(bf.sResult, cards, cards2);
			break;
		case 2:
			ActionscriptObject resp2=new ActionscriptObject();
			resp2.putNumber("h",2);
			resp2.putNumber("f",11);
			resp2.putNumber("oid",bf.operId);
			resp2.putNumber("target",getOwner().getUid());
			resp2.putNumber("time", 10000);
			bf.SendToALL(resp2);
			bf.sResult.dispose();
			bf.waitfor(10*1000);
			DiscardResult(bf.sResult);
			break;
		}
	}
	
	public void drawCard(SelectVO svo, ArrayList<Card> cards, ArrayList<Card> cards2){//抽探寻到的牌
		Player target = bf.roleMap.get(getTvo().target);
		ArrayList<Card> choosed=new ArrayList<Card>();//玩家选择的加到手牌的牌
		ArrayList<Card> dropped = new ArrayList<Card>();//没选的牌
		if(svo.cards != null){
			for(int i : svo.cards){
				choosed.add(bf.cardsMap.get(i));
			}
			ArrayList<Card> temp = new ArrayList<Card>();
			temp.addAll(cards);
			for(Card ca : cards){
				for(int i : svo.cards){
					if(ca.getVid() == i){
						temp.remove(temp.indexOf(bf.cardsMap.get(i)));
					}
				}
			}
			dropped.addAll(temp);
		}else{
			dropped.addAll(cards);
		}
		
//		SmartFoxServer.log.info("dropped.size()="+dropped.size());
		ActionscriptObject resp1=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr3=new ActionscriptObject();
		ActionscriptObject arr4=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		bf.setCardsResp(arr3, choosed);
		bf.setCardsResp(arr4, dropped);
		resp1.put("tvo",obj);
		resp1.putNumber("h",2);
		resp1.putNumber("f",25);
		resp1.putBool("draw", true); 
		resp1.putNumber("oid",bf.operId);
		resp1.put("cards3", arr3);
		resp1.put("cards4", arr4);
		bf.SendToALL(resp1);
		bf.waitfor(6000);
		target.addToHand(dropped);
		getOwner().addToHand(choosed);
	}
	
	public void DiscardResult(SelectVO svo){
		if(svo.card==0){//如果是一1，要自己选择弃的牌
			int num=bf.roleMap.get(getOwner().getUid()).handcards.size();
			num=(int)Math.floor(Math.random()*num);
			svo.card=bf.roleMap.get(getOwner().getUid()).handcards.get(num).getVid();
		}	
		Card ca=bf.cardsMap.get(svo.card);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(ca);
		bf.disCard(getOwner(), temp, 1, null);
		getOwner().setIsOpen(false);
		bf.waitfor(2000);
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("target",bf.nowPlayer.getUid());
		resp.putNumber("iden",bf.nowPlayer.getIndentity());
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("turn", true);
		bf.SendToALL(resp);
		bf.waitfor(1000);
	}
}
