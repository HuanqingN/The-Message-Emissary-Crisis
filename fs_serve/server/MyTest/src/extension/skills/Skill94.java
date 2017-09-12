package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *逝水流年:将牌库顶的牌放置到一位玩家面前
 */
public class Skill94 extends Skill {

	@Override
	public Boolean check() {
//		return (getOwner().getIsOpen()  && getOwner().skillhash.get(this.id).launchCount<1 && blueSkillCheck() && bf.subStep==0 && bf.thirdStep==0 && bf.skillstep==0);
		return (getOwner().getIsOpen()  && getOwner().skillhash.get(this.id).launchCount<1 && blueSkillCheck());
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
		ArrayList<Card> temp=bf.getCardFromCardPack(1);
		temp.get(0).setOwner(getOwner());
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",tvo.target);
		resp.putNumber("type",9);  //type  1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5手卡到牌库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		bf.getCard(bf.roleMap.get(tvo.target),temp, 1);
	}
	
}
