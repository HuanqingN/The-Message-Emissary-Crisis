package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *мялс
 */
public class Skill139 extends Skill {

	@Override
	public Boolean check() {
//		if(getOwner().getIsOpen() && bf.thirdStep==StepCons.LockTarget  && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).target==getOwner().getUid()){
//			if(bf.cardsMap.get(((TargetVO)bf.nowSettlement).cvid).getId()==1)return true;
//		}
		if(getOwner().getIsOpen() && bf.thirdStep==StepCons.LockTarget  && getOwner().isBeingLocked){
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		ArrayList<Card> cards=bf.getCardFromCardPack(1);
		getOwner().addToHand(cards);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		bf.setCardsResp(arr, cards);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.put("cards",arr);
		resp.putNumber("oid",bf.operId);
		bf.SendToALL(resp);
		bf.waitfor(3000);
		getOwner().setIsLock(false);
	}
	
}
