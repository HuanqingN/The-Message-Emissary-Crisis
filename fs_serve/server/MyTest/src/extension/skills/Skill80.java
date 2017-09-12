package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *蛊惑
 */
public class Skill80 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead() || getOwner().getIsOpen() || getOwner().handcards.size()==0)return false;
		if(answer() || bf.nowStep==StepCons.InfoSend || (noInforeceive() && selfturn())){
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(true);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putNumber("rid", getOwner().getRoleId());
		resp.putNumber("num",getOwner().handcards.size());
		bf.SendToALL(resp);
		
		if(getOwner().handcards.size()>0){
			bf.sResult.dispose();
			bf.waitfor(10000);
			userSelected(bf.sResult);
		}
	}

	private void userSelected(SelectVO svo) {
		if(getOwner().getIsDead() || getOwner().handcards.size()<=0){
			return;
		}else{
			if(svo.cards==null){
				svo.cards=new ArrayList<Integer>();
				int random = (int)Math.random()*getOwner().handcards.size();
				svo.cards.add(random);
			}
			ArrayList<Card> temp=new ArrayList<Card>();
			Card c=getOwner().handcards.get(svo.cards.get(0));
			temp.add(getOwner().removeCardFromHand(c, false));
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject arr=new ActionscriptObject();
			bf.setCardsResp(arr, temp);
			resp.putNumber("from",getOwner().getUid());
			resp.putNumber("to",getTvo().target);
			resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
			resp.put("cards",arr);
			resp.putNumber("h",2);
			resp.putNumber("f",27);
			bf.SendToALL(resp);
			bf.waitfor(2000);
			bf.roleMap.get(getTvo().target).addToHand(temp);
		}
	}

	@Override
	public void excute() {
		if(hasCardColor(6, getOwner())){
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
			userSelected1(bf.sResult);
		}
	}

	private void userSelected1(SelectVO svo) {
		if(svo.cards==null){
//			svo.cards=new ArrayList<Integer>();
//			for(Card c:getOwner().handcards){
//				if(c.getColor()>2){
//					svo.cards.add(c.getVid());
//					break;
//				}
//			}
			return;
		}
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(getOwner().removeCardFromHand(svo.cards.get(0), false));
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",getTvo().target);
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		bf.getCard(bf.roleMap.get(getTvo().target), temp, 1);
	}
	
}
