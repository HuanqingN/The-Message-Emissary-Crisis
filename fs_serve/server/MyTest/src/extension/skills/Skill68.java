package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;

/**√Ù»Ò**/
public class Skill68 extends Skill {

	@Override
	public Boolean check() {
		if(bf.nowPlayer!=getOwner() &&  noInforeceive() && bf.nowStep!=StepCons.InfoArrive){
			for(Card c:getOwner().handcards){
				if(c.getId()==1)return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		bf.SendToALL(resp);
		
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		userSelected(bf.sResult);
	}
	public void userSelected(SelectVO svo){
		bf.isExcute=true;
		if(svo.type==0){
			svo.target=bf.getNextPlayer(getOwner()).getUid();
			for(Card c:getOwner().handcards){
				if(c.getId()==1){
					svo.card=c.getVid();
					break;
				}
			}
		}
		TargetVO tvo=new TargetVO();
		tvo.sponsor=getOwner().getUid();
		tvo.target=svo.target;
		tvo.cvid=svo.card;
		bf.usedCardStack.removeLast();
		bf.useCard=tvo;
		bf.CardLaunch();
	}
	
}
