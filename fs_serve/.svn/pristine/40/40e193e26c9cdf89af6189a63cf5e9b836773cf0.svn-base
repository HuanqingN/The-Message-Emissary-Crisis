package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *互助
 */
public class Skill132 extends Skill {

	@Override
	public Boolean check() {
		return (getOwner().skillhash.get(this.id).launchCount<1 && selfturn() && (bf.nowStep==StepCons.CardUse1|| bf.nowStep==StepCons.CardUse2) && bf.usedCardStack.size()==0);	
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(11000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.card==0){
			svo.card=bf.roleMap.get(getTvo().target).handcards.get(0).getVid();
		}
		Player target=bf.roleMap.get(getTvo().target);
		Card tcard=bf.cardsMap.get(svo.card);
		Card scard=bf.cardsMap.get(getTvo().card);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(tcard);
		target.removeCardFromHand(tcard,false);
		getOwner().removeCardFromHand(scard,false);
		getOwner().addToHand(tcard);
		target.addToHand(scard);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",target.getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("type",1);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报 5情报到库顶 6情报到牌库顶 7情报到弃牌堆 8从手卡到传递中的情报 9从牌库顶到情报
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		temp.clear();
		temp.add(scard);
		arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",target.getUid());
		resp.put("cards",arr);
		bf.SendToALL(resp);
		bf.waitfor(2000);
	}
	
}
