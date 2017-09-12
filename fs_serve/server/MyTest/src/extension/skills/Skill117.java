package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SkillVO;
/**
 *�Ծ֡���һλ��һ�ô������鱨ʱ����������鱨�����߻���ƿⶥ��һ������Ϊ�鱨
 */
public class Skill117 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsDead() && getOwner().skillhash.get(this.id).launchCount<1 && bf.nowGetCardPlayer!=null){
			if(bf.nowStep==StepCons.InfoReceive && bf.thirdStep!=StepCons.Victory && bf.nowGetCards.size()>0  && bf.skillstep==0){
				return true;
			}
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		tvo.target=bf.nowPlayer.getUid();
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(1500);
		ArrayList<Card> temp=bf.getCardFromCardPack(1);
		temp.get(0).setOwner(getOwner());
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		bf.setCardsResp(arr, temp);
		resp.putNumber("from",tvo.target);
		resp.putNumber("type",9);  //type 1�ֿ����ֿ� 2 �鱨���ֿ� 3�ֿ����鱨 4�鱨���鱨5�ֿ����ƿⶥ6�鱨���ƿⶥ 7�鱨�����ƶ� 8���ֿ��������е��鱨 9���ƿⶥ���鱨
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
		bf.getCard(bf.roleMap.get(tvo.target),temp, 2);
	}
	
}
