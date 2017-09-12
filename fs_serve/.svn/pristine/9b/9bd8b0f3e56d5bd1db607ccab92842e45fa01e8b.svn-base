package extension.skills;

import java.util.ArrayList;
import java.util.logging.Logger;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.manage.BattleCtrl;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**血染玫瑰**/
public class Skill32 extends Skill {
	@Override
	public Boolean check() {
		if(getOwner().getIsOpen())return false;
		if(answer() || bf.nowStep==StepCons.InfoSend || (noInforeceive() && selfturn())){
//			for(Card c:getOwner().handcards){
//				if(c.getColor()>2)return true;
//			}
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(true);
		playAni(true);
	}

	@Override
	public void excute() {
		if(getOwner().getIsDead() || bf.roleMap.get(getTvo().target).getIsDead() || getOwner().handcards.size()==0){
			return;
		}
		ArrayList<Card> cards=bf.getCardFromCardPack(2);
		bf.cards.addAll(0, cards);
		
		if(!hasCardColor(6,getOwner())){
			return;
		}
		
		ActionscriptObject arr=new ActionscriptObject();
		int index=0;
//		Boolean b=false;
		int bcs=0;
		for(Card c:cards){
			ActionscriptObject o=new ActionscriptObject();
			c.setResponse(o);
			arr.put(index++,o);
//			if(!b){
//				if(c.getColor()>2)b=true;
//			}
			if(c.getColor()>2)bcs++;
		}
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putBool("goOn", true);
		resp.putNumber("rid", getOwner().getRoleId());
//		resp.putNumber("num",b?3:1);
		resp.putNumber("num", bcs+1);
		resp.putNumber("oid",bf.operId);
		resp.put("cards", arr);
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult);
	}
	public void userSelected(SelectVO svo){
//		bf.isExcute=true;
		if(svo.type==1){
			if(svo.cards == null) svo.type=0; //如果没有选牌，类型变为0。
		}
//		if(svo.type==0){
//			svo.cards=new ArrayList<Integer>();
//			for(Card c:getOwner().handcards){
//				if(c.getColor()>2){
//					svo.cards.add(c.getVid());
//					break;
//				}
//			}
//		}
		if(svo.cards==null) return;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		int index=0;
		for(Integer i:svo.cards){
			ActionscriptObject obj=new ActionscriptObject();
			Card c=bf.cardsMap.get(i);
			c.setResponse(obj);
			arr.put(index++, obj);
			getOwner().removeCardFromHand(i,false);
		}
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",bf.roleMap.get(getTvo().target).getUid());
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5情报到库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(3000);
		excuteSkill(svo);
	}
	public void excuteSkill(SelectVO svo){
		if(svo.cards==null){
			return;
//			svo.cards=new ArrayList<Integer>();
//			for(Card c:getOwner().handcards){
//				if(c.getColor()>2){
//					svo.cards.add(c.getVid());
//					break;
//				}
//			}
		}
		Player target=bf.roleMap.get(getTvo().target);
		ArrayList<Card> cards=new ArrayList<Card>();
		for(Integer i:svo.cards){
			cards.add(bf.cardsMap.get(i));
		}
//		ReflectVO rvo=new ReflectVO("SkillEnd",this);
		bf.getCard(target, cards, 1);
//		bf.getCard(target, cards, rvo,0);
	}

}
