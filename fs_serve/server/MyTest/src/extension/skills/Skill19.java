package extension.skills;

import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**笑里藏刀**/
public class Skill19 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead())return false;
		if(bf.nowStep==StepCons.InfoReceive && bf.skillstep==0 && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer!=null &&
				bf.nowPlayer==getOwner() && bf.nowGetCardPlayer!=getOwner()){
			Boolean boo=false;
			for(Card c:bf.nowGetCards){
				if(c.getColor()!=3){
					boo=true;
					break;
				}
			}
			if(!boo)return false;
			for(Card c:getOwner().handcards){
				if(c.getColor()>2)return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult);
	}
	public void userSelected(SelectVO svo){
		bf.isExcute=true;
		if(svo.type==0){
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
		resp.putNumber("to",bf.nowGetCardPlayer.getUid());
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		svo.target=bf.nowGetCardPlayer.getUid();
		bf.waitfor(3000);
		excuteSkill(svo);
	}
	public void excuteSkill(SelectVO svo){
		Player target=bf.roleMap.get(svo.target);
		ArrayList<Card> cards=new ArrayList<Card>();
		cards.add(bf.cardsMap.get(svo.card));
//		ReflectVO rvo=new ReflectVO("SkillEnd",this);
//		bf.getCard(target, cards, rvo,0);
		bf.getCard(target, cards, 1);
	}
}
