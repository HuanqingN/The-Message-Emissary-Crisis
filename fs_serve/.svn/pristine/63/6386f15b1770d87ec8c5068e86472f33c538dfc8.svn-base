package extension.skills;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *鹰眼：你的抽牌阶段，你可以放弃抽牌，改为展示牌库顶的三张牌并获得之。若其中有锁定，你再额外抽一张牌，然后将一张手牌放回牌库顶
 */
public class Skill152 extends Skill {

	@Override
	public Boolean check() {
		if(bf.nowPlayer.getIsDead()==false && bf.nowPlayer.isLost==false && bf.nowPlayer==getOwner() && bf.nowStep==StepCons.DealingSingle && bf.thirdStep==0){
			return true;
		}
		return super.check();
	}

	Boolean b=false;
	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().isSkipDealing=true;
		
		ArrayList<Card> cards=bf.getCardFromCardPack(3);
		bf.cards.addAll(0, cards);
		ActionscriptObject arr=new ActionscriptObject();
		int index=0;
		for(Card c:cards){
			ActionscriptObject o=new ActionscriptObject();
			c.setResponse(o);
			arr.put(index++,o);
			if(!b){
				if(c.getId()==1)b=true;
			}
		}
		
//		playAni(false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.put("cards",arr);
//		resp.putBool("goOn", b);
		bf.SendToALL(resp);
		bf.waitfor(2500);
		drawCard();
	}
	
	public void drawCard(){
		bf.drawCard(getOwner(),bf.getCardFromCardPack(b?4:3) , 1, null); //OK?嗯
		bf.waitfor(1500);
		if(b){
			ActionscriptObject resp1=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			ActionscriptObject arr1=new ActionscriptObject();
			getTvo().dur=10000;
			getTvo().setResponse(obj);
			resp1.put("tvo",obj);
			resp1.putNumber("h",2);
			resp1.putNumber("f",25);
			resp1.putBool("goOn", true); //that is ok?不行吧，why
			resp1.putNumber("rid", getOwner().getRoleId());
			resp1.putNumber("oid",bf.operId);
			resp1.put("cards", arr1);
			bf.SendToALL(resp1);
			drawCardEnd();
		}
//		bf.waitfor(b?11500:1500);
	}
	public void drawCardEnd(){
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
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
		b=false;
		bf.waitfor(2000);
		
	}
}
