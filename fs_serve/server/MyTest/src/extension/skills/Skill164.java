package extension.skills;
import extension.cons.StepCons;
import extension.vo.SkillVO;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
/**
 *ȥ���٣����㴫����ֱ�ﱻ���������ʱ������ԸǷ��˽�ɫ��
 */
public class Skill164 extends Skill {

//	public Skill164(){
//		auto=true;
//	}
	@Override
	public Boolean check() {
//		if(!getOwner().getIsDead() && getOwner().getIsOpen() && bf.nowPlayer==getOwner() &&  bf.nowStep==StepCons.InfoReceive && bf.thirdStep!=StepCons.Victory  && bf.nowGetCards.size()==1 && bf.nowGetCards.get(0).getSend()==1 && bf.nowGetCardPlayer!=getOwner() && bf.nowGetCardPlayer!=bf.initialSendTarget){
//		SmartFoxServer.log.info("infosToBeReceived.size()="+ bf.infosToBeReceived.size());
//		if(bf.infosToBeReceived.size()>0)SmartFoxServer.log.info("infosToBeReceived Type="+bf.infosToBeReceived.get(0).getSend());
//		if(bf.nowGetCardPlayer != null || bf.initialSendTarget != null)SmartFoxServer.log.info("initial send target "+ (bf.nowGetCardPlayer == bf.initialSendTarget? "true" : "false"));
		if(!getOwner().getIsDead() && getOwner().getIsOpen() && bf.nowPlayer==getOwner() &&  bf.nowStep==StepCons.InfoReceive && bf.thirdStep!=StepCons.Victory  && bf.infosToBeReceived.size()==1 && bf.infosToBeReceived.get(0).getSend()==1 && bf.nowGetCardPlayer!=getOwner() && bf.nowGetCardPlayer!=bf.initialSendTarget){
			return true;
		}
		return false;
	}

	@Override
	public void play(SkillVO tvo) {
		super.play(tvo);
		getOwner().setIsOpen(false);
		playAni(false);
		bf.waitfor(1500);
	}
}