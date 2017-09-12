package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**…±“‚**/
public class Skill37 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.nowStep==StepCons.InfoWait && bf.nowPlayer==getOwner()){
			return hasCardColor(6,getOwner());
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
		ChooseInfo();
	}
	public void ChooseInfo(){
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn",true);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		ChooseInfoResult(bf.sResult);
	}
	public void ChooseInfoResult(SelectVO svo){
		if(svo.card==0 || svo.target==0){
			return;
		}else{
			Card c=bf.cardsMap.get(svo.card);
			c.orgSend=c.getSend();
			c.setSend(1);
		}
	}
}
