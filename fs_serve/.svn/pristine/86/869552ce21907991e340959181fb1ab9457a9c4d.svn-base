package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;


/**阴谋**/
public class Skill21 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead())return false;
		if(bf.nowStep==StepCons.InfoReceive && bf.thirdStep==StepCons.AfterDead && bf.skillstep==0 && bf.nowGetCards.size()>0 && bf.nowPlayer.getUid()==getOwner().getUid()){
			for(Card c:bf.nowGetCards){
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
			Player t=bf.getRandomPlayer();
			svo.target=t.getUid();
			int num=t.handcards.size();
			if(num==0){
				return;
			}
			num=(int)Math.floor(Math.random()*num);
			ArrayList<Integer> temp=new ArrayList<Integer>();
			temp.add(num);
			svo.cards=temp;
		}
		Player t=bf.roleMap.get(svo.target);
		if(t.handcards.size()==0){
			return;
		}
		Card card=t.handcards.get(svo.cards.get(0));
		t.removeCardFromHand(card.getVid(),false);
		getOwner().addToHand(card);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		card.setResponse(ca);
		arr.put(0,ca);
		resp.putNumber("from",t.getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		goNext();
	}

}
