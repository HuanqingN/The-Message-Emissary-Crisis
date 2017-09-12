package extension.skills;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *偷龙转凤
 */
public class Skill60 extends Skill {

	@Override
	public Boolean check() {
		if(launchCount>=1 || bf.subStep>0)return false;
		if(bf.nowStep == StepCons.InfoArrive && noSkill()){
			if(bf.sendTarget.getUid()==getOwner().getUid()){
				return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
//		bf.thirdStep=StepCons.StealDragon;
//		if(bf.checkAllAction(2)){   //有可以使用红技能的人
//			LinkedList<Skill> canuseSkill=bf.checkRedSkill();
//			if(canuseSkill.size()>0){
//				bf.RedSkillLaundch(canuseSkill);
//			}
//		}
//		bf.thirdStep=0;
//		Skill61 skl=(Skill61)getOwner().skillhash.get(61);
		getOwner().skillhash.get(this.id).launchCount++;
//		int index= skl.selectIndex<0?0:skl.selectIndex;
		int index = 0; //去掉黄色技能后加的
		Card temp=bf.cards.remove(index);
		temp.setOwner(bf.sendingcard.getOwner());
		temp.orgSend=temp.getSend();
		temp.setSend(bf.sendingcard.getSend());
		bf.reduction(bf.sendingcard);
		bf.cards.add(index, bf.sendingcard);
		bf.sendingcard.setOwner(null);
		bf.sendingcard=temp;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject cad=new ActionscriptObject();
		tvo.dur=10000;
		temp.setResponse(cad);
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.put("card",cad);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		bf.SendToALL(resp);
		bf.waitfor(3000);
//		skl.selectIndex=-1; //黄技
		bf.usedCardStack.removeLast();
//		bf.RecieveNowInfo();
	}
	
}
