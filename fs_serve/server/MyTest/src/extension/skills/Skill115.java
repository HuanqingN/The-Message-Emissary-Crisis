package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *��Ϣ���٣���һλ�����������ʱ��������ջ�һλ�����ǰĳ����ɫ�������鱨��Ȼ������������
 */
public class Skill115 extends Skill {

	@Override
	public Boolean check() {
//		if(!getOwner().getIsDead() && bf.deadman!=null && bf.thirdStep!=StepCons.Victory && getOwner().skillhash.get(this.id).launchCount<1){
		if(bf.thirdStep==StepCons.Victory || bf.thirdStep==StepCons.BeforeBurn || bf.thirdStep==StepCons.AfterBurn)return false;
		if(!getOwner().getIsDead() && bf.deadman!=null && bf.thirdStep==StepCons.AfterDead){
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		tvo.target=this.deadmanUid;
		playAni(false);
		bf.sResult.dispose();
		bf.waitfor(11500);
		userSelected(bf.sResult);
		
	}
	
	private void userSelected(SelectVO svo){//type:1��ɫ 2��ɫ 3��ɫ
		if(svo.target==0 || svo.type==0)return;
		Player target=bf.roleMap.get(svo.target);
		ArrayList<Card> temp=new ArrayList<Card>();
		switch(svo.type){
		case 1:
			temp.addAll(target.blueCards);
			break;
		case 2:
			temp.addAll(target.redCards);
			break;
		case 3:
			temp.addAll(target.blackCards);
			break;
		}
		
		if(temp.size()==0)return;
		bf.Burn(target.getUid(), temp);
		if(temp.size()>0){
			bf.drawCard(target, bf.getCardFromCardPack(temp.size()),1,null);
			bf.waitfor(1500);
		}
	}
	
}
