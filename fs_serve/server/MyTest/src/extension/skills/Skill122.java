package extension.skills;
import java.lang.reflect.Array;
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
 *¶¨µãÄ¨³ý
 */
public class Skill122 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && getOwner().getIsDead() || !noSkill() || bf.subStep==StepCons.CardSettlement)return false;
		if(noInforeceive()){
			boolean boo=false;
			for(Card c:getOwner().handcards){
				if(c.getId()==3){
					boo=true;
					break;
				}
			}
			if(!boo)return false;
			for(Player p:bf.roleSeq){
				if(hasInfoBySomeone(p)){
						return true;
				}
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(1500);
		TargetVO tvo1=new TargetVO();
		tvo1.sponsor=getOwner().getUid();
		tvo1.target=tvo.target;
		tvo1.cvid=tvo.cvid;
		tvo1.card=tvo.card;
		bf.usedCardStack.removeLast();
		bf.useCard=tvo1;
		bf.CardLaunch();
	}
}
