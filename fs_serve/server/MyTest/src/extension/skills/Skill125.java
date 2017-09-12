package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.vo.SkillVO;
/**
 *��Ȩ ����ĳ��ƽ׶Σ�ÿ��һ�ź��鱨����������һ
 */
public class Skill125 extends Skill {
	@Override
	public Boolean check() {
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		int num=getOwner().blackCards.size();
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
