package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *迷局　当一位玩家获得传出的情报时，你可以让情报传出者获得牌库顶的一张牌作为情报
 */
public class Skill117 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsDead() && getOwner().skillhash.get(this.id).launchCount<1 && bf.nowGetCardPlayer!=null){
			if(bf.nowStep==StepCons.InfoReceive && bf.thirdStep!=StepCons.Victory && bf.nowGetCards.size()>0  && bf.skillstep==0){
				return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		tvo.target=bf.nowPlayer.getUid();
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(1500);
		ArrayList<Card> temp=bf.getCardFromCardPack(1);
		temp.get(0).setOwner(getOwner());
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",tvo.target);
		resp.putNumber("type",9);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		bf.getCard(bf.roleMap.get(tvo.target),temp, 2);
	}
	
}
