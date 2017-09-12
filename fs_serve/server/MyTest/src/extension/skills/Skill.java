package extension.skills;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;

import extension.Player;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.manage.BattleCtrl;
import extension.vo.ReflectVO;
import extension.vo.SkillVO;
import extension.vo.SkillVO;

public class Skill {
	private Player owner;
	private SkillVO tvo;
	public BattleCtrl bf;
	public int color=0;
	public int launchCount=0;//���ܵķ�������
	public int id;
	public Boolean auto=false;
	public int deadmanUid=-1;
	public int nowGetCardPlayerUid=-1;
	public ArrayList<Card> infosToBeReceived = new ArrayList<Card>();
	public int launched=0;//�����ڲ�Ч���ķ�������
	public Player launchTarget=null;//����Ŀ��
	public boolean disabled=false;
	public int nsvid = 199; //�˲�����skill159�����ã�������˰��vid�����á�Ԥ��200~299����˰��id
	
	@Override
	public String toString() {
		// TODO �Զ����ɵķ������
		return "Skill:: id="+id;
	}
	public Player getOwner() {
		return owner;
	}
	
	public void setOwner(Player owner) {
		this.owner = owner;
		bf=owner.getBf();
	}

	public Boolean check() {
		return false;
	}

	public void play(SkillVO tvo) {
		this.setTvo(tvo);
	}
	public void excute(){
		
	}
	public Skill getExclusiveSkill(){
		return getOwner().skillhash.get(id);
	}
	public void copyBasicInfo(Skill ski){
		this.id=ski.id;
		this.setOwner(ski.getOwner());
		this.color=ski.color;
	}
	public void playAni(Boolean isturn){
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		tvo.dur=10000;
		tvo.setResponse(obj);
		resp.put("tvo",obj);
		resp.putNumber("h",2);
		resp.putNumber("f",25);
		resp.putNumber("oid",bf.operId);
		if(isturn)
			resp.putNumber("rid", getOwner().getRoleId());
		bf.SendToALL(resp);
	}
	public SkillVO getTvo() {
		return tvo;
	}

	public void setTvo(SkillVO tvo) {
		this.tvo = tvo;
	}
	public void reset(){
		launchCount=0;
	}
	public Boolean noSkill(){
		return !(bf.skillstep>0);
	}
	public Boolean selfturn(){
		return bf.nowPlayer.getUid()==getOwner().getUid();
	}
	public Boolean noInforeceive(){
		return bf.nowStep != StepCons.InfoReceive && bf.nowStep != StepCons.StepBegin && bf.nowStep != StepCons.StepEnd;
	}
	public Boolean answer(){
		return (bf.subStep==StepCons.CardLaunch && bf.usedCardStack.size()>0);
	}
	
	public Boolean blueSkillCheck(){
		if(answer() || bf.nowStep==StepCons.InfoSend || (noInforeceive() && selfturn())){
			return true;
		}
		return false;
	}
	public void goNext(){
		bf.waitfor(2000);
//		bf.SuddenSkillSettlementEnd();
	}
	//co=6,���кڿ�
	public Boolean hasCardColor(int co,Player p){//����Լ���������ɫ�Ŀ�
		for(Card c:p.handcards){
			if(co==6){				
				if(c.getColor()>2)return true;
			}else{
				if(c.getColor()==co)return true;
			}
		}
		return false;
	}
	public Boolean hasInfoColor(int co,Player p){//����Լ��鱨����ɫ�Ŀ�
		if(co==1)return p.blueCards.size()>0;
		else if(co==2)return p.redCards.size()>0;
		else return p.blackCards.size()>0;
	}
	
	public Boolean hasAllCardColor(int co){//��������������û�д���ɫ�Ŀ�
		for(Player p:bf.roleSeq){
			if(hasCardColor(co,p)) return true;
		}
		return false;
	}
	
	public Boolean hashInfoByOther(){//������û���鱨
		for(Player p:bf.roleSeq){
			if(p.getUid()!= getOwner().getUid()){
				if(p.blackCards.size()>0 || p.blueCards.size()>0 || p.redCards.size()>0)return true;
			}
		}
		return false;
	}
	
	public boolean hasInfoBySomeone(Player p){//�ж�Ŀ����û���鱨
		return  p.infocards.size()>0;
	}
	
	public boolean isAnswer() {
		if(bf.subStep>0){
			return bf.subStep==StepCons.CardLaunch;
		}
		return true;
	}
}