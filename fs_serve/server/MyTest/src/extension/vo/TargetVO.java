package extension.vo;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

public class TargetVO extends BaseVO{
	/**目标人*/
	public int target;
	/**目标牌*/
	public int card;
	/**发动的人*/
	public int sponsor;
	/**发动的牌VID*/
	public int cvid;  		
	/**发动的牌ID*/
	public int cid;  		
	public List<Integer> targets;//目标数组
	public List<Integer> cards;   //目标牌数组
	public int color=-1;
	public int dur;
	public Boolean disabled=false;  //是否失效，失效为true
	public List<Integer> discards;  //失效的多个目标
	public int sid;  //技能ID
	public Boolean useBySkill=false; //是不是通过技能发动
	public int moveto;   //发动的卡的去向 -1传递中的情报0墓地>0手牌
	
	public boolean canDiscover=true;  //能否被识破
	public int skillType = 0;//此参数在BattleCtrl的drawCard方法中有使用，可用于定义不同时机具有不同效果的技能的此时时机的效果类型。0为默认类型
	public void dispose(){
		if(targets!=null)targets.clear();
		targets=null;
		if(discards!=null)discards.clear();
		discards=null;
		if(cards!=null)cards.clear();
		cards=null;
	}
	
	@SuppressWarnings("unchecked")
	public void setData(ActionscriptObject as){
		Set<String> keys=as.keySet();
		if(keys.contains("cvid"))cvid=(int)as.getNumber("cvid");
		if(keys.contains("cid"))cid=(int)as.getNumber("cid");
		if(keys.contains("target"))target=(int)as.getNumber("target");
		if(keys.contains("card"))card=(int)as.getNumber("card");
		if(keys.contains("sponsor"))sponsor=(int)as.getNumber("sponsor");
		if(keys.contains("sid"))sid=(int)as.getNumber("sid");
		if(keys.contains("moveto"))moveto=(int)as.getNumber("moveto");
		if(keys.contains("skillType"))skillType=(int)as.getNumber("skillType");
		if(keys.contains("targets")){
			ActionscriptObject arr=as.getObj("targets");
			ArrayList<Integer> temp=null;
			temp=new ArrayList<Integer>();
			for (int i = 0; i < arr.size(); i++) {
				temp.add((int)arr.getNumber(i));
			}
			targets=temp;
		}
		if(keys.contains("cards")){
			ActionscriptObject arr=as.getObj("cards");
			ArrayList<Integer> temp=null;
			temp=new ArrayList<Integer>();
			for (int i = 0; i < arr.size(); i++) {
				temp.add((int)arr.getNumber(i));
			}
			cards=temp;
		}
	}
	
	@Override
	public void setResponse(ActionscriptObject as){
		if(target>0)as.putNumber("target",target);
		if(sponsor>0)as.putNumber("sponsor",sponsor);
		if(cvid>0)as.putNumber("cvid",cvid);
		if(cid>0)as.putNumber("cid",cid);
		if(card>0)as.putNumber("card",card);
		if(dur>0)as.putNumber("dur",dur);
		if(sid>0)as.putNumber("sid",sid);
		if(color>-1)as.putNumber("color",color);
		as.putNumber("moveto",moveto);
		as.putBool("ubs",useBySkill);
		as.putBool("disabled", disabled);
		as.putBool("canDiscover", canDiscover);
		if(targets!=null && targets.size()>0){
			int index=0;
			ActionscriptObject obj=new ActionscriptObject();
			for(int i:targets){
				obj.putNumber(index++,i);
			}
			as.put("targets", obj);
		}
		if(cards!=null && cards.size()>0){
			int index=0;
			ActionscriptObject obj=new ActionscriptObject();
			for(int i:cards){
				obj.putNumber(index++,i);
			}
			as.put("cards", obj);
		}
		if(discards!=null && discards.size()>0){
			int index=0;
			ActionscriptObject obj=new ActionscriptObject();
			for(int i:discards){
				obj.putNumber(index++,i);
			}
			as.put("discards", obj);
		}
	}
	
	
}
