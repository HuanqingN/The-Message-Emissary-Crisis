package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *ǿ�ģ������˽�ɫ�ƣ�Ȼ���ջ�һ�ź��鱨
 */
public class Skill142 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsOpen() && !getOwner().getIsDead() && blueSkillCheck()){
			for(Player p: bf.roleSeq){
				if(p.blackCards.size()>0){
					return true;
				}
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(true);
		playAni(true);
		bf.waitfor(1500);
	}
	
	@Override
	public void excute() {
		if(getOwner().getIsDead() || bf.roleMap.get(getTvo().target).getIsDead() || !hasInfoColor(3,bf.roleMap.get(getTvo().target))){
			return;
		}
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn", true);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.sResult.dispose();
		bf.waitfor(10000);
		userSelected(bf.sResult);
	}
	
	private void userSelected(SelectVO svo){
		if(svo.cards==null)return;
		ArrayList<Card> temp=new ArrayList<Card>();
		Player target=bf.roleMap.get(getTvo().target);
		Card c=bf.cardsMap.get(svo.cards.get(0));
		temp.add(c);
		bf.Burn(target.getUid(), temp);
	}
	
}
