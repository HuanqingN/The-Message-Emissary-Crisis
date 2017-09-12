package extension.manage;

import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.data.Zone;
import it.gotoandplay.smartfoxserver.extensions.AbstractExtension;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;
import extension.Player;
import extension.UserRoom;
import extension.WUser;
import extension.cards.ACard;
import extension.cards.Card;
import extension.cons.Color;
import extension.cons.StepCons;
import extension.data.DCards;
import extension.data.DCardsChild;
import extension.data.Globle;
import extension.data.RolesChild;
import extension.skills.Skill;
import extension.tables.UserTable;
import extension.util.ObjUtil;
import extension.vo.BaseVO;
import extension.vo.ReflectVO;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
public class BattleCtrl extends Thread {
	public int operId=1;
	private Boolean exit=false;
	public UserRoom uRoom;
	public int thirdStep=0;
	final private int dur_usecard=10000;
	public AbstractExtension trigger;
	public Zone zone;
	public ArrayList<Player> roleSeq=new ArrayList<Player>();  //��ɫ����
	public HashMap<Integer,Player> roleMap=new HashMap<Integer, Player>();//��ɫMAP
	public ArrayList<Card> foldstack=new ArrayList<Card>();//���ƶ�
	public ArrayList<Card> foldteststack=new ArrayList<Card>();//��̽���ƶ�
	public Object Lock=new Object();
	public int nowStep;
	public Player nowPlayer;
	public LinkedList<Object> usedCardStack=new LinkedList<Object>();
	public int subStep;
	public boolean isExcute;
	public Card sendingcard;
	public Player sendTarget;
	public Player captureTarget;
	public int skillstep;
	public Object nowSettlement;
	public LinkedList<Card> cards=new LinkedList<Card>();
	public HashMap<Integer,Card> cardsMap=new HashMap<Integer, Card>();
	public ReflectVO endCall;
	public int maxU;
	private HashMap<Integer,Integer> waitChooseArr=new HashMap<Integer, Integer>();
	public ArrayList<Card> nowGetCards=new ArrayList<Card>();
	public ArrayList<Card> infosToBeReceived = new ArrayList<Card>(); //�����鱨���շ���ʱ���Ḵ��nowGetCards����reduction֮ǰ��¼������Ҫ����Ϣ��
	public Player nowGetCardPlayer=null;
	public Player deadman=null;
	public SelectVO sResult=new SelectVO();
	public TargetVO useCard;
	private SkillVO useSkill;
	public Player victoryMan;
	public Player drawingPlayer; //�մ��ƿ����Ƶ���
	public Player initialSendTarget;//�����鱨�����ĵ�һ�����
	private int nsc = 0;//nashui count, ����drawCard������
	public int burnTo=0;
	public int burnTarget=0;
	public ArrayList<Integer> waitDataUsers=new ArrayList<Integer>();
	public void initData(Zone zone2, AbstractExtension extension,UserRoom uroom2, int size) {
		zone=zone2;trigger=extension;uRoom=uroom2;maxU=size;
	}
	public int turncount=0;
	private boolean inited=false;

	@Override
	public void run() {
		while (!exit){
			SmartFoxServer.log.info("�����"+ (++turncount)+"�غ�");
			if(!inited)initRoleInfo();
			goStep(StepCons.StepBegin);
		}
		//		SmartFoxServer.log.info("��Ϸȫ������!");
		if(endCall!=null)ObjUtil.invoke(endCall);
	}
	public void waitfor(int dur){
		if(exit)return;
		isExcute=false;
		synchronized (Lock) {
			try {
				Lock.wait(dur);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			operId++;
			if(exit)return;
			isExcute=true;
		}
	}
	public void wakeup(){
		if(isExcute)return;
		isExcute=true;
		synchronized (Lock) {
			Lock.notify();
		}
	}

	public void getFoldCards(Integer uid){		
		if(foldstack.size()>0){
			ArrayList<Card> temp=new ArrayList<Card>();
			if(foldstack.size()<=20){
				temp=(ArrayList<Card>)foldstack.clone();
			}else{
				temp.addAll(foldstack.subList(foldstack.size()-20, foldstack.size()));
			}
			if(temp.size()>0){
				Collections.reverse(temp);
				ActionscriptObject resp=new ActionscriptObject();
				ActionscriptObject arr=new ActionscriptObject();
				setCardsResp(arr, temp);
				resp.putNumber("h",2);
				resp.putNumber("f",34);
				resp.put("cards", arr);
				Player p=roleMap.get(uid);
				if(p!=null)
					trigger.sendResponse(resp, -1, null, p.getChannel());
			}
		}
	}
	private void setRoleSequence(UserRoom uRoom) {  //������ҵ���λ˳��
		for(WUser wu:uRoom.getUserlist()){
			Player p=new Player();
			p.setUser(wu);
			p.setBf(this);
			roleSeq.add(p);
			roleMap.put(p.getUid(),p);
		}
		Collections.shuffle(roleSeq);
	}

	public void initRoleInfo() { //������ɫ��Ϣ
		setRoleSequence(uRoom);
		ActionscriptObject response=new ActionscriptObject();
		response.putNumber("h",3);
		response.putNumber("f",5);
		response.putNumber("maxu",maxU);
		response.putNumber("oid",operId);
		ActionscriptObject arr=new ActionscriptObject();
		for (int k = 0; k < roleSeq.size(); k++) {
			ActionscriptObject obj=new ActionscriptObject();
			obj.put("rname",roleSeq.get(k).getName());
			obj.putNumber("uid",roleSeq.get(k).getUid());
			arr.put(k,obj);
		}
		response.put("userseq",arr);
		List<RolesChild> al=Globle.getRoledata().getRc();
		if(al.indexOf(Globle.getRoledata().getHash().get(55))>-1) al.remove(al.indexOf(Globle.getRoledata().getHash().get(55)));//ȥ����ɮ�ı���
		Collections.shuffle(al);	
				RolesChild t=Globle.getRoledata().getHash().get(11);   //ָ����ɫ��ע��ȥ��
				al.add(0,t);
//										t=Globle.getRoledata().getHash().get(55);   //ָ����ɫ��ע��ȥ��
//								al.add(3,t);
//								t=Globle.getRoledata().getHash().get(55);   //ָ����ɫ��ע��ȥ��
//								al.add(6,t);
		int index=0;
		//		waitChooseArr=new HashMap<Integer,Integer>();
		for(Player p:roleSeq){
			int rid=al.get(index++).getId();
			waitChooseArr.put(p.getUid(), rid);
			if(p.isExit)continue;
			response.putNumber("num1", rid);
			response.putNumber("num2", al.get(index++).getId());
			response.putNumber("num3", al.get(index++).getId());
			trigger.sendResponse(response, -1,null,p.getChannel());
		}

		waitfor(20*1000);

		if(waitChooseArr.size()>0){
			Iterator<Map.Entry<Integer,Integer>> iter = waitChooseArr.entrySet().iterator();
			while (iter.hasNext()) {
				Map.Entry<Integer,Integer> entry = (Map.Entry<Integer,Integer>) iter.next();
				int key = entry.getKey();
				int val = entry.getValue();
				roleMap.get(key).setRoleId(val);
			}
			waitChooseArr.clear();
		}
		waitChooseArr=null;
		setIdentity();
	}
	public void chooseCard(int uid,int cid){
		if(isExcute)return;
		if(waitChooseArr.containsKey(uid)){
			roleMap.get(uid).setRoleId(cid);
			waitChooseArr.remove(uid);
		}
		if(waitChooseArr.size()==0){
			wakeup();
		}
	}
	private void setIdentity() {   //��������
		ArrayList<Integer> al= getIdentity();	//����������鲢��ֵ
		Collections.shuffle(al);
		nowPlayer=roleSeq.get(0);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();				//���ɻر�����
		int index=0;
		int h=1;
		for(Player p:roleSeq){
			p.setIndentity(al.get(index));
			ActionscriptObject role=new ActionscriptObject();
			role.putNumber("uid",p.getUid());
			if(p.isHiden){
				role.put("hname","����"+h);
				p.setHname("����"+h);
				h++;
			}else{
				role.putNumber("rid",p.getRoleId());
			}
			arr.put(index++,role);
		}
		resp.putNumber("h",2);
		resp.putNumber("f",1);
		resp.put("plist", arr);
		for(Player p:roleSeq){
			if(p.isExit)continue;
			resp.putNumber("rid",p.getRoleId());
			resp.putNumber("iden", p.getIndentity());
			trigger.sendResponse(resp, -1, null,p.getChannel());
		}

		createCards();
		DealingAll();
	}
	/** ȫ�巢��**/
	public void DealingAll(){
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		resp.putNumber("h",2);
		resp.putNumber("f",2);
		for(Player p:roleSeq){
			p.addToHand(getCardFromCardPack(3));
			int index=0;
			if(p.isExit)continue;
			for(Card c:p.handcards){
				ActionscriptObject obj=new ActionscriptObject();
				c.setResponse(obj);
				arr.put(index, obj);
				index++;
			}
			resp.put("cards",arr);
			trigger.sendResponse(resp, -1, null, p.getChannel());
		}
		waitfor(2000);
		inited=true;
	}
	private ArrayList<Integer> getIdentity() {  //��������б�����
		List<Integer> temp=null;
		switch (maxU) {
		case 3:
			temp=Arrays.asList(0,1,2);
			break;
		case 4:
			temp=Arrays.asList(0,0,1,1);
			break;
		case 5:
			temp=Arrays.asList(0,0,1,1,2);
			break;
		case 6:
			temp=Arrays.asList(0,0,1,1,2,2);
			break;
		case 7:
			temp=Arrays.asList(0,0,0,1,1,1,2);
			break;
		case 8:
			temp=Arrays.asList(0,0,0,1,1,1,2,2);
			break;
		}
		return new ArrayList<Integer>(temp);
	}

	public void createCards() {   //���ɿ���
		DCards dc=Globle.getCarddata();
		List<DCardsChild> list=dc.getRc();
		cards=new LinkedList<Card>();
		int index=1;
		for(DCardsChild d:list){
			ACard ac=new ACard();
			ac.setId(d.getId());
			ac.setVid(index);
			ac.setColor(d.getColor());
			ac.setSend(d.getSend());
			cards.add(ac);
			cardsMap.put(ac.getVid(), ac);
			index++;
		}
		Collections.shuffle(cards);  //ϴ��
	}
	public void SendToALL(ActionscriptObject resp){
		if(trigger!=null && resp!=null && uRoom!=null){
			if(exit)return;
			trigger.sendResponse(resp, -1, null,uRoom.getAllChannel());
		}
	}
	public void SendToOther(ActionscriptObject resp,Player p){
		if(roleSeq!=null && trigger!=null && p!=null){
			for(Player r:roleSeq){
				if(r.isExit)continue;
				if(r!=p)trigger.sendResponse(resp, -1, null, r.getChannel());
			}
		}
	}
	public void clearAllStatus(){//���������в���
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("h",2);
		resp.putNumber("f",16);
		SendToALL(resp);
	}

	public Card getCardFromCardPack(){
		if(cards.size()==0){
			cards.addAll(foldstack);
			foldstack.clear();
			Collections.shuffle(cards);
		}
		Card temp=cards.poll();
		return temp;
	}
	public ArrayList<Card> getCardFromCardPack(int i) {//��ÿ�Ƭ�ӿ���
		ArrayList<Card> temp=new ArrayList<Card>();
		for (int j = 0; j < i; j++) {
			if(cards.size()==0){
				cards.addAll(foldstack);
				foldstack.clear();
				Collections.shuffle(cards);
			}
			if(cards.size()>0)
				temp.add(cards.poll());
		}
		return temp;
	}
	public void setCardsResp(ActionscriptObject arr,List<Card> cards){
		int index=0;
		for(Card c:cards){
			ActionscriptObject obj=new ActionscriptObject();
			c.setResponse(obj);
			arr.put(index++, obj);
		}
	}

	public Card getCardFromGraveyard(Card c){
		return foldstack.remove(foldstack.indexOf(c));
	}
	/**
	 * ����
	 * @param p   �������
	 * @param cards  ����
	 * @param rvo   ���䷽��
	 * @param from  �������  1�ƿ�2�Ӷѵ�3����4�鱨��
	 * @param type  ʲô��ʽ�� 1����2����3����
	 * �������type��ʵ��from�ɣ� --���
	 */
	public void drawCard(Player p,ArrayList<Card> cards,int type,ReflectVO rvo){  //���ƿ⵽����
		if(exit)return;
		drawingPlayer = p;
		p.addToHand(cards);
		//		else p.addToHand(getCardFromGraveyard(cardsMap.get(nowSettlement.scard)));
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("h",2);
		resp.putNumber("f",7);
		resp.putNumber("type",type==1?1:2);
		resp.putNumber("to",p.getUid());
		ActionscriptObject arr=new ActionscriptObject();
		setCardsResp(arr, cards);
		resp.put("cards",arr);
		trigger.sendResponse(resp, -1, null, p.getChannel());
		resp.removeElement("cards");
		resp.putNumber("num",cards.size());
		SendToOther(resp, p);

		thirdStep=StepCons.AfterDrawFromDeck;
		boolean hasNashui=false;
		for(Card c : cards){
			if(c.getId()==22){
				hasNashui=true;
				break;
			}
		}
		if (hasNashui){
			for(Player player : roleSeq){
				if(player.getRoleId()==52){
					//					int nsc = 0;//nsc = nashui count
					for(Card c : cards){
						if(c.getId()==22) nsc++;
					}
					while(nsc>0 && !p.getIsDead()){
						SkillVO svo=new SkillVO();
						svo.target=p.getUid();
						svo.sid=162;
						//						svo.color=1;
						//						svo.skillType=1;
						player.skillhash.get(162).play(svo);
						//						RedSkillsCheck();
						nsc--;
					}
				}
			}
		}
		thirdStep=0;
		//		drawingPlayer = null;
	}
	public void drawCard(Player from,Player to,ArrayList<Card> cards,int type,ReflectVO rvo){  //�� 0���� 1�鱨�� �� ����
		if(exit)return;
		if(type==0)	to.addToHand(from.removeCardFromHand(cards, false));
		else if(type==1) to.addToHand(from.removeCardFromInfo(cards, false));
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("h",2);
		resp.putNumber("f",7);
		resp.putNumber("type",type==0?3:4);
		resp.putNumber("from",from.getUid());
		resp.putNumber("to",to.getUid());
		ActionscriptObject arr=new ActionscriptObject();
		setCardsResp(arr, cards);
		resp.put("cards",arr);
		if(type==0){
			trigger.sendResponse(resp, -1, null,to.getChannel());
			trigger.sendResponse(resp, -1, null,from.getChannel());
			resp.removeElement("cards");
			resp.putNumber("num",cards.size());
			for(Player r:roleSeq){
				if(r.isExit)continue;
				if(r!=from && r!=to)trigger.sendResponse(resp, -1, null,r.getChannel());
			}
		}else{
			SendToALL(resp);
		}
		waitfor(1000);
	}

	/**
	 * ����
	 * @param from
	 * @param cards
	 * @param type 1������ 2���鱨
	 * @param rvo
	 */
	public void disCard(Player from,List<Card> cs,int type,ReflectVO rvo){
		if(exit)return;
		if(type==1)	from.removeCardFromHand(cs, true);
		else from.removeCardFromInfo(cs, true);
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		resp.putNumber("h",2);
		resp.putNumber("f",8);
		resp.putNumber("type",type==1?1:2);
		setCardsResp(arr, cs);
		resp.put("cards", arr);
		resp.putNumber("target", from.getUid());
		SendToALL(resp);
		//		waitfor(rvo.dur,rvo);
	}
	public void reduction(Card c){
		if(c.orgSend>=0){  //�����ԭʼ���ݣ���ָ�
			c.setSend(c.orgSend);
			c.orgSend=-1;
		}
		if(c.orgColor>1)c.setColor(c.orgColor);
		if(c.orgId>1)c.setId(c.orgId);

		c.orgId=0;
		c.orgColor=0;
		c.security=false;
		c.heishui=false;
		//		c.shared=false;
	}
	public Player willDead=null;
	/**
	 * 
	 * @param target: ˭���
	 * @param cs: ��õ��鱨����
	 * @param type: 0���ݣ�1���ã�2�Ծ֣�3ѳ��
	 */
	public void getCard(Player target, ArrayList<Card> cs, int type) {//type:0���ݣ�1���ã�2�Ծ֣�3ѳ���� 4��˰����
		if(exit)return;
		for(Card c:cs){
			if(type==2)c.byMiju=true;
			if(type==3)c.byXundao=true;
		}
		Player tempWillDead=null;
		Player tempDeadMan=null;
		Player tempNowGetcardsPlayer=null;
		ArrayList<Card> tempNowGetCards=null;

		copyArrayInfos(cs); //����ֻ����send
		sendCardToInfo(target, cs);
		
		tempNowGetCards=cs;
		tempNowGetcardsPlayer=target;

		//		nowGetCards.add(cs);
		//		nowGetCardPlayer.add(target);
		//		Player willDead=null;
		if(DeathSettlement(target)){    //��û����
			target.setIsDead(true);
			tempWillDead=target;
			//			deadman.add(target);
			thirdStep=StepCons.BeforeDead;
			willDead=tempWillDead;
			nowGetCardPlayer=tempNowGetcardsPlayer;
			nowGetCards=tempNowGetCards;
			RedSkillsCheck();
			thirdStep=0;
			tempNowGetCards.get(0).getOwner().nowTurnKillCount++;
			if(VictoryKillSettlement(target)){    //�ж�ɱ��ʤ��
				VictoryExcute(victoryMan);
				return;
			}
		}else{
			if(VictoryInfoSettlement(target)){  //�ж��ռ��ձ�ʤ��
				nowGetCardPlayer=tempNowGetcardsPlayer;
				nowGetCards=tempNowGetCards;
				VictoryExcute(target);
				return;
			}
		}
		if(!target.getIsDead() && nowStep==StepCons.InfoReceive && type==0)    //�����ĵ����
			checkIsShardInfo(cs.get(0),target);
		if(!target.getIsDead()  && type==4)    //��˰���
			checkIsNashuiInfo(cs.get(0),target);

		if(tempWillDead!=null && tempWillDead.getIsDead()){
			tempDeadMan=tempWillDead;
			willDead=null;
		}

		thirdStep=StepCons.AfterDead;
		deadman=tempDeadMan;
		nowGetCardPlayer=tempNowGetcardsPlayer;
		nowGetCards=tempNowGetCards;
		RedSkillsCheck();
		thirdStep=0;
		if(tempDeadMan!=null){
			//			if(deadman.getLast().getIsDead()){
			tempDeadMan.excuteDeath();
			tempNowGetCards.get(0).getOwner().killCount++;
			//				if(nowGetCards!=null && nowGetCards.size()>0 &&  nowGetCards.getLast().size()>0 && nowGetCards.getLast().get(0).getOwner()!=null)
			//				nowGetCards.getLast().get(0).getOwner().killCount++;
			thirdStep=StepCons.AfterDeadTaskCheck;
			deadman=tempDeadMan;
			nowGetCardPlayer=tempNowGetcardsPlayer;
			nowGetCards=tempNowGetCards;
			ArrayList<Player> winer=checkTask();
			if(winer.size()>0){
				victoryMan=winer.get(0);
				winners.addAll(winer);
				VictoryExcute(victoryMan);
				return;
			}
			thirdStep=0;
			//			}
			//			deadman.removeLast();
			deadman=null;
		}
		//		nowGetCardPlayer.removeLast();
		for(Card c:tempNowGetCards){
			c.shared=false;
			c.byMiju=false;
			c.byXundao=false;
		}
		nowGetCardPlayer=null;
		nowGetCards.clear();
		infosToBeReceived.clear();
		//		nowGetCards.removeLast();
	}
	
	private void copyArrayInfos(ArrayList<Card> infos){
		for (Card c : infos){
			copyCardInfo(c);
		}
	}
	
	private void copyCardInfo(Card info){
		Card c = new Card();
		c.setSend(info.getSend());
		infosToBeReceived.add(c);
	}

	private void sendCardToInfo(Player target, ArrayList<Card> cs) {
		for(Card card:cs){
			reduction(card);
			card.getTurn=turncount;
			target.infocards.add(card);
			int color=card.getColor();
			switch (color) {
			case Color.BLUE:
				target.blueCards.add(card);
				break;
			case Color.RED:
				target.redCards.add(card);
				break;
			case Color.BLACK:
				target.blackCards.add(card);
				break;
			case Color.BLUEBLACK:
				target.blueCards.add(card);
				target.blackCards.add(card);
				break;
			case Color.REDBLACK:
				target.redCards.add(card);
				target.blackCards.add(card);
				break;
			}
		}
	}
	public Boolean VictoryInfoSettlement(Player p) {  //�鱨ʤ������
		ArrayList<Player> winer=new ArrayList<Player>();
		switch (p.getIndentity()) {
		case 0:    //����
			if(p.blueCards.size()>=3){
				winer.add(p);
				victoryMan=p;
				addSameIdenIntoWinners(p);
			}
			break;
		case 1:    //Ǳ��
			if(p.redCards.size()>=3){
				winer.add(p);
				victoryMan=p;
				addSameIdenIntoWinners(p);
			}
			break;
		case 2:    //����
			if(p.checkTask()){
				winer.add(p);
				victoryMan=p;
			}
			break;
		}
		return winer.size()>0;
	}

	private Boolean VictoryKillSettlement(Player target) {   //ɱ��ʤ������
		ArrayList<Player> winer=checkTask();
		if(winer.size()>0){
			victoryMan=winer.get(0);
			winners.addAll(winer);
		}

		int max=maxU;
		ArrayList<Player> temp=getAlivePlayers();
		switch (max) {
		case 3:
			if(temp.size()<=2 && sameIden(temp)){
				if(temp.size()==1){
					if(temp.get(0).getIndentity()==2){
						winners.add(temp.get(0));
					}
				}
				addSameIdenIntoWinners(temp.get(0));
				if(victoryMan == null)
					victoryMan=temp.get(0);
			}
			break;
		case 4:
			if(temp.size()<=3 && sameIden(temp)){
				if(temp.size()==1){
					if(temp.get(0).getIndentity()==2){
						winners.add(temp.get(0));
					}
				}
				addSameIdenIntoWinners(temp.get(0));
				if(victoryMan == null)
					victoryMan=temp.get(0);
			};
			break;
		case 5:
			if(temp.size()<=3 && sameIden(temp)){
				if(temp.size()==1){
					if(temp.get(0).getIndentity()==2){
						winners.add(temp.get(0));
					}
				}
				addSameIdenIntoWinners(temp.get(0));
				if(victoryMan == null)
					victoryMan=temp.get(0);
			}
			break;
		case 6:
			if(temp.size()<=3 && sameIden(temp)){
				if(temp.size()==1){
					if(temp.get(0).getIndentity()==2){
						winners.add(temp.get(0));
					}
				}
				addSameIdenIntoWinners(temp.get(0));
				if(victoryMan == null)
					victoryMan=temp.get(0);
			}
			break;
		case 7:
			if(temp.size()<=4 && sameIden(temp)){
				if(temp.size()==1){
					if(temp.get(0).getIndentity()==2){
						winners.add(temp.get(0));
					}
				}
				addSameIdenIntoWinners(temp.get(0));
				if(victoryMan == null)
					victoryMan=temp.get(0);
			}
			break;
		case 8:
			if(temp.size()<=5 && sameIden(temp)){
				if(temp.size()==1){
					if(temp.get(0).getIndentity()==2){
						winners.add(temp.get(0));
					}
				}
				addSameIdenIntoWinners(temp.get(0));
				if(victoryMan == null)
					victoryMan=temp.get(0);
			}
			break;
		}
		return winners.size()>0;
	}
	public ArrayList<Player> getAlivePlayers(){
		ArrayList<Player> temp=new ArrayList<Player>();
		for (Player p : roleSeq) {
			if(p.getIsDead() || p.isLost){

			}else{
				temp.add(p);
			}
		}
		return temp;
	}

	private void addSameIdenIntoWinners(Player announceman){
		if(announceman.getIndentity()!=2){
			for(Player p: roleSeq){
				if(p.getIndentity()==announceman.getIndentity()){
					if(winners.indexOf(p)<0)
						winners.add(p);
				}
			}
		}
	}

	private boolean sameIden(ArrayList<Player> rs) {//��ʣ�µ����Ƿ���ͬ��Ӫ
		if(rs.size()<2)return true;
		int iden=-1;
		for(Player p:rs){
			if(p.getIndentity()!=2){
				iden=p.getIndentity();
				break;
			}
		}
		for (int i = 0; i < rs.size(); i++) {
			if(rs.get(i).getIndentity()!=iden){
				return false;
			}
		}
		return true;
	}

	private Boolean DeathSettlement(Player p) {  //��������
		if(p.isGod)return false;
		if(p.getRoleId()==29 && p.isPoison<1) return (p.blackCards.size()>=4);
		return (p.blackCards.size()>=3);  //����
	}
	private void checkIsShardInfo(Card card, Player p) {
		if(exit)return;
		if(card.getId()>=19 && card.getId()<=21){ //�ǹ����ĵ�
			int cid=card.getId();
			Card ca=null;
			if(p.getIndentity()==0 && (cid==20 || cid==21)){
				ca=getCardFromCardPack();
			}else if(p.getIndentity()==1 && (cid==19 || cid==21)){
				ca=getCardFromCardPack();
			}else if(p.getIndentity()==2 && (cid==19 || cid==20)){
				ca=getCardFromCardPack();
			}
			if(ca==null)return;
			ArrayList<Card> temp=new ArrayList<Card>();
			temp.add(ca);
			drawCard(p, temp, 1, null);
			waitfor(1000);
		}
	}
	private void checkIsNashuiInfo(Card card, Player p) {
		if(exit)return;
		if(card.getId()==22){ //����˰
			Card ca=null;
			ca=getCardFromCardPack();
			if(ca==null)return;
			ArrayList<Card> temp=new ArrayList<Card>();
			temp.add(ca);
			drawCard(p, temp, 1, null);
			waitfor(1000);
		}
	}
	public ArrayList<Player> winners=new ArrayList<Player>();

	public void VictoryExcute(Player p){
		if(victoryMan==null) victoryMan = p;
		thirdStep=StepCons.Victory;
		ArrayList<Player> winer=checkTask();
		if(winer.size()>0){
			winners.addAll(winer);
		}
		RedSkillsCheck();
		int iden=victoryMan.getIndentity();
		int totalReward=uRoom.getAnte()*maxU;
		//		int trickyReward=(int)(totalReward*0.05);
		int[] reward=getReward(totalReward);
		int trickySoyReward=reward[0];
		int trickyCampReward=reward[1];
		int commonReward=reward[2];

		int[] exp=getExp(maxU);
		int commonAnnounceExp=exp[0];
		int soyAnnounceExp=exp[1];
		int campLostExp=exp[2];
		int soyLostExp=exp[3];		

		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("h",2);
		resp.putNumber("f",24);
		resp.putNumber("iden",iden);
		resp.putNumber("victoryMan",victoryMan.getRoleId());
		ActionscriptObject arr=new ActionscriptObject();
		int index=0;
		for(Player rs:roleSeq){
			ActionscriptObject obj=new ActionscriptObject();
			obj.putNumber("uid",rs.getUid());
			obj.putNumber("orgcoin",rs.getUser().getAnte());
			obj.putNumber("orgexp",rs.getUser().getExp());
			obj.putNumber("rid",rs.getOrgRid()>0?rs.getOrgRid():rs.getRoleId());
			obj.put("rname",rs.getUser().getNickName());
			obj.putNumber("iden",rs.getOrgIden()>-1?rs.getOrgIden():rs.getIndentity());
			boolean iswin=winners.indexOf(rs)>=0;
			obj.putBool("isWin",iswin);
			rs.isWin=iswin;
			int coin=0;
			int gainedExp=0;
			if(iswin){
				if(winners.size()<maxU*0.5 && !purelySameIden(winners)){
					coin =obj.getNumber("iden")==2?trickySoyReward:trickyCampReward;
				}else{
					coin =commonReward;
				}
				//				if(victoryMan==rs)coin+=winnerReward;
				rs.getUser().setAnte(rs.getUser().getAnte()+coin-uRoom.getAnte());
				if(rs.getIndentity()==2){
					gainedExp=victoryMan==rs?soyAnnounceExp:commonAnnounceExp;
				}else{
					gainedExp=commonAnnounceExp;
				}
			}else{
				rs.getUser().setAnte(rs.getUser().getAnte()-uRoom.getAnte());
				if(rs.getIndentity()==2){
					gainedExp=soyLostExp;
				}else{
					gainedExp=campLostExp;
				}
			}
			rs.getUser().setExp(rs.getUser().getExp()+gainedExp);
			rs.refreshData();
			//			rs.getUser().datahash.put("exp",rs.getUser().getAnte());
			//			UserTable.inst().updateCoin(rs.getUser().getAnte(),rs.getUid(), zone.dbManager);
			obj.putNumber("coin",rs.getUser().getAnte());
			obj.putNumber("exp",rs.getUser().getExp());
			arr.put(index++,obj);
		}
		resp.put("users", arr);
		SendToALL(resp);
		waitfor(3000);
		EndGame();
	}
	private int[] getReward(int ante) {
		int soycount=0;
		int campcount=0;
		int[] result=new int[3];
		for(Player p:winners){
			if(p.getIndentity()==2)soycount++;
		}
		for(Player p:winners){
			if(p.getIndentity()!=2)campcount++;
		}
		if(winners.size()<maxU*0.5 && !purelySameIden(winners)){
			//			int temp= (int)(ante/winners.size()*(1/(1+soycount)));
			result[0]=(int)(ante/winners.size()+ante*0.05);
			result[1]=(int)(ante/winners.size()-ante*0.05*soycount/campcount);
		}else{
			result[2]=(int)(ante/winners.size());
		}
		return result;
	}

	private int[] getExp(int pn){
		int[] result=new int[4];
		if(uRoom.getAnte()>0){
			result[0]=(pn-2)*2;
			result[1]=pn*2;
			result[2]=(pn-2);
			result[3]=pn;
		}
		return result;
	}

	private boolean purelySameIden(ArrayList<Player> rs) {//�Ƿ���Ӫ����ͬ�����������뽴�ͣ�
		if(rs.size()<2)return true;
		int iden=-1;
		for(Player p:rs){
			//			if(p.getIndentity()!=2){
			iden=p.getIndentity();
			break;
			//			}
		}
		for (int i = 0; i < rs.size(); i++) {
			if(rs.get(i).getIndentity()!=iden){
				return false;
			}
		}
		return true;
	}

	//	public void VictoryExcute(Player p){
	//		thirdStep=StepCons.Victory;
	//		ArrayList<Player> winer=checkTask();
	//		if(winer.size()>0){
	//			winners.addAll(winer);
	//		}
	//		RedSkillsCheck();
	//		int iden=victoryMan.getIndentity();
	//		int totalReward=uRoom.getAnte()*maxU;
	//		int winnerReward=(int)(totalReward*0.1);
	//		int[] reward=getReward(totalReward-winnerReward);
	//		int soyReward=reward[0];
	//		int campReward=reward[1];
	//		ActionscriptObject resp=new ActionscriptObject();
	//		resp.putNumber("h",2);
	//		resp.putNumber("f",24);
	//		resp.putNumber("iden",iden);
	//		ActionscriptObject arr=new ActionscriptObject();
	//		int index=0;
	//		for(Player rs:roleSeq){
	//			ActionscriptObject obj=new ActionscriptObject();
	//			obj.putNumber("uid",rs.getUid());
	//			obj.putNumber("orgcoin",rs.getUser().getAnte());
	//			obj.putNumber("rid",rs.getOrgRid()>0?rs.getOrgRid():rs.getRoleId());
	//			obj.put("rname",rs.getUser().getNickName());
	//			obj.putNumber("iden",rs.getOrgIden()>-1?rs.getOrgIden():rs.getIndentity());
	//			boolean iswin=winners.indexOf(rs)>=0;
	//			obj.putBool("isWin",iswin);
	//			int coin=0;
	//			if(iswin){
	//				coin =obj.getNumber("iden")==2?soyReward:campReward;
	//				if(victoryMan==rs)coin+=winnerReward;
	//				rs.getUser().setAnte(rs.getUser().getAnte()+coin-uRoom.getAnte());
	//			}else{
	//				rs.getUser().setAnte(rs.getUser().getAnte()-uRoom.getAnte());
	//			}
	//			rs.getUser().datahash.put("exp",rs.getUser().getAnte());
	//			UserTable.inst().updateCoin(rs.getUser().getAnte(),rs.getUid(), zone.dbManager);
	//			obj.putNumber("coin",rs.getUser().getAnte());
	//			arr.put(index++,obj);
	//		}
	//		resp.put("users", arr);
	//		SendToALL(resp);
	//		waitfor(3000);
	//		EndGame();
	//	}
	//	private int[] getReward(int ante) {
	//		int soycount=0;
	//		int[] result=new int[2];
	//		for(Player p:winners){
	//			if(p.getIndentity()==2)soycount++;
	//		}
	//		if(soycount>0){
	//			int temp= (int)(ante/winners.size()*(1/(1+soycount)));
	//			result[0]=(int)(ante/winners.size()+temp*(winners.size()-soycount));
	//			result[1]=temp;
	//		}else{
	//			result[0]=0;
	//			result[1]=(int)(ante/winners.size());
	//		}
	//		return result;
	//	}
	public void UseCard(TargetVO target) {//����ʹ�÷���
		if(exit)return;
		//		SmartFoxServer.log.info("����ʹ��");
		useCard=target;
		clearAllStatus();
		wakeup();
	}
	public void CardLaunch() {
		if(exit)return;
		//		SmartFoxServer.log.info("���ƻ��ܷ���");
		subStep=StepCons.CardLaunch;
		Player sponsor=roleMap.get(useCard.sponsor);
		if(useCard.sid==0){
			usedCardStack.add(useCard);
			useCard.cid=cardsMap.get(useCard.cvid).getId();
			useCard.color=cardsMap.get(useCard.cvid).getColor();
			sponsor.removeCardFromHand(useCard.cvid,false);     //�ѿ��ƴ������Ƴ�
			ActionscriptObject resp =new ActionscriptObject();     //֪ͨ�����˴����
			resp.putNumber("h",2);
			resp.putNumber("f",5);
			useCard.setResponse(resp);
			if(useCard.cid>=13 && useCard.cid<=19){//����̽���͸�
				resp.putNumber("cid", 99);
				resp.putNumber("color", 0);
			}
			SendToALL(resp);
			waitfor(1000);
		}else{
			//			Skill s=sponsor.skillhash.get(useCard.sid);
			Skill s=ObjUtil.getSkillClassByID(useCard.sid);
			s.copyBasicInfo(sponsor.skillhash.get(useCard.sid));
			usedCardStack.add(s);
			s.play((SkillVO)useCard);
		}

		CardLaunchAnswer();
	}
	public void CardLaunchAnswer(){  //���Ʒ�����Ӧ
		if(exit)return;
		//		SmartFoxServer.log.info("���Ƽ��ܷ�����Ӧ");
		if(checkAllAction(0)){   //�п������Ƶ���
			sendAllCanUsePlayer(dur_usecard);
			useCard=null;
			waitfor(dur_usecard);
			if(useCard!=null){
				CardLaunch();
			}
		}
	}

	public void CardSettlementAnswer(){  //������Ӧ
		if(exit)return;
		//		SmartFoxServer.log.info("���Ƽ��ܽ�����Ӧ");
		subStep=StepCons.CardSettlement;
		nowSettlement=usedCardStack.getLast();
		if(checkAllAction(2)){   //�п���ʹ�ú켼�ܵ���
			LinkedList<Skill> canuseSkill=checkRedSkill();
			if(canuseSkill.size()>0){
				RedSkillLaundch(canuseSkill);
			}
		}
		if(nowSettlement instanceof TargetVO && ((TargetVO) nowSettlement).disabled==false){
			Card card=cardsMap.get(((TargetVO)nowSettlement).cvid);
			card.getOwner().lastUsedCard=card;
		}
		CardSettlementAction();
	}


	public void CardSettlementAction(){  //���㶯��
		if(exit)return;
		//		SmartFoxServer.log.info("���Ƽ��ܽ���");
		//		TargetVO tvo= (TargetVO)usedCardStack.removeLast();
		Object tvo= usedCardStack.removeLast();
		if(tvo instanceof TargetVO){
			TargetVO tvo1=(TargetVO)tvo;
			Card card=cardsMap.get(tvo1.cvid);
			if(tvo1.disabled){
				sendUsedCardTo(card,tvo1.moveto);
			}else{
				card.play(tvo1);
				subStep=StepCons.CardSettlementEnd;
				if(checkAllAction(2)){   //�п���ʹ�ú켼�ܵ���
					//					SmartFoxServer.log.info("�п���ʹ�õĺ켼��");
					LinkedList<Skill> canuseSkill=checkRedSkill();
					if(canuseSkill.size()>0){
						RedSkillLaundch(canuseSkill);
					}
				}
				sendUsedCardTo(card,tvo1.moveto);
			}

		}else{//����
			//			Player p=roleMap.get(tvo.sponsor);
			//			Skill s=p.skillhash.get(tvo.sid);
			Skill s=(Skill)tvo;
			s.excute();
		}
	}

	public void sendUsedCardTo(Card c,int type){
		if(type<0){

		}else{
			ActionscriptObject resp=new ActionscriptObject();
			resp.putNumber("h",2);
			resp.putNumber("f",32);
			resp.putNumber("moveto",type);
			SendToALL(resp);
			if(type==0){
				sendCardToGraveyard(c);
			}else{
				//				Player sp=roleMap.get(nowSettlement.sponsor);
				//				sp.addToHand(cardsMap.get(nowSettlement.cvid));
			}
		}

	}
	public Player getRandomPlayer() {
		ArrayList<Player> temp=getAlivePlayers();
		Collections.shuffle(temp);
		return temp.get(0);
	}
	public void sendCardToGraveyard(List<Card> cards){
		for(Card c:cards){
			sendCardToGraveyard(c);
		}
	}
	public void sendCardToGraveyard(Card card){
		reduction(card);
		if((card.getId()>=13 && card.getId()<=18) || card.getId()==22){
			if(foldteststack.indexOf(card)<0)foldteststack.add(card);
		}else{
			if(foldstack.indexOf(card)<0)foldstack.add(card);
		}
	}
	public Card getCardFromFold(int vid){   //�����ƶ����ҿ�
		Card c=cardsMap.get(vid);
		if(c!=null){
			c=foldstack.get(foldstack.indexOf(c));
			if(c==null)return foldteststack.get(foldteststack.indexOf(c));
			else return c; 
		}
		return null;
	}
	public void userExit(int userId,int type) { //�û��뿪 1�뿪2����
		roleMap.get(userId).isExit=true;
		roleMap.get(userId).trusttee=true;
		Boolean b=true;
		for(Player p:roleSeq){
			if(!p.isExit){
				b=false;
				break;
			}
		}
		if(b){
			EndGame();
			//			SmartFoxServer.log.info("all exited and endgame now!!!");
			return;
		}
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("type",2);
		resp.putNumber("uid", userId);
		resp.putBool("boo",true);
		resp.putNumber("h",2);
		resp.putNumber("f",26);
		SendToALL(resp);
	}
	public void dipose() {
		waitDataUsers.clear();
		waitDataUsers=null;
	}
	public void EndGame(){  //������Ϸ
		//		SmartFoxServer.log.info("������Ϸ");
		exit=true;
		isExcute=true;
		synchronized (Lock) {
			Lock.notify();
		}
		try {
			this.interrupt();
		} catch (Exception e) {

		}
	}
	private void sendToAllStepIndex(int index) {
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("index",index);
		resp.putNumber("h",2);
		resp.putNumber("f",21);
		SendToALL(resp);
	}

	private void sendDataToReconnectUsers(){
		if(waitDataUsers.size()>0){
			//			ActionscriptObject response=new ActionscriptObject();
			//			response.putNumber("h",3);
			//			response.putNumber("f",15);
			//			Player p=roleMap.get(waitDataUsers.get(0));
			////			rec.add(u.getChannel()); 
			//			
			//			SmartFoxServer.log.info("send user ID is "+p.getUid());
			//			trigger.sendResponse(response, -1,null,p.getChannel());
			for(int uid:waitDataUsers){
				ActionscriptObject response=new ActionscriptObject();
				response.putNumber("h",3);
				response.putNumber("f",15);
				response.putNumber("maxu",maxU);
				response.putNumber("nowStep",nowStep);
				response.putNumber("tid",uRoom.getId());
				ActionscriptObject arr=new ActionscriptObject();
				Player toUser=null;
				for (int k = 0; k < roleSeq.size(); k++) {
					ActionscriptObject obj=new ActionscriptObject();
					Player p=roleSeq.get(k);
					obj.put("rname",p.getName());
					obj.putNumber("uid",p.getUid());
					if(p.isHiden==false && p.getIsOpen()==false){
						obj.putNumber("rid",p.getUid()==uid?p.getRoleId():0);
					}else{
						obj.putNumber("rid",p.getRoleId());
					}
					obj.putNumber("sex",p.sex);
					obj.putNumber("indentity",p.getIndentity());
					obj.putNumber("isPoison",p.isPoison);
					obj.putBool("isHiden",p.isHiden);
					obj.putBool("isOpen",p.getIsOpen());
					obj.putBool("idenShow",p.idenShow);
					obj.putBool("trusttee",p.trusttee);
					obj.putBool("isExit",p.isExit);
					obj.putBool("isLost",p.isLost);
					obj.putBool("trueDead",p.trueDead);
					obj.putNumber("myTurn",nowPlayer.getUid());
					obj.put("hname", p.getHname());
					ActionscriptObject bc=new ActionscriptObject();
					setCardsResp(bc,p.blueCards);
					obj.put("bluecards", bc);
					ActionscriptObject blc=new ActionscriptObject();
					setCardsResp(blc,p.blackCards);
					obj.put("blackcards", blc);
					ActionscriptObject rc=new ActionscriptObject();
					setCardsResp(rc,p.redCards);
					obj.put("redcards", rc);
					if(p.getUid()==uid){
						toUser=p;
						ActionscriptObject hc=new ActionscriptObject();
						setCardsResp(hc,p.handcards);
						obj.put("handcards", hc);
					}else{
						obj.putNumber("handcards",p.handcards.size());
					}

					arr.put(k,obj);
				}
				response.put("userseq",arr);
				trigger.sendResponse(response, -1, null, toUser.getChannel());
				userTrusttee(uid, false,1);
				userTrusttee(uid, false,2);
			}
			waitDataUsers.clear();
		}
	}
	public Player getNextPlayer(Player p) {   //�����һλ��ң�����nowpLAYER
		int index=roleSeq.indexOf(p);
		index++;
		if(index==roleSeq.size())index=0;
		Player result=roleSeq.get(index);
		if(result.getIsDead() || result.isLost) return getNextPlayer(result);
		else return result;
	}

	public ArrayList<Player> getSeqPalyers(){
		ArrayList<Player> temp=new ArrayList<Player>();
		int index=roleSeq.indexOf(nowPlayer);
		temp.addAll(roleSeq.subList(index,roleSeq.size()));
		temp.addAll(roleSeq.subList(0,index));
		for (Iterator iter = temp.iterator(); iter.hasNext();) {
			Player p = (Player) iter.next();
			if(p.trueDead || p.isLost)iter.remove();
		}
		return temp;
	}
	//0ȫ�� 1ֻ�� 2ֻ����
	public Boolean checkAllAction(int type){
		Boolean boo=false;
		for(Player p:roleSeq){
			p.setPass(false);
			p.check(type);
			if(type<2){
				if(p.canUseCard.size()>0){
					boo=true;
				}
			}
			if(type!=1){
				if(p.canUseSkill.size()>0){
					boo=true;
				}
			}
		}
		return boo;
	}

	public ArrayList<Player> checkTask(){
		ArrayList<Player> result=new ArrayList<Player>();
		for(Player p:roleSeq){
			if(p.getIndentity()==2 && p.trueDead==false && p.checkTask() && winners.indexOf(p)<0)result.add(p);
		}
		return result;
	}
	public LinkedList<Skill> checkRedSkill() {
		ArrayList<Player> temp=getSeqPalyers();
		LinkedList<Skill> canuse=new LinkedList<Skill>();
		for(Player p:temp){
			if(p.canUseSkill.size()>0){
				for (Iterator<Skill> iter = p.canUseSkill.iterator(); iter.hasNext();) {
					Skill s = (Skill) iter.next();
					if(s.color==1){
						if(s.id==30)    //����Ǿ����ͷŵ�һλ
							canuse.addFirst(s);
						else
							canuse.add(s);
						iter.remove();
					}
				}
			}
		}
		return canuse;
	}
	public void RedSkillLaundch(LinkedList<Skill> skills){
		if(exit)return;
		//		SmartFoxServer.log.info("��ɫ���ܷ���"+skills);
		skillstep=StepCons.SkillLaunch;
		while(skills.size()>0){
			if(exit)break;
			Skill s=skills.pollFirst();
			if(s.getOwner().trueDead || s.getOwner().isPoison>0)continue;

			if(s.auto){
				SkillVO svo=new SkillVO();
				svo.sponsor=s.getOwner().getUid();
				svo.sid=s.id;
				svo.color=s.color;
				useSkill=svo;
				RedSkillSettlement(s);
			}else{
				ActionscriptObject resp=new ActionscriptObject();
				ActionscriptObject obj=new ActionscriptObject();
				obj.putNumber("sid",s.id);
				resp.putNumber("uid", s.getOwner().getUid());
				resp.putNumber("h",2);
				resp.putNumber("f",29);
				resp.putNumber("time", 10000);
				resp.put("skill",obj);
				resp.putNumber("oid", operId);
				SendToALL(resp);
				useSkill=null;
				waitfor(10000);
				if(useSkill!=null){
					RedSkillSettlement(s);
					if(s.id==30 || s.id==145){
						skills.clear();
						break;  //��������������ͽ�����
					}
				}
			}
		}
		skillstep=0;
	}
	public void RedSkillSettlement(Skill s){//�������㼼�ܽ���
		if(exit)return;
		clearAllStatus();
		skillstep=StepCons.SkillLaunch;
		//		Player p=roleMap.get(useSkill.sponsor);
		//		Skill s=p.skillhash.get(useSkill.sid);
		s.play(useSkill);
	}
	public void sendAllCanUsePlayer(int dur){  //�����пɷ����Ƶ���ҷ�������
		if(exit)return;
		ActionscriptObject uid=new ActionscriptObject();
		int count=0;
		for(Player p:roleSeq){
			if(p.canUseCard.size()>0 || p.canUseSkill.size()>0){
				ActionscriptObject obj=new ActionscriptObject();
				obj.putNumber("uid",p.getUid());
				uid.put(count,obj);
				count++;
			}
		}
		for(Player p:roleSeq){
			ActionscriptObject resp=new ActionscriptObject();
			if(p.canUseCard.size()>0){
				ActionscriptObject arr=new ActionscriptObject();
				int index=0;
				for(Card card:p.canUseCard){
					ActionscriptObject obj=new ActionscriptObject();
					obj.putNumber("vid",card.getVid());
					arr.put(index, obj);
					index++;
				}
				resp.put("cards",arr);
			}
			if(p.canUseSkill.size()>0){
				ActionscriptObject arr=new ActionscriptObject();
				int index=0;
				for(Skill skill:p.canUseSkill){
					ActionscriptObject obj=new ActionscriptObject();
					obj.putNumber("sid",skill.id);
					arr.put(index, obj);
					index++;
				}
				resp.put("skills",arr);
			}
			resp.putNumber("oid",operId);
			resp.putNumber("uid", p.getUid());
			resp.putNumber("h",2);
			resp.putNumber("f",4);
			resp.putNumber("time", dur);
			resp.put("users", uid);
			trigger.sendResponse(resp, -1, null, p.getChannel());
			resp.removeElement("cards");
			resp.removeElement("skills");
		}
	}
	public void watingforOperationResult(int uid){
		if(exit)return;
		//		SmartFoxServer.log.info("�ȴ���������");
		if(isExcute)return;   //��������˾ͷ�����
		Player p1=roleMap.get(uid);
		p1.setPass(true);
		Boolean boo=true;
		for(Player p:roleSeq){
			if(p.isPass()==false){
				boo=false;
				break;
			}
		}
		if(boo){ //ȫ��PASS
			clearAllStatus();
			wakeup();
		}
	}

	public void CardUse() {				//���ƽ׶�
		if(exit)return;
		if(nowPlayer.getIsDead()==true){
			nowStep=StepCons.StepEnd;
			sendToAllStepIndex(nowStep);
			StepEnd();
			return;
		}
		//		SmartFoxServer.log.info("���ƽ׶�"+(nowStep==StepCons.CardUse1?1:2));
		while(checkAllAction(0)){   //�п���ʹ�ÿ��Ƶ���
			//			SmartFoxServer.log.info("���ƽ׶��п��Գ�����");
			sendAllCanUsePlayer(dur_usecard);
			useCard=null;
			waitfor(dur_usecard);
			if(useCard!=null){
				CardLaunch();
				launchCardOrSkill();
			}else{
				break;
			}
		}

		if(nowStep==StepCons.CardUse1)
			waitforSend();
		else if(nowStep==StepCons.CardUse2)
			goStep(StepCons.StepEnd);

	}
	private void launchCardOrSkill() {
		if(exit)return;
		while(usedCardStack.size()>0){
			if(exit)return;
			CardSettlementAnswer();
		}
		subStep=0;
		nowSettlement=null;
	}
	public void waitforSend() {   //�ȴ����鱨
		if(exit)return;
		//		SmartFoxServer.log.info("�ȴ����鱨");
		nowStep=StepCons.InfoWait;
		clearAllStatus();
		if(nowPlayer.handcards.size()==0){
			LoseSettlement(nowPlayer);
			return;
		}
		sResult.dispose();
		if(nowPlayer.trusttee){
			SendInfo(sResult);
			return;
		}

		if(checkAllAction(2)){   //�п���ʹ�ú켼�ܵ���
			//			SmartFoxServer.log.info("�п���ʹ�õĺ켼��");
			LinkedList<Skill> canuseSkill=checkRedSkill();
			if(canuseSkill.size()>0){
				RedSkillLaundch(canuseSkill);
			}
		}
		if(sResult.card==0){
			ActionscriptObject resp=new ActionscriptObject();
			resp.putNumber("target",nowPlayer.getUid());
			resp.putNumber("h",2);
			resp.putNumber("f",13);
			resp.putNumber("oid", operId);
			resp.putNumber("time", 10000);
			SendToALL(resp);
			waitfor(dur_usecard);
		}
		SendInfo(sResult);
	}

	/**ѡ���鱨����  **/
	public void SendInfo(SelectVO svo) {  //
		if(exit)return;
		//		SmartFoxServer.log.info("ѡ���鱨����");
		if(svo.card==0){        //��Ҳ�����ʱ�Զ�ѡ
			int rnum=(int)(Math.random()*nowPlayer.handcards.size());
			Card c=nowPlayer.handcards.get(rnum);
			svo.card=c.getVid();
			if(c.getSend()==1)svo.target=getNextPlayer(nowPlayer).getUid();
		}
		for(Card c:nowPlayer.handcards){    //���ݴ��ݷ�ʽȷ������Ŀ��
			if(c.getVid()==svo.card){
				sendingcard=c;
				if(c.getSend()==2)c.shared=true;
				//				SmartFoxServer.log.info("׼������ʱ,�鱨��������:::::   " +sendingcard.getSend());
				if(c.getSend()==1){
					sendTarget=roleMap.get(svo.target);
					initialSendTarget=roleMap.get(svo.target);
				}else{
					sendTarget=getNextPlayer(nowPlayer);
					initialSendTarget=getNextPlayer(nowPlayer);
				}
				nowPlayer.removeCardFromHand(svo.card,false);
				break;
			}
		}
		goStep(StepCons.InfoSend);
	}
	/**�����鱨��**/
	public void InfoSend() { 
		if(exit)return;
		//		SmartFoxServer.log.info("�鱨����"+sendingcard.getSend());
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		sendingcard.setResponse(obj);  //bug
		if(sendingcard.getSend()!=2){  //�����ı�
			obj.putNumber("id", 0);
			obj.putNumber("color",sendingcard.getSend()==1?1:0);       //bug
		}
		resp.put("card", obj);
		resp.putNumber("to",sendTarget.getUid());     //bug
		resp.putNumber("from", nowPlayer.getUid());
		resp.putNumber("h",2);
		resp.putNumber("f",14);
		SendToALL(resp);
		waitfor(2000);
		InfoSendAnswer();
		//		setTimer("InfoSendEnd", null,null, 2000);
	}
	public void InfoSendAnswer(){
		if(exit)return;
		//		SmartFoxServer.log.info("�鱨���ݿ��Ƽ�����Ӧ"+sendingcard.getSend());
		while(checkAllAction(0)){   //�п���ʹ�ÿ��Ƶ���
			sendAllCanUsePlayer(dur_usecard);
			useCard=null;
			waitfor(dur_usecard);
			if(useCard!=null){
				CardLaunch();
				launchCardOrSkill();
			}else{
				break;
			}
		}
		goStep(StepCons.InfoArrive);
	}
	/**�鱨����**/
	public void InfoArrive(){
		if(exit)return;
		int orgSendTarget=sendTarget.getUid();
		//		SmartFoxServer.log.info("�鱨������Ӧ"+sendingcard.getSend());
		while(checkAllAction(0)){   //�п���ʹ�ÿ��Ƶ���
			sendAllCanUsePlayer(dur_usecard);
			useCard=null;
			waitfor(dur_usecard);
			if(useCard!=null){
				CardLaunch();
				launchCardOrSkill();
				if(orgSendTarget!=sendTarget.getUid())break;
			}else{
				break;
			}
		}
		if(orgSendTarget==sendTarget.getUid()){
			goStep(StepCons.InfoReceive);
		}else{
			goStep(StepCons.InfoSend);
		}
	}

	public void InfoReceive(){   //�鱨���ս׶�
		if(exit)return;
		//		SmartFoxServer.log.info("�鱨����"+sendingcard.getSend());
		if(sendTarget.getIsDead()){
			if(sendTarget==nowPlayer){//�����鱨
				RecieveNowInfo();
			}else if(sendTarget.isTransfer || sendTarget.isCapture){//����ȥ
				sendTarget=captureTarget;
				captureTarget=null;
				for(Player p:roleSeq){       //�������������״̬
					p.isCapture=false;
				}
				goStep(StepCons.InfoSend);//�ص��鱨����
			}else{//����������һλ
				sResult.dispose();
				OnRecieveChoose(sResult);
			}
			return;
		}
		if(sendTarget.getIsLock() ||  sendTarget.isTransfer || sendTarget.getUid()==nowPlayer.getUid()){  //�������򴫻ر�����
			RecieveNowInfo();//�����鱨��Ϣ
		}else if(sendTarget.isCapture){   //����ǽػ�
			if(sendTarget.isSkip){
				sendTarget=captureTarget;
				captureTarget=null;
				for(Player p:roleSeq){       //�������������״̬
					p.isCapture=false;
				}
				goStep(StepCons.InfoSend);//�ص��鱨����
			}else{    //������
				RecieveNowInfo();//�����鱨��Ϣ
			}
		}else if(sendTarget.isSkip){ //����
			if(sendingcard.getSend()==1){
				sendTarget=nowPlayer;
			}else{
				sendTarget=getNextPlayer(sendTarget);
			}
			for(Player p:roleSeq){       //�������������״̬
				p.isCapture=false;
			}
			goStep(StepCons.InfoSend);//�ص��鱨����
		}else{
			sResult.dispose();
			if(sendTarget.trusttee){
				OnRecieveChoose(sResult);  //����û��Ϲ�ֱ��ѡ��
				return;
			}

			ActionscriptObject resp=new ActionscriptObject();   //Ҫ��Ҫ�����鱨��Ϣ 
			resp.putNumber("target",sendTarget.getUid());
			resp.putNumber("time",5000);
			resp.putNumber("oid",operId);
			resp.putNumber("h",2);
			resp.putNumber("f",17);
			SendToALL(resp);
			waitfor(5000);
			OnRecieveChoose(sResult);
		}

	}
	public void OnRecieveChoose(SelectVO svo){  //ѡ���Ƿ�����鱨����
		if(exit)return;
		//		SmartFoxServer.log.info("ѡ���Ƿ�����鱨����");
		if(svo.type==0){  //��Ҫ
			//			SmartFoxServer.log.info("������,�鱨��������:::::   " +sendingcard.getSend());
			if(sendingcard.getSend()==1){
				sendTarget=nowPlayer;
			}else{
				sendTarget=getNextPlayer(sendTarget);
			}
			for(Player p:roleSeq){       //�������������״̬
				p.isCapture=false;
			}
			goStep(StepCons.InfoSend);//�ص��鱨����
		}else{
			RecieveNowInfo();
		}
	}
	public void RecieveNowInfo(){ //���յ�ǰ�鱨
		if(exit)return;
		//		SmartFoxServer.log.info("���յ�ǰ�鱨"+sendingcard);
		thirdStep=StepCons.RecieveNowInfo;
		RedSkillsCheck();
		thirdStep=0;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject obj=new ActionscriptObject();
		sendingcard.setResponse(obj);
		resp.put("card", obj);
		resp.putNumber("target",sendTarget.getUid());
		resp.putNumber("h",2);
		resp.putNumber("f",15);
		SendToALL(resp);
		//		clearStatus();

		waitfor(1000);
		ArrayList<Card> temp=new ArrayList<Card>();
		temp.add(sendingcard);
		getCard(sendTarget, temp, 0);
		clearStatus();
		RecieveInfoEnd();
	}

	public void RecieveInfoEnd(){
		if(exit)return;
		//		SmartFoxServer.log.info("���յ�ǰ�鱨���");
		sendingcard=null;
		goStep(StepCons.CardUse2);
	}
	public void clearStatus(){
		for(Player p:roleSeq){       //�������������״̬
			p.setIsLock(p.isCapture=p.isSkip=p.isTransfer=false);
		}
	}
	/**�غϽ���**/
	public Player nextPlayer;
	public void StepEnd() {
		if(exit)return;
		clearAllStatus();
		clearStatus();
		//		SmartFoxServer.log.info("�غϽ���");
		RedSkillsCheck();
		if(nextPlayer==null)
			nowPlayer=getNextPlayer(nowPlayer);
		for(Player p:roleSeq){   					//�ظ�����ʹ�ÿ���
			if(!p.getIsDead() && !p.isLost){
				for(Skill s:p.skill){
					s.reset();
				}
				if(p.isPoison>0){
					p.isPoison--;
					setPoison(p.getUid(),p.isPoison);
				}
				p.nowTurnKillCount=0;
				p.isSkipDealing=false;
				p.lastUsedCard=null;
				p.jifengzhouyu.clear();
			}
		}
		nowGetCardPlayer=null;
		nowGetCards.clear();
		deadman=null;
		nextPlayer=null;
		initialSendTarget=null;
	}
	private void LoseSettlement(Player p) {
		p.isLost=true;
		p.excuteDeath();
		goStep(StepCons.StepEnd);
	}
	public void userTrusttee(int uid,Boolean boo,int type) {//�й�
		if(type==1)
			roleMap.get(uid).trusttee=boo;
		else
			roleMap.get(uid).isExit=boo;
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("type", type);
		resp.putNumber("uid", uid);
		resp.putBool("boo",boo);
		resp.putNumber("h",2);
		resp.putNumber("f",26);
		SendToALL(resp);
	}
	public void goStep(int stepIndex) {
		if(exit)return;
		//		SmartFoxServer.log.info("goStep() index= "+stepIndex);
		nowStep=stepIndex;
		subStep=0;
		sendToAllStepIndex(nowStep);
		switch (stepIndex) {
		case StepCons.DealingAll:     //ȫ�巢��
			DealingAll();
			break;
		case StepCons.DealingSingle:   //��������
			DealingSingle();
			break;
		case StepCons.StepBegin:   //�غϿ�ʼ
			sendDataToReconnectUsers();
			StepBegin();
			break;
		case StepCons.CardUse1:   //���Ʒ���1
			CardUse();
			break;
		case StepCons.CardUse2:   //���Ʒ���2
			CardUse();
			break;
		case StepCons.StepEnd:
			StepEnd();
			break;
		case StepCons.InfoSend:    //���鱨�׶�
			InfoSend();
			break;
		case StepCons.InfoArrive:   //�鱨����
			InfoArrive();
			break;
		case StepCons.InfoReceive:   //�鱨����
			InfoReceive();
			break;
		}
	}
	public void StepBegin() {		//�غϿ�ʼ
		if(exit)return;
		//		SmartFoxServer.log.info("�غϿ�ʼ");
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("uid", nowPlayer.getUid());
		resp.putNumber("h",2);
		resp.putNumber("f",22);//֪ͨ�ı���һغ�
		SendToALL(resp);
		RedSkillsCheck();
		goStep(StepCons.DealingSingle);
	}

	public void RedSkillsCheck(){
		if(exit)return;
		if(checkAllAction(2)){   //�п���ʹ�ú켼�ܵ���
			//			SmartFoxServer.log.info("�п���ʹ�õĺ켼��");
			LinkedList<Skill> tempcanuseSkill=checkRedSkill();
			if(tempcanuseSkill.size()>0){
				LinkedList<Skill> canuseSkill=new LinkedList<Skill>();
				for(Skill s:tempcanuseSkill){
					Skill skill=ObjUtil.getSkillClassByID(s.id);
					skill.copyBasicInfo(s);
					//					skill.color=s.color;
					//					skill.setOwner(s.getOwner());
					//					skill.id=s.id;
					if(nowGetCardPlayer!=null)skill.nowGetCardPlayerUid=nowGetCardPlayer.getUid();
					if(deadman!=null)skill.deadmanUid=deadman.getUid();
					if(infosToBeReceived!=null) skill.infosToBeReceived = infosToBeReceived;
					canuseSkill.add(skill);
				}
				RedSkillLaundch(canuseSkill);
			}
		}
	}
	public void DealingSingle() {		//���ƽ׶�
		if(exit)return;
		//		SmartFoxServer.log.info("���ƽ׶�");
		if(nowPlayer.skillhash.containsKey(56) && nowPlayer.isPoison==0){  //�о���
			nowPlayer.skillhash.get(56).play(null);
		}else if(nowPlayer.skillhash.containsKey(125) && nowPlayer.isPoison==0){//�а�Ȩ
			nowPlayer.skillhash.get(125).play(null);
		}else if(nowPlayer.skillhash.containsKey(136) && nowPlayer.isPoison==0){//����Ы����
			nowPlayer.skillhash.get(136).play(null);
		}else if(nowPlayer.skillhash.containsKey(166) && nowPlayer.isPoison==0){//���Ͽ����
			nowPlayer.skillhash.get(166).play(null);
		}else if((nowPlayer.skillhash.containsKey(146) || nowPlayer.skillhash.containsKey(152)) && nowPlayer.isPoison==0){//�г��ƽ׶η����ļ���
			RedSkillsCheck();
		}
		//		RedSkillsCheck();
		deal();
	}
	public void deal(){  //���Ʋ���
		if(exit)return;
		if(nowPlayer.isSkipDealing==false){
			nowPlayer.getCards.add(getCardFromCardPack());
			nowPlayer.getCards.add(getCardFromCardPack());
			ArrayList<Card> temp=new ArrayList<Card>();
			temp.addAll(nowPlayer.getCards);
			nowPlayer.getCards.clear();
			drawCard(nowPlayer,temp, 1, null);
			waitfor(2000);
		}
		goStep(StepCons.CardUse1);
	}
	public void OnChooseRecieve(SelectVO svo) {
		if(exit)return;
		//		SmartFoxServer.log.info("�û���������");
		sResult=svo;
		wakeup();
	}
	public void OnSkillLaunch(SkillVO svo) {  //���ܷ���
		if(exit)return;
		//		SmartFoxServer.log.info("���ܷ���,sid=:"+svo.sid);
		Player p=roleMap.get(svo.sponsor);
		Skill s=p.skillhash.get(svo.sid);
		if(s.color==0){    //��ɫ
			useCard=svo;
			wakeup();
		}else if(s.color==1){   //��ɫ
			useSkill=svo;
			wakeup();
		}
	}
	//	public LinkedList<SkillVO> redSkill=new LinkedList<SkillVO>();//�������㼼��
	//	/**
	//	 * ���ö������ʧЧ����
	//	 * @param card
	//	 * @param type 1��2��
	//	 */
	//	public void setDisabledTargetVO(int target, int type) {
	//		for(TargetVO tvo:usedCardStack){
	//			if(type==1){
	//				if(tvo.target==target)tvo.disabled=true;
	//			}else{
	//				if(tvo.card==target)tvo.disabled=true;
	//			}
	//		}
	//	}

	public void Burn(int target,ArrayList<Card> temp){
		burnTarget=target;
		thirdStep=StepCons.BeforeBurn;
		RedSkillsCheck();
		thirdStep=0;
		ActionscriptObject resp=new ActionscriptObject();
		ActionscriptObject arr=new ActionscriptObject();
		setCardsResp(arr, temp);
		resp.putNumber("from",target);
		if(burnTo>0)resp.putNumber("to",burnTo);
		resp.putNumber("type",burnTo==0?7:2);  //type 1�ֿ����ֿ� 2 �鱨���ֿ� 3�ֿ����鱨 4�鱨���鱨5�ֿ����ƿⶥ
		resp.put("cards",arr);
		resp.putNumber("h",2);
		resp.putNumber("f",27);
		SendToALL(resp);
		roleMap.get(target).removeCardFromInfo(temp,burnTo==0);
		if(burnTo>0)roleMap.get(burnTo).addToHand(temp);
		waitfor(2000);
		ArrayList<Player> winer=checkTask();
		if(winer.size()>0){
			victoryMan=winer.get(0);
			winners.addAll(winer);
			VictoryExcute(victoryMan);
			return;
		}
		thirdStep=StepCons.AfterBurn;
		RedSkillsCheck();
		thirdStep=0;
		burnTo=0;
		burnTarget=0;
	}
	public void setPoison(int p, int i) {
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("h",2);
		resp.putNumber("f",33);
		resp.putNumber("target",p);
		resp.putNumber("num",i);
		SendToALL(resp);
	}
}