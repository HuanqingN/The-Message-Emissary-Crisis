package extension.actions;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
//ÔöÔ®
public class CardAction12 extends CardAction {
	@Override
	public Boolean check() {
		if(bf.subStep>0 || !noSkill())return false;
		if(bf.nowStep==StepCons.CardUse1 || bf.nowStep==StepCons.CardUse2){
			if(self()){
				return true;
			}
		}
		return false;
	}
	
	@Override
	public void play(TargetVO tvo) {
		super.play(tvo);
		Player sponsor=bf.roleMap.get(tvo.sponsor);
		int num=sponsor.blackCards.size()+1;
//		if(sponsor.getRoleId()==29){
//			num+=1;
//			SkillVO sv=new SkillVO();
//			sv.sid=84;
//			sv.sponsor=sponsor.getUid();
//			sponsor.skillhash.get(84).play(sv);
//			bf.waitfor(1500);
//		}
		ArrayList<Card> temp=bf.getCardFromCardPack(num);
		sendToClient();
		
		bf.drawCard(sponsor, temp, 1, null);
		bf.waitfor(2000);
	}
	
	public void sendToClient(){
		ActionscriptObject resp=new ActionscriptObject();
		getTvo().setResponse(resp);
		resp.putNumber("h",2);
		resp.putNumber("f",6);
		bf.SendToALL(resp);
	}
}
