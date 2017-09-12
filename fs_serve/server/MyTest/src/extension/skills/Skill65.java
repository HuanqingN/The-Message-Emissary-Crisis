package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**ÀäÑª**/
public class Skill65 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && selfturn() && noSkill() && isAnswer() && getOwner().handcards.size()>0){
			if(bf.nowStep==StepCons.CardUse1 || bf.nowStep==StepCons.CardUse2 ||  bf.nowStep==StepCons.InfoSend){
				return true;
			}
		}
		return false;
	}
	
	@Override
	public void reset() {
		if(launchCount>0)
		getOwner().skillhash.get(this.id).launchCount++;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		if(launchCount==0){
			playAni(false);
			getOwner().skillhash.get(this.id).launchCount++;
			bf.waitfor(3000);
		}
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn",true);
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.card==0 || svo.target==0){
			return;
		}else{
			Card c=bf.cardsMap.get(svo.card);
			c.orgColor=c.getColor();
			c.orgId=c.getId();
			c.setColor(3);
			c.setId(1);

			TargetVO tvo1=new TargetVO();
			tvo1.sponsor=getOwner().getUid();
			tvo1.target=svo.target;
			tvo1.cvid=c.getVid();
			tvo1.canDiscover=false;
			bf.usedCardStack.removeLast();
			bf.useCard=tvo1;
			bf.CardLaunch();
		}
	}
	
}
