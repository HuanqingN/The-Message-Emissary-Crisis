package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *复仇 当你收到传出的黑情报时，你可以把一张黑色手牌给情报发出者作为情报
 */
public class Skill126 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead())return false;
		if(bf.nowStep==StepCons.InfoReceive && bf.skillstep==0 && bf.nowGetCardPlayer==getOwner()){
			for(Card c:bf.nowGetCards){
				if(c.getColor()>2)return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		tvo.target=bf.nowPlayer.getUid();
		playAni(false);
		bf.waitfor(1500);
		ArrayList<Card> temp=new ArrayList<Card>();
		Card c=bf.cardsMap.get(tvo.card);
		temp.add(c);
		getOwner().removeCardFromHand(c,false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",tvo.target);
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		bf.getCard(bf.roleMap.get(tvo.target),temp,1);
	}
	
}
