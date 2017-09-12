package extension.skills;

import java.util.ArrayList;
import java.util.LinkedList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;


/**阳谋**/
public class Skill22 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead())return false;
		if(bf.nowStep==StepCons.InfoReceive && bf.nowPlayer!=getOwner() && bf.skillstep==0 && bf.nowGetCards.size()>0 && bf.nowGetCardPlayer==getOwner()){
			for(Card c:bf.nowGetCards){
				if(c.getColor()>2)return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		LinkedList<Card> temp=bf.roleMap.get(tvo.target).handcards;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		ArrayList<Card> temp=new ArrayList<Card>();
		Player target=bf.roleMap.get(getTvo().target);
		int num=target.handcards.size();
		Card c=target.handcards.get((int)(Math.floor(Math.random()*num)));
		temp.add(target.removeCardFromHand(c, false));
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getTvo().target);
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
		getOwner().addToHand(c);
	}
	
}
