package extension.serv;

import java.io.IOException;
import java.nio.channels.SocketChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Set;

import extension.manage.BattleCtrl;
import extension.vo.SelectVO;
import extension.vo.SkillVO;
import extension.vo.TargetVO;
import it.gotoandplay.smartfoxserver.SmartFoxServer;
import it.gotoandplay.smartfoxserver.data.User;
import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

public class ServBattle extends ServBase {
	public void ChooseRole(ActionscriptObject ao,User u) throws IOException{
		int tid=(int)ao.getNumber("tid");
		int cid=(int)ao.getNumber("cid");
		int oid=(int)ao.getNumber("oid");
		HashMap<Integer, BattleCtrl> hash=getBlist();
		BattleCtrl bf=hash.get(tid);
		if(bf.operId!=oid)return;
		bf.chooseCard(u.getVariable("id").getIntValue(), cid);
	}
	
	public void GetFoldCards(ActionscriptObject ao,User u){
		int tid=(int)ao.getNumber("tid");
		int uid=(int)ao.getNumber("uid");
		HashMap<Integer, BattleCtrl> hash=getBlist();
		BattleCtrl bf=hash.get(tid);
		bf.getFoldCards(uid);
	}
	public void CheckNetState(ActionscriptObject ao,User u){
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("h",2);
		resp.putNumber("f",28);
		LinkedList<SocketChannel> s=new LinkedList<SocketChannel>();
		s.add(u.getChannel());
		getExt().sendResponse(resp, -1, null, s);
	}
	
	public void UseCard(ActionscriptObject ao,User u) throws IOException{
		int tid=(int)ao.getNumber("tid");
		HashMap<Integer, BattleCtrl> hash=getBlist();
		BattleCtrl bf=hash.get(tid);
		TargetVO t=new TargetVO();
		t.setData(ao);
		bf.UseCard(t);
	}
	public void OnPass(ActionscriptObject ao,User u){   //弃卡返回
		int tid=(int)ao.getNumber("tid");
		int uid=(int)ao.getNumber("uid");
		BattleCtrl bf=getBlist().get(tid);
		if(bf.roleMap.get(uid).isPass())return;
		bf.watingforOperationResult(uid);   //bug
	}
	public void OnChooseRecieve(ActionscriptObject ao,User u){   //选择等待返回
		int tid=(int)ao.getNumber("tid");
		int oid=(int)ao.getNumber("oid");
		BattleCtrl bf=getBlist().get(tid);
		if(bf.operId!=oid)return;
		SelectVO svo=new SelectVO();
		svo.setData(ao);
		bf.OnChooseRecieve(svo);
	}
	public void OnQuickChat(ActionscriptObject ao,User u){   //选择等待返回
		int value=(int)ao.getNumber("value");
		int tid=(int)ao.getNumber("tid");
		BattleCtrl bf=getBlist().get(tid);
		ActionscriptObject resp=new ActionscriptObject();
		resp.putNumber("value", value);
		resp.putNumber("h",2);
		resp.putNumber("f",20);
		bf.SendToALL(resp);
	}
	public void onTrusttee(ActionscriptObject ao,User u){   //选择等待返回
//		SmartFoxServer.log.info("托管 用户名："+u.getName()+"  uid= " +u.getVariable("id"));
		int tid=(int)ao.getNumber("tid");
		Boolean boo=(Boolean)ao.getBool("boo");
		BattleCtrl bf=getBlist().get(tid);
		bf.userTrusttee(u.getVariable("id").getIntValue(),boo,1);
	}
	public void ChatMsg(ActionscriptObject ao,User u){   //聊天
		int tid=(int)ao.getNumber("tid");
		BattleCtrl bf=getBlist().get(tid);
		ao.putNumber("h",2);
		ao.putNumber("f",31);
		bf.SendToALL(ao);    //bug
	}
	public void OnSkillLaunch(ActionscriptObject ao,User u){   //选择等待返回
		int tid=(int)ao.getNumber("tid");
		int oid=(int)ao.getNumber("oid");
		BattleCtrl bf=getBlist().get(tid);
		if(bf.operId!=oid)return;
		SkillVO tvo =new SkillVO();
		tvo.setData(ao);
		bf.OnSkillLaunch(tvo);  //bug
	}
}
