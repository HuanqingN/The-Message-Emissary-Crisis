package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *ษ๓ละ
 */
public class Skill107 extends Skill {
	
	@Override
	public Boolean check() {
		if(getOwner().getIsDead() && bf.nowGetCardPlayer!=null && bf.nowGetCardPlayer.idenShow==true)return false;
		if(getOwner().getIsOpen()==true && bf.deadman!=null && getOwner().skillhash.get(this.id).launchCount<1 && bf.thirdStep==StepCons.AfterDead) return true;
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
		getOwner().idenShow=true;
		bf.waitfor(1000);
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("from",-1);
		resp.putNumber("target",getOwner().getUid());
		resp.putNumber("iden",getOwner().getIndentity());
		resp.putNumber("h",2);
		resp.putNumber("f",30);
		bf.SendToALL(resp);
		
//		bf.waitfor(3000);
		Player target=bf.nowGetCards.get(0).getOwner();
		target.idenShow=true;
		resp=new ActionscriptObject();
		resp.putNumber("from",-1);
		resp.putNumber("target",target.getUid());
		resp.putNumber("iden",target.getIndentity());
		resp.putNumber("h",2);
		resp.putNumber("f",30);
		bf.SendToALL(resp);
		
		bf.waitfor(3000);
	}
	
}
