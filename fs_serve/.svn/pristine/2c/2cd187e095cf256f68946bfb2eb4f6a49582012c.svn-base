package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *化验
 */
public class Skill130 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().getIsDead())return false;
		if(bf.deadman!=null && bf.deadman.infocards.size()>0 && bf.thirdStep==StepCons.AfterDead){
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
//		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(1500);
		tvo.target=bf.roleMap.get(this.deadmanUid).getUid();
		
		ArrayList<Card> temp=new ArrayList<Card>();
		Player target=bf.roleMap.get(tvo.target);
		for(Card c : target.infocards){
			if(c.getColor() >= 3) temp.add(c);
		}
		target.removeCardFromInfo(temp, false);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject ca=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",target.getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",2); //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5情报到库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		
		bf.waitfor(2000);
		getOwner().addToHand(temp);
	}
	
}
