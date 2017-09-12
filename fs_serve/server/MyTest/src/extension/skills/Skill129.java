package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
/**
 *×·²é
 */
public class Skill129 extends Skill {
	@Override
	public Boolean check() {
		return ( (bf.thirdStep==StepCons.TestingSuccess || (getOwner().skillhash.get(this.id).launchCount<1 && bf.thirdStep==StepCons.TestingFaild) ) && bf.nowPlayer==getOwner());
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		if(bf.thirdStep==StepCons.TestingSuccess){
			playAni(false);
			bf.waitfor(1000);
			bf.drawCard(getOwner(),bf.getCardFromCardPack(hasHolms()),1,null);
			bf.waitfor(1500);
		}else{
			getOwner().skillhash.get(this.id).launchCount++;
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			ActionscriptObject obj1=new ActionscriptObject();
			tvo.dur=10000;
			Card c=bf.cardsMap.get(((TargetVO)bf.nowSettlement).cvid);
			c.setResponse(obj1);
			resp.put("cards",obj1);
			tvo.setResponse(obj);
			resp.put("tvo",obj);
			resp.putNumber("h",2);
			resp.putNumber("f",25);
			bf.SendToALL(resp);
			bf.waitfor(1000);
			((TargetVO)bf.nowSettlement).moveto=getOwner().getUid();		
			getOwner().addToHand(bf.cardsMap.get(((TargetVO)bf.nowSettlement).cvid));
		}
	}
	
	public int hasHolms(){
		for(Player p:bf.roleSeq){
			if(!p.getIsDead() && !p.isLost && p.getRoleId()==16){
				SkillVO s=new SkillVO();
				s.sponsor=getOwner().getUid();
				s.sid=131;
				getOwner().skillhash.get(131).play(s);
				return 2;
			}
		}
		return 1;
	}
	
}
