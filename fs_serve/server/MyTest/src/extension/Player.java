package extension;

import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import extension.actions.Action;
import extension.cards.ACard;
import extension.cards.Card;
import extension.cons.StepCons;
import extension.data.Globle;
import extension.manage.BattleCtrl;
import extension.skills.Skill;
import extension.tasks.TaskBase;
import extension.util.ObjUtil;
import extension.util.StringUtil;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

public class Player {
	private int roleId=0; //��ɫ
	private int orgRid=0;//ԭ��ɫ
	private WUser user=null;
	private int uid=-1;
	public int sex;
	private int indentity=-1; //0���� 1Ǳ�� 2����
	private int orgIden=-1;
//	private Boolean isFristHand=false;
	private BattleCtrl bf;
	private Boolean isOpen=false;   //�Ƿ��Ѿ�����(���Ǳ����ɫ)
	public Boolean isHiden=false;  //�Ƿ�ΪǱ����ɫ
	public ArrayList<Skill> skill=new ArrayList<Skill>();  //��ɫ�ļ���
	public HashMap<Integer,Skill> skillhash=new HashMap<Integer, Skill>();
	public Boolean isSkip=false; //�Ƿ񱻵���
	public Boolean isCapture =false; //�Ƿ񱻽ػ�
	private Boolean isLock=false; //�Ƿ�����
	public Boolean isTransfer=false; //�Ƿ�ת��
	private Boolean isDead=false; //�Ƿ�����
	public Boolean trueDead=false; //�Ƿ�������
	public Boolean isGod=false; //�Ƿ��޵�
	public Boolean isLost=false; //�Ƿ�����
	public boolean idenShow=false;  //�Ƿ��Ѿ����������
	public boolean trusttee=false;  //�Ƿ��й�
	public boolean isExit=false;  //�Ƿ��뿪
	public ArrayList<Card> canUseCard=new ArrayList<Card>(); //��ʹ�õĿ�
	public ArrayList<Skill> canUseSkill=new ArrayList<Skill>();//��ʹ�õļ���
	public ArrayList<Card> getCards=new ArrayList<Card>();  //��Ҫ������
	private String name;
	public LinkedList<Card> handcards=new LinkedList<Card>();  //����
	public ArrayList<Card> infocards=new ArrayList<Card>(); //�鱨��
	public LinkedList<Card> redCards=new LinkedList<Card>();  //���鱨��
	public LinkedList<Card> blueCards=new LinkedList<Card>();  //���鱨��
	public LinkedList<Card> blackCards=new LinkedList<Card>();  //���鱨��
	private boolean pass=false; //�����˻غ�
	public TaskBase task=null;
	public int isPoison=0; //�Ƿ��ж�
	public boolean isWin=false;
	public int killCount=0;
	public int nowTurnKillCount=0; //��ǰ�غ�ɱ����
	public boolean isSkipDealing=false; //�Ƿ���������
	public boolean isBeingLocked = false; //�Ƿ����ڽ�������״̬
	public Card lastUsedCard = null;//���غϳɹ�ʹ�õ���һ����
	private String hname="";
	public HashMap<Integer, Integer> jifengzhouyu = new HashMap<Integer, Integer>();
	
	public int getRoleId() {
		return roleId;
	}
	
//	public int getOrgRoleId() {
//		return orgRid;
//	}
	public void setRoleId(int roleId) {
		if(getOrgRid()==0){
			setOrgRid(this.roleId);
		}
		this.roleId = roleId;
		if(roleId>0){
			sex=Globle.getRoledata().getHash().get(roleId).getSex();
			isHiden=Globle.getRoledata().getHash().get(roleId).getHide()==1;
			setIsOpen(isHiden?false:true);
			initSkill();
		}
	}
	private void initTask() {
		if(indentity==2){
			task=ObjUtil.getTaskClassByID(Globle.getRoledata().getHash().get(roleId).getSecurity());
			task.setOwner(this);
		}
	}
	private void initSkill() {  //��ʼ����ɫ����
		int sid[]=new int[4];
		Skill s=null;
		skill.clear();
		skillhash.clear();
		sid[0]=Globle.getRoledata().getHash().get(roleId).getS1();
		sid[1]=Globle.getRoledata().getHash().get(roleId).getS2();
		sid[2]=Globle.getRoledata().getHash().get(roleId).getS3();
		sid[3]=Globle.getRoledata().getHash().get(roleId).getS4();
		
		for(int i:sid){
//			SmartFoxServer.log.info("i="+ i);
			if(i>0){
				s=ObjUtil.getSkillClassByID(i);
				s.color=Globle.getSkilldata().getHash().get(i).getColor();
				s.setOwner(this);
				s.id=i;
				skill.add(s);
				skillhash.put(i, s);
			}
		}
	}
	public WUser getUser() {
		return user;
	}
	public void setUser(WUser user) {
		this.user = user;
		uid=user.getId();
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public int getIndentity() {
		return indentity;
	}
	public void setIndentity(int indentity) {
		if(getOrgIden()==-1){
			setOrgIden(this.indentity);
		}
		this.indentity = indentity;
		initTask();
	}
	public void addToHand(List<Card> card) {
		handcards.addAll(card);
		for(Card c:card){
			c.setOwner(this);   //bug
		}
		if(getIndentity()==2){
			if(checkTask()){
				bf.victoryMan=this;
				bf.VictoryExcute(this);
			}
		}
	}
	public void addToHand(Card card){
		handcards.add(card);
		card.setOwner(this);
		if(getIndentity()==2){
			if(checkTask()){
				bf.victoryMan=this;
				bf.VictoryExcute(this);
			}
		}
	}
	public Card removeCardFromHand(Card card,Boolean tograve){
		Card result=null;
		if(handcards!=null){
			result=handcards.remove(handcards.indexOf(card));
			if(result!=null){
				if(tograve)bf.sendCardToGraveyard(result);
			}
		}
		return result;
	}
	public ArrayList<Card> removeCardFromHand(List<Card> cards,Boolean tograve){
		ArrayList<Card> result=new ArrayList<Card>();
		for(Card c:cards){
			result.add(removeCardFromHand(c, tograve));
		}
		return result;
	}
	public Card removeCardFromHand(int vid,Boolean tograve){
		return removeCardFromHand(bf.cardsMap.get(vid),tograve);
	}
	
	public Boolean checkTask(){
		if(task!=null){
			return task.check();
		}
		return false;
	}
	public void check(int type) {   //������п�����û�����õ�
		canUseCard.clear();
		canUseSkill.clear();
		if(this.trueDead || this.isLost || this.trusttee){
			setPass(true);
			return;
		}
		if(type<2){
			for(Card c:handcards){
				ACard ac=(ACard)c;
				if(ac.check()){
					canUseCard.add(ac);
				}
			}
		}
		if(type!=1 && isPoison==0){
			for(Skill s:skill){
				if(s.check()){
					canUseSkill.add(s);
				}
			}
		}
		if(canUseCard.size()==0 && canUseSkill.size()==0)setPass(true);
	}
	public BattleCtrl getBf() {
		return bf;
	}
	public void setBf(BattleCtrl bf) {
		this.bf = bf;
	}

	public LinkedList<SocketChannel> getChannel(){
		return user.getChannel();
	}
	public boolean isPass() {
		return pass;
	}
	public void setPass(boolean pass) {
		if(pass){
			this.canUseCard.clear();
			this.canUseSkill.clear();
		}
		this.pass = pass;
	}
	public String getName() {
		return user.getNickName();
	}
	public void setName(String name) {
		this.name = name;
	}
	public Card removeCardFromInfo(int tvid,Boolean toGraveyard) {  //���鱨�Ѵ��Ƴ���
		Card card=bf.cardsMap.get(tvid);
		return removeCardFromInfo(card, toGraveyard);
	}
	public ArrayList<Card> removeCardFromInfo(List<Card> cards,Boolean toGraveyard) {
		ArrayList<Card> result=new ArrayList<Card>();
		for(Card c:cards){
			result.add(removeCardFromInfo(c, toGraveyard));
		}
		return result;
	}
	public Card removeCardFromInfo(Card card,Boolean toGraveyard) { 
		Card result=infocards.remove(infocards.indexOf(card));
//		switch (card.getColor()) {
//		case 1:
//			result=blueCards.remove(blueCards.indexOf(card));
//			break;
//		case 2:
//			result=redCards.remove(redCards.indexOf(card));
//			break;
//		case 3:
//			result=blackCards.remove(blackCards.indexOf(card));
//			break;
//		case 4:
//			redCards.remove(redCards.indexOf(card));
//			result=blackCards.remove(blackCards.indexOf(card));
//			break;
//		case 5:
//			result=blueCards.remove(blueCards.indexOf(card));
//			result=blackCards.remove(blackCards.indexOf(card));
//			break;
//		}
		if(result!=null){
			int index=-1;
			index=blueCards.indexOf(card);
			if(index>=0)blueCards.remove(index);
			index=redCards.indexOf(card);
			if(index>=0)redCards.remove(index);
			index=blackCards.indexOf(card);
			if(index>=0)blackCards.remove(index);
			if(toGraveyard)bf.sendCardToGraveyard(result);
			return result;
		}
		return null;
	}

	public Boolean getIsDead() {
		return isDead;
	}
	public void setIsDead(Boolean boo) {
		this.isDead = boo;
	}

	public void excuteDeath() {
			trueDead=true;
			bf.sendCardToGraveyard(blackCards);
			bf.sendCardToGraveyard(redCards);
			bf.sendCardToGraveyard(blueCards);
			bf.sendCardToGraveyard(handcards);
			blackCards.clear();
			redCards.clear();
			blueCards.clear();
			handcards.clear();
			ActionscriptObject resp=new ActionscriptObject();
			resp.putNumber("uid",getUid());
			resp.putNumber("iden",getIndentity());
			resp.putNumber("rid",getRoleId());
			resp.putBool("type",this.isLost);
			resp.putNumber("h",2);
			resp.putNumber("f",23);
			bf.SendToALL(resp);
	}
	public Boolean getIsOpen() {
		return isOpen;
	}
	public Boolean setIsOpen(Boolean isOpen1) {
		this.isOpen = isOpen1;
		return isOpen;
	}
	public boolean hasInfoCard(Card card) { //�����û���鱨
		Boolean boo=false;
		boo=blackCards.indexOf(card)>=0;
		if(!boo)boo=blueCards.indexOf(card)>=0;
		if(!boo)boo=redCards.indexOf(card)>=0;
		return boo;
	}

	public int getOrgRid() {
		return orgRid;
	}

	public void setOrgRid(int orgRid) {
		this.orgRid = orgRid;
	}

	public int getOrgIden() {
		return orgIden;
	}

	public void setOrgIden(int orgIden) {
		this.orgIden = orgIden;
	}

	public Boolean getIsLock() {
		return isLock;
	}

	public void setIsLock(Boolean isLock) {
		this.isLock = isLock;
		if(isLock){
			this.isBeingLocked = true;
			bf.thirdStep=StepCons.LockTarget;
			bf.RedSkillsCheck();
			bf.thirdStep=0;
			this.isBeingLocked = false;
		}
	}

	public void refreshData() {
		WUser wu=getUser();
		wu.datahash.put("exp",wu.getExp());
		wu.datahash.put("coin",wu.getAnte());
		wu.duleCount++;
		wu.datahash.put("duleCount", wu.duleCount);
		if(this.isWin){
			wu.lastWin++;
			if(wu.lastWin>wu.streak)wu.streak=wu.lastWin;
			int winiden=getOrgIden()>-1?getOrgIden():getIndentity();
			wu.winCount[winiden]= String.valueOf(Integer.parseInt(wu.winCount[winiden])+1);
		}else{
			if(wu.lastWin>wu.streak)wu.streak=wu.lastWin;
			wu.lastWin=0;
		}
		int rid=this.getRoleId();
		if(rid<=0)rid=this.orgRid;
		if(rid>0)
		wu.useRole[rid-1]=String.valueOf(Integer.parseInt(wu.useRole[rid-1])+1);
		if(getIsDead() || isLost){
		      wu.deathCount++;
		      wu.datahash.put("deathCount",wu.deathCount);
		}
		wu.killCount+=this.killCount;
		wu.datahash.put("killCount",wu.killCount);
		wu.datahash.put("lastWin",wu.lastWin);
		wu.datahash.put("streak", wu.streak);
		wu.datahash.put("winCount", StringUtil.join(wu.winCount, ','));
		wu.datahash.put("useRole", StringUtil.join(wu.useRole, ',')); 
	}

	public String getHname() {
		return hname;
	}

	public void setHname(String hname) {
		this.hname = hname;
	}
}
