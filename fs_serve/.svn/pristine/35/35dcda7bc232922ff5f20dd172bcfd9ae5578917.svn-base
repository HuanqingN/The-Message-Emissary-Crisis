package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**
 *ÕæÏà
 */
public class Skill1 extends Skill {

	@Override
	public Boolean check() {
		if(bf.thirdStep==0 && bf.subStep==StepCons.CardSettlement && bf.nowSettlement instanceof TargetVO && ((TargetVO)bf.nowSettlement).sid==0 && ((TargetVO)bf.nowSettlement).disabled==false && ((TargetVO)bf.nowSettlement).sponsor!=getOwner().getUid()){
			int cindex=((TargetVO)bf.nowSettlement).cid;
			if(cindex>=13 &&  cindex<=18)return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=5000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		ActionscriptObject c=new ActionscriptObject();
		Card ca=bf.cardsMap.get(((TargetVO)bf.nowSettlement).cvid);
		ca.setResponse(c);
		resp.put("sendcard",c);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putNumber("rid", getOwner().getRoleId());
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(5000);
		userSelected(bf.sResult);
	}
	public void userSelected(SelectVO svo){
//		bf.SuddenSkillSettlementEnd();
	}
	
}
