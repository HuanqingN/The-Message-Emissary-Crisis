package extension.skills;

import java.security.acl.Owner;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 * ·ç¶È
 */
public class Skill70 extends Skill {
	public Skill70(){
		auto=true;
	}
	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && bf.thirdStep==StepCons.Victory && bf.victoryMan==getOwner()){
			for(Player p:bf.roleSeq){
				if(!p.getIsDead() && !p.isLost && p.sex!=1 && p.getIsOpen())return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(11000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.target==0){
			for(Player p:bf.roleSeq){
				if(!p.getIsDead() && !p.isLost && p.sex!=1){
					svo.target=p.getUid();
					break;
				}
			}
		}
		Player target=bf.roleMap.get(svo.target);
		if(bf.winners.indexOf(target)<0)
		bf.winners.add(target);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().target=svo.target;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putBool("goOn",true);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		bf.SendToALL(resp);
		
		bf.waitfor(1000);
	}
	
}
