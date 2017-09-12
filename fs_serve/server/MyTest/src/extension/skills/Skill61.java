package extension.skills;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.LinkedList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *Ëè±⁄Õµπ‚
 */
public class Skill61 extends Skill {

	@Override
	public Boolean check() {
		return (bf.thirdStep==StepCons.StealDragon && getOwner().skillhash.get(this.id).launchCount<1);
	}
	public int selectIndex=-1;
	@Override
	public void reset() {
	}
	
	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		ArrayList<Card> temp=new ArrayList<Card>();
		for(int i=0;i<5;i++){
			temp.add(bf.cards.get(i));
		}
		bf.setCardsResp(arr, temp);
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.put("cards",arr);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(13000);
		userSelected(bf.sResult);
	}
	private void userSelected(SelectVO svo){
		if(svo.cards==null){
			selectIndex=0;
		}else{
			selectIndex=svo.cards.get(0);
		}
	}
	
}
