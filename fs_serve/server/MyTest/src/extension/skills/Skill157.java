package extension.skills;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import javax.security.auth.callback.LanguageCallback;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
/**
 *��ˮ��ѡ�񴫵��鱨ʱ�������ѡ������һ��������ֱ�﷽ʽ���ݸ�һλ��ǰ�����Ż����Ϻ��鱨����ң��������������������״̬���ұ��غϴ��ݵ��鱨�޷�������������
 */
public class Skill157 extends Skill {

	@Override
	public Boolean check() {
		if(getOwner().skillhash.get(this.id).launchCount<1 && getOwner().getIsOpen() && bf.nowStep==StepCons.InfoWait && bf.nowPlayer==getOwner()){
			for(Player p:bf.roleSeq){
				if(p!=getOwner() && p.blackCards.size()>=2){
					return true;
				}
			}
		}
		return false;
	}


	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().skillhash.get(this.id).launchCount++;
		playAni(false);
		bf.waitfor(1500);
		ChooseInfo();
	}
	public void ChooseInfo(){
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		getTvo().dur=10000;
		getTvo().setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		resp.putBool("goOn",true);
		bf.SendToALL(resp);
		bf.sResult.dispose();
		bf.waitfor(10*1000);
		ChooseInfoResult(bf.sResult);
	}
	public void ChooseInfoResult(SelectVO svo){
		if(svo.card==0 || svo.target==0){
			return;
		}else{
			Card c=bf.cardsMap.get(svo.card);
			c.orgSend=c.getSend();
			c.setSend(1);
			c.heishui=true;
			ActionscriptObject resp=new ActionscriptObject();
			ActionscriptObject obj=new ActionscriptObject();
			getTvo().dur=10000;
			getTvo().setResponse(obj);
			resp.put("tvo",obj);
			resp.putNumber("h",2);
			resp.putNumber("f",25);
			resp.putBool("goOn",true);
			resp.putNumber("uid",svo.target);
			bf.SendToALL(resp);
			bf.roleMap.get(svo.target).setIsLock(true);
		}
	}
}
