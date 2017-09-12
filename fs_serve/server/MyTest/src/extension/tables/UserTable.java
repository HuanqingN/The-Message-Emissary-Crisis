package extension.tables;

import it.gotoandplay.smartfoxserver.db.DataRow;
import it.gotoandplay.smartfoxserver.db.DbManager;

import java.util.ArrayList;
import java.util.HashMap;

import extension.WUser;

public class UserTable {
	public static UserTable ut=new UserTable();
	public HashMap<String, HashMap<String, Object>> datahash=new HashMap<String, HashMap<String,Object>>();
	private ArrayList<DataRow> datas;
	public static UserTable inst(){
		return ut;
	}
	
	public int size(){
		return datahash.size();
	}
	public ArrayList<DataRow> getDatas() {
		return datas;
	}

	public void setDatas(ArrayList<DataRow> datas) {
		this.datas = datas;
		if(datas!=null)
		initData(datas);
	}

	private void initData(ArrayList<DataRow> datas2) {
		for(DataRow dr:datas2){
			dr.getItem("name");
			datahash.put(dr.getItem("name"),(HashMap<String, Object>)dr.getData());
		}
	}
	public HashMap<String, Object> getUser(String key){
		return datahash.get(key);
	}
	
	public Boolean addUser(String n,String nn,String p,DbManager db){
		String sql="INSERT INTO player VALUES (0,'"+n+"', '0', '0', '"+nn+"', '0', '"+p+"','null',0,0,0,0,0,'null',10000,'null','null','null')";
		if(db.executeCommand(sql)){
			sql="SELECT * FROM player WHERE name='"+n+"'";
			ArrayList<DataRow> temp=db.executeQuery(sql);
			if(temp.size()>0){
				datas.add(temp.get(0));
				datahash.put(temp.get(0).getItem("name"), (HashMap<String, Object>)temp.get(0).getData());
			}
			return true;
		}else{
			return false;
		}
	}
	public Boolean contain(String n){
		return datahash.containsKey(n);
	}
}
