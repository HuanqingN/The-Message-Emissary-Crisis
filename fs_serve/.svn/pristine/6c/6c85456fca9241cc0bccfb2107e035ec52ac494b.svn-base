package extension.skills;

import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;


/**
 *一箭双雕
 */
public class Skill74 extends Skill {
	public Skill74(){
		auto=true;
	}
	@Override
	public Boolean check() {
		if(bf.nowStep==StepCons.InfoReceive && bf.skillstep==0 && bf.nowGetCards.size()>0 && selfturn() && bf.thirdStep!=StepCons.Victory){
			Boolean b=false;
			for(Card c:bf.nowGetCards){
				if(c.getColor()>2){
					b= true;
					break;
				}
			}
			return b;
		}
		return false;
	}
	
	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
//		getOwner().skillhash.get(this.id).launchCount++;
		Card c=bf.getCardFromCardPack();
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(c);
		getOwner().addToHand(c);
		boolean boo=hasCardColor(6, getOwner());
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		tvo.target=bf.nowGetCardPlayer.getUid();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("cards",arr);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("hasBlack",boo);
		bf.SendToALL(resp);
		
		if(boo){
			bf.sResult.dispose();
			bf.waitfor(10*1000);
			userSelected(bf.sResult);
		}else{
			bf.waitfor(1500);
		}
	}
	public void userSelected(SelectVO svo){
		if(svo.type==0)return;
		if(svo.card==0 || svo.target==0){
			for(Card c:getOwner().handcards){
				if(c.getColor()>2){
					svo.card=c.getVid();
					break;
				}
				svo.target=getOwner().getUid();
			}
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
		
		bf.waitfor(2000);
		
		Player target=bf.roleMap.get(svo.target);
		ArrayList<Card> cards=new ArrayList<Card>();
		cards.add(card);
		bf.getCard(target, cards, 1);	
	}
}
