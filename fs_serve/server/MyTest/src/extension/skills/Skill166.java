package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
/**
 *严酷戒律：若你的手牌数不少于6张，则跳过你的抽牌阶段
 */
public class Skill166 extends Skill {

	public Skill166(){
		auto=true;
	}
	@Override
	public Boolean check() {
		if(bf.nowPlayer.getIsDead()==false && bf.nowPlayer.isLost==false && bf.nowPlayer==getOwner() && bf.nowStep==StepCons.DealingSingle && bf.thirdStep==0){
			if(getOwner().handcards.size()>=5) return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		if(!this.check()) return;
		super.play(tvo);
		getOwner().isSkipDealing=true;
		
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		SkillVO svo=new SkillVO();
		svo.sponsor=getOwner().getUid();
		svo.sid=id;
		svo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		bf.SendToALL(resp);
		getOwner().skillhash.get(this.id).launchCount++;
//		playAni(false);
		bf.waitfor(1500);
	}
}
