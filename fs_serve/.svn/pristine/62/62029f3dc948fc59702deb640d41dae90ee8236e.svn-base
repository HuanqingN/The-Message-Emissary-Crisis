package extension.skills;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**±ä×°**/
public class Skill71 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && getOwner().handcards.size()>0 && noInforeceive() && bf.nowStep!=StepCons.InfoArrive){
			for(Card c:getOwner().handcards){
				if(c.getSend()==1)return true;
			}
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
		bf.waitfor(3000);
		Card c=bf.cardsMap.get(tvo.card);
		c.orgColor=c.getColor();
		c.orgId=c.getId();
		c.setColor(3);
		c.setId(1);

		TargetVO tvo1=new TargetVO();
		tvo1.sponsor=getOwner().getUid();
		tvo1.target=tvo.target;
		tvo1.cvid=c.getVid();
		tvo1.canDiscover=false;
		bf.usedCardStack.removeLast();
		bf.useCard=tvo1;
		bf.CardLaunch();
	}
		
		
		
		
		
//		bf.sResult.dispose();
//		bf.waitfor(13000);
//		userSelected(bf.sResult);
//	}
//
//	private void userSelected(SelectVO svo) {
//		if(svo.card==0 || svo.target==0){
//			return;
//		}else{
//			Card c=bf.cardsMap.get(svo.card);
//			c.orgColor=c.getColor();
//			c.orgId=c.getId();
//			c.setColor(3);
//			c.setId(1);
//
//			TargetVO tvo1=new TargetVO();
//			tvo1.sponsor=getOwner().getUid();
//			tvo1.target=svo.target;
//			tvo1.cvid=c.getVid();
//			tvo1.canDiscover=false;
//			bf.usedCardStack.removeLast();
//			bf.useCard=tvo1;
//			bf.CardLaunch();
//		}
//	}
	
}
