package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/*
 *情敌 
 */

public class Skill31 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead())return false;
		if(bf.deadman!=null && getOwner().skillhash.get(this.id).launchCount<1 && bf.deadman.sex>=1 && bf.deadman.getIsOpen() && bf.thirdStep==StepCons.AfterDead){
			return true;
		}
		return false;
	}
	
	@Override
	public void reset() {
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(3000);
	
//		tvo.target=bf.deadman.getUid();
		tvo.target=this.deadmanUid;
		
		ArrayList<Card> temp=new ArrayList<Card>();
		Player target=bf.deadman;
		temp.addAll(target.handcards);
		target.removeCardFromHand(temp, false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",target.getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
		getOwner().addToHand(temp);
	}
	
}
