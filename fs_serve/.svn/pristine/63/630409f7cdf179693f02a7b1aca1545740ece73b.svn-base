package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *峰回路转：当你传出的情报到达你时，你可以将其直接置于一位其他玩家面前。
 */
public class Skill145 extends Skill {

	@Override
	public Boolean check() {
		if(launchCount>=1 || bf.subStep>0)return false;
//		if(bf.nowPlayer==getOwner() && bf.nowStep == StepCons.InfoArrive && noSkill()){
		if(bf.nowPlayer==getOwner() && bf.thirdStep==StepCons.RecieveNowInfo && noSkill()){
			if(bf.sendTarget.getUid()==getOwner().getUid()){
				return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		bf.waitfor(1500);
		Player p=bf.roleMap.get(getTvo().target);
		bf.sendTarget=p;
	}
	
}
