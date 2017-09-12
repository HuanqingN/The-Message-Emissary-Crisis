package extension.vo;

import it.gotoandplay.smartfoxserver.lib.ActionscriptObject;

import java.util.ArrayList;
import java.util.Set;

public class SelectVO extends BaseVO {

	public int type;
	public ArrayList<Integer> targets;
	public ArrayList<Integer> cards;
	public int target;
	public int card;
	public void dispose(){
		type=0;
		target=0;
		card=0;
		if(targets!=null)
		targets.clear();
		if(cards!=null)
		cards.clear();
		targets=null;
		cards=null;
	}
	
	public void setData(ActionscriptObject as){
		Set<String> keys=as.keySet();
		if(keys.contains("type"))type=(int)as.getNumber("type");
		if(keys.contains("target"))target=(int)as.getNumber("target");
		if(keys.contains("card"))card=(int)as.getNumber("card");
		if(keys.contains("targets")){
			ActionscriptObject arr=as.getObj("targets");
			ArrayList<Integer> temp=new ArrayList<Integer>();
			for (int i = 0; i < arr.size(); i++) {
				temp.add((int)arr.getNumber(i));
			}
			targets=temp;
			if(temp.size()==0)temp=null;
		}
		if(keys.contains("cards")){
			ActionscriptObject arr=as.getObj("cards");
			ArrayList<Integer> temp=new ArrayList<Integer>();
			for (int i = 0; i < arr.size(); i++) {
				temp.add((int)arr.getNumber(i));
			}
			if(temp.size()==0)temp=null;
			cards=temp;
		}
	}
}
