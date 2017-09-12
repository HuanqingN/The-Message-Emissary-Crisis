package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.vo.SelectVO;
import extension.vo.SkillVO;

/**
 *²¼Êð
 */
public class Skill51 extends Skill {

	@Override
	public Boolean check() {
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}

	private void userSelected(SelectVO svo) {
		if(svo.target==0){
			return;
		}
		Player target=bf.roleMap.get(svo.target);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr,target.handcards);
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putBool("goOn", true);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.put("cards",arr);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(5000);
	}
	
}
