package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *灭口
 */
public class Skill141 extends Skill {

	@Override
	public Boolean check() {
		return (getOwner().getIsOpen() && bf.thirdStep==StepCons.TestingSuccess && getOwner().skillhash.get(this.id).launchCount<1 && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).target==getOwner().getUid() && hasCardColor(6,getOwner()));
	}
	@Override
	public void reset() {
	}
	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(13000);
		userSelected(bf.sResult);
	}
	private void userSelected(SelectVO svo) {
		if(svo.cards==null){
			return;
		}
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		ArrayList<Card> temp=new ArrayList<Card>();
		for(Integer i:svo.cards){
			temp.add(bf.cardsMap.get(i));
		}
		getOwner().removeCardFromHand(temp,false);
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",getOwner().getUid());
		resp.putNumber("to",((TargetVO)bf.nowSettlement).sponsor);
		resp.putNumber("type",3);  //type 1手卡到手卡 2 情报到手卡 3手卡到情报 4情报到情报5手卡到牌库顶
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		bf.getCard(bf.roleMap.get(((TargetVO)bf.nowSettlement).sponsor),temp,1);
	}
}
