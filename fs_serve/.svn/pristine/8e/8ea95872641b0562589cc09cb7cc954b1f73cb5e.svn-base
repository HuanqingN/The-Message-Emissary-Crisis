package views
{
	import flash.display.BitmapData;
	
	import datas.GL;
	import datas.Trans;
	
	import game.ui.test.RoleChooseItemUI;
	
	import utils.OBJUtil;
	import utils.StringUtils;
	
	public class RoleChooseItem extends RoleChooseItemUI
	{
		public function RoleChooseItem()
		{
			super();
			card1.toolTip=getRoleTip;
		}
		
		public function setData(rid:int):void{
			data=rid;
			card1.bitmapData=OBJUtil.getInstanceByClassName("Role" +rid) as BitmapData;
			pname1.text=GL.roleData.get(rid).n;
			skills=[];
			var role:Object=GL.roleData.get(rid);
			if(role.s1>0)skills.push(GL.skillData.get(role.s1));
			if(role.s2>0)skills.push(GL.skillData.get(role.s2));
			if(role.s3>0)skills.push(GL.skillData.get(role.s3));
			if(role.s4>0)skills.push(GL.skillData.get(role.s4));
			roletiptxt="";
		}
		
		private var roletiptxt:String="";
		private var skills:Array;
		private function getRoleTip():void
		{
			if(!data)return;
			if(roletiptxt==""){
				if(skills){
					for(var i:int in skills){
						roletiptxt+=StringUtils.getColorString(skills[i].n,Trans.getSkillColor(skills[i].co))+"\n";
						roletiptxt+=skills[i].desc+"\n";
					}
					roletiptxt+="────────────────";
					roletiptxt+=StringUtils.getColorString("酱油任务",0x00ff00)+"\n";
					roletiptxt+=GL.taskData.get(GL.roleData.get(data).st).n;
				}
			}
			App.tipview.setText(roletiptxt);
			App.tip.addChild(App.tipview);
		}
	}
}