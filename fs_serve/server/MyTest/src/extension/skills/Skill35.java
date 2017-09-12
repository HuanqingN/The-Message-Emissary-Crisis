package extension.skills;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cons.StepCons;
import extension.vo.SkillVO;

/**¡¡Ω£**/
public class Skill35 extends Skill {
	@Override
	public String toString(){
		return "¡¡Ω£";
	}
	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && selfturn() && bf.nowStep==StepCons.StepBegin)return true;
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		bf.SendToALL(resp);
		getOwner().skillhash.get(this.id).launchCount++;
		if(tvo.targets!=null){
			for(Integer i:tvo.targets){
				bf.roleMap.get(i).setIsLock(true);
			}
		}
		goNext();
	}
}
