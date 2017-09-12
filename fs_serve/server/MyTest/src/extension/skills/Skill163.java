package extension.skills;
import java.util.ArrayList;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *����Ӱ�������������˽�ɫ�ƣ���ָ��һ��������ɫ�����㣺������ǰ��һ���鱨�����������
 */
public class Skill163 extends Skill {

	@Override
	public Boolean check() {
		if(!getOwner().getIsOpen() && !getOwner().getIsDead() && blueSkillCheck()){
			for(Player p: bf.roleSeq){
				if(p != getOwner() && p.infocards.size()>0){
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
		if(getOwner().getIsDead() || bf.roleMap.get(getTvo().target).getIsDead() || bf.roleMap.get(getTvo().target).infocards.size()<1){
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
		Player target=bf.roleMap.get(getTvo().target);
		if(svo.cards==null){
			svo.cards=new ArrayList<Integer>();
			int random = (int)(Math.random()*(target.infocards.size()-1));
			Card card =target.infocards.get(random);
			svo.cards.add(card.getVid());
		}
	
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		ArrayList<Card> temp=new ArrayList<Card>();
		Card car = target.removeCardFromInfo(svo.cards.get(0), false);
		temp.add(car);
		getOwner().addToHand(car);
		bf.setCardsResp(arr, temp);
		resp.put("cards",arr);
		resp.putNumber("type",2);//type 1�ֿ����ֿ� 2 �鱨���ֿ� 3�ֿ����鱨 4�鱨���鱨 5�鱨���ⶥ 6�鱨���ƿⶥ 7�鱨�����ƶ� 8���ֿ��������е��鱨 9���ƿⶥ���鱨
		resp.putNumber("from",target.getUid());
		resp.putNumber("to",getOwner().getUid());
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		bf.SendToALL(resp);
		bf.waitfor(2000);
	}
	
}
