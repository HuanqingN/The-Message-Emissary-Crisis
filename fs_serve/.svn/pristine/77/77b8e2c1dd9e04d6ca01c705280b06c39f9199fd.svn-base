package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *易容
 */
public class Skill81 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsDead() && getOwner().getIsOpen() && bf.deadman!=null && getOwner().skillhash.get(this.id).launchCount<1 && bf.thirdStep==StepCons.AfterDead){
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		
		getOwner().setRoleId(bf.roleMap.get(this.deadmanUid).getRoleId());
		bf.roleMap.get(this.deadmanUid).setRoleId(0);
		getOwner().setIndentity(getOwner().getIndentity());
//		bf.deadman.setRoleId(0);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("newRid", getOwner().getRoleId());
		bf.SendToALL(resp);
		
//		bf.waitfor(2500);
		bf.drawCard(getOwner(), bf.getCardFromCardPack(1), 1, null);
		bf.waitfor(4000);
		
		if(getOwner().task!=null){  //判断收集收报胜利
			if(getOwner().checkTask()){
				bf.VictoryExcute(getOwner());
				return;
			}
		}
	}
}
