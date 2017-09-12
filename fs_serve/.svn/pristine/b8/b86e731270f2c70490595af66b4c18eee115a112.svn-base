package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**¹î¼Æ**/
public class Skill48 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsOpen() || launchCount>=1)return false;
		if(blueSkillCheck()){
			if(getOwner().redCards.size()>0 || getOwner().blueCards.size()>0)return true;
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
		bf.sResult.dispose();
		bf.waitfor(13000);
		userSelected(bf.sResult);
	}
	
	private void userSelected(SelectVO svo){	
		if(svo.cards==null){
			return;
		}
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		ArrayList<Card> temp=new ArrayList<Card>();
		Player target=getOwner();
		Card result=target.removeCardFromInfo(svo.cards.get(0), false);
		temp.add(result);
		getOwner().addToHand(result);
		bf.setCardsResp(arr, temp);
		resp.put("cards",arr);
		resp.putNumber("type",2);
		resp.putNumber("from",target.getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		
	}
	
}
