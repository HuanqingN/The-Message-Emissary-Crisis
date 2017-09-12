package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *��ˮ����:���ƿⶥ���Ʒ��õ�һλ�����ǰ
 */
public class Skill94 extends Skill {

	@Override
	public Boolean check() {
//		return (getOwner().getIsOpen()  && getOwner().skillhash.get(this.id).launchCount<1 && blueSkillCheck() && bf.subStep==0 && bf.thirdStep==0 && bf.skillstep==0);
		return (getOwner().getIsOpen()  && getOwner().skillhash.get(this.id).launchCount<1 && blueSkillCheck());
	}
	
	@Override
	public void reset() {
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(3000);
		ArrayList<Card> temp=bf.getCardFromCardPack(1);
		temp.get(0).setOwner(getOwner());
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",tvo.target);
		resp.putNumber("type",9);  //type  1�ֿ����ֿ� 2 �鱨���ֿ� 3�ֿ����鱨 4�鱨���鱨 5�ֿ����ƿⶥ 6�鱨���ƿⶥ 7�鱨�����ƶ� 8���ֿ��������е��鱨 9���ƿⶥ���鱨
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		bf.getCard(bf.roleMap.get(tvo.target),temp, 1);
	}
	
}
