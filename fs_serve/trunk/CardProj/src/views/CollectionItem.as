package views
{
	import flash.utils.getDefinitionByName;
	
	import datas.GL;
	import datas.Trans;
	
	import game.ui.test.CollectionItemUI;
	
	import utils.StringUtils;
	
	public class CollectionItem extends CollectionItemUI
	{
		public function CollectionItem()
		{
			super();
			kuang.toolTip=getRoleTip;
		}
		
		public function setData(obj:Object):void{
			this.data=obj;
			if(obj){
				visible=true;
				var cls:Class=getDefinitionByName("Role"+obj.id) as Class;
				img.bitmapData=new cls();
				ntxt.text=obj.n;
				hidetxt.text=obj.h==1?"隐藏":"公开";
				skills=[];
				var role:Object=GL.roleData.get(obj.id);
				if(role.s1>0)skills.push(GL.skillData.get(role.s1));
				if(role.s2>0)skills.push(GL.skillData.get(role.s2));
				if(role.s3>0)skills.push(GL.skillData.get(role.s3));
				if(role.s4>0)skills.push(GL.skillData.get(role.s4));
				roletiptxt="";
			}else{
				skills=null;
				visible=false;
			}
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
					roletiptxt+=GL.taskData.get(GL.roleData.get(data.id).st).n;
				}
			}
			App.tipview.setText(roletiptxt);
			App.tip.addChild(App.tipview);
		}
	}
}