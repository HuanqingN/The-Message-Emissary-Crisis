package extension.skills;

import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 * ¼ÆÖÐ¼Æ
 */
public class Skill8 extends Skill {

	@Override
	public Boolean check() {
		if(bf.thirdStep==0 && getOwner().getIsOpen() && bf.subStep==StepCons.CardSettlement &&  bf.nowStep==StepCons.InfoSend && bf.sendTarget==getOwner() && bf.nowSettlement instanceof TargetVO){
			return ((((TargetVO)bf.nowSettlement).cid==6 && !((TargetVO)bf.nowSettlement).disabled) || (((TargetVO)bf.nowSettlement).cid==10 && !((TargetVO)bf.nowSettlement).disabled));
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		tvo.target=((TargetVO)bf.nowSettlement).sponsor;
		Player target=bf.roleMap.get(getTvo().target);
		ArrayList<Card> temp=bf.getCardFromCardPack(1);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.put("cards",arr);
		bf.SendToALL(resp);
		getOwner().addToHand(temp);
		if(target.infocards.size()>0){
			bf.sResult.dispose();
			bf.waitfor(12000);
			userSelected(bf.sResult);
		}
	}

	private void userSelected(SelectVO svo) {
		if(svo.cards==null)return;
		ArrayList<Card> temp=new ArrayList<Card>();
		Player target=bf.roleMap.get(getTvo().target);
		Card c=bf.cardsMap.get(svo.cards.get(0));
		temp.add(c);
		bf.Burn(target.getUid(), temp);
	}
	
}
