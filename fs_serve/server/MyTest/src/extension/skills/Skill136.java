package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.vo.SkillVO;
/**
 *蛇蝎美人 你的抽牌阶段,场上每有一个[毒]状态的玩家,你的抽牌数+1
 */
public class Skill136 extends Skill {

	@Override
	public Boolean check() {
		
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		int num=0;
		for(Player p:bf.roleSeq){
			if(!p.getIsDead() && !p.isLost && p.isPoison>0)num++;
		}
		if(num==0)return;
		
		getOwner().getCards.addAll(bf.getCardFromCardPack(num));
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
		bf.waitfor(1000);
	}
	
}
