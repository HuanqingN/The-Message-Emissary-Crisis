package views
{
	import flash.events.MouseEvent;
	
	import core.mng.Evt;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import events.WEvent;
	
	import game.ui.test.RoleInfoUI;
	
	import handlers.RoomHandler;
	
	import util.GUtil;
	
	import utils.effect.IMGManager;
	
	public class RoleInfo extends RoleInfoUI
	{
		public var uid:int=-1;
		public function RoleInfo()
		{
			super();
			head.bitmap.bitmapData=new Role13;
			Evt.add(RoomHandler.onGetUserInfo,onGetUserInfo);
			Evt.add(RoomHandler.onChangeFavor,onChangeFavor);
			closebtn.addEventListener(MouseEvent.CLICK,onclosebtnclick);
			f1.addEventListener(MouseEvent.CLICK,onclick);
			f2.addEventListener(MouseEvent.CLICK,onclick);
			f3.addEventListener(MouseEvent.CLICK,onclick);
		}
		
		private function onChangeFavor(evt:WEvent):void
		{
			var target:int=evt.param.target;
			switch(evt.param.type)
			{
				case 0:
					if(GL.favor && GL.favor.indexOf(target+",")>=0)GL.favor=GL.favor.replace(target+",","");
					if(GL.hate && GL.hate.indexOf(target+",")>=0)GL.hate=GL.hate.replace(target+",","");
					if(GL.favor=="")GL.favor=null;
					if(GL.hate=="")GL.hate=null;
					break;
				case 1:
					if(!GL.favor || GL.favor=="")GL.favor=(target+",");
					else if(GL.favor && GL.favor.indexOf(target+",")<0)GL.favor+=(target+",");
					if(GL.hate && GL.hate.indexOf(target+",")>=0)GL.hate=GL.hate.replace(target+",","");
					if(GL.hate=="")GL.hate=null;
					break;
				case 2:
					if(!GL.hate || GL.hate=="")GL.hate=(target+",");
					else if(GL.hate && GL.hate.indexOf(target+",")<0)GL.hate+=(target+",");
					if(GL.favor && GL.favor.indexOf(target+",")>=0)GL.favor=GL.favor.replace(target+",","");
					if(GL.favor=="")GL.favor=null;
					break;
			}
			if(target==uid){
				refreshFavor();	
			}
		}
		private var favorstate:int=0;
		protected function onclick(event:MouseEvent):void
		{
			switch(event.currentTarget.name)
			{
				case "f1":
					if(favorstate==0)return;
					SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.ChangeFavor,{state:0,self:GL.id,target:uid});
					break;
				case "f2":
					if(favorstate==1)return;
					SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.ChangeFavor,{state:1,self:GL.id,target:uid});
					break;
				case "f3":
					if(favorstate==3)return;
					SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.ChangeFavor,{state:2,self:GL.id,target:uid});
					break;
			}			
		}
		
		private function onGetUserInfo(evt:WEvent):void
		{
			var result:Object=evt.param;
			txt1.text=result.name;
			txt2.text=GUtil.getLevelByExp(result.exp);
			if(int(txt2.text)==100){
				txt2.toolTip="等级上限";
			}else{
				txt2.toolTip= (int(result.exp)-int(GUtil.getLevelExp(int(txt2.text))))+"/"+GUtil.getLevelExp(int(txt2.text)+1);
			}
			txt3.text="无";
			txt4.text=getRate(result.duleCount,result.winCount);
			txt5.text=result.coin;
			txt6.text=result.duleCount;
			txt7.text=result.streak;
			txt8.text=result.winCount[0];
			txt9.text=result.winCount[1];
			txt10.text=result.winCount[2];
			txt11.text=result.deathCount;
			txt12.text=result.killCount;
			
			var temp:Array=[];
			for(var i:int =0;i<result.useRole.length;i++){
				temp.push({index:i,count:result.useRole[i]});
			}
			temp.sortOn("count",Array.NUMERIC|Array.DESCENDING);
			txt13.text=GL.roleData.get(temp[0].index+1).n;
			refreshFavor();
		}
		
		private function refreshFavor():void
		{
			f1.visible=f2.visible=f3.visible=uid!=GL.id;
			if(uid!=GL.id){
				if(GL.favor==null && GL.hate==null){
					f1.filters=[];
					IMGManager.setSaturation(f2,-100);
					IMGManager.setSaturation(f3,-100);
					favorstate=0;
				}else{
					if(GL.favor!=null){
						if(GL.favor.indexOf(uid+",")>=0){
							f2.filters=[];
							IMGManager.setSaturation(f1,-100);
							IMGManager.setSaturation(f3,-100);
							favorstate=1;
							return;
						}
					}
					if(GL.hate!=null){
						if(GL.hate.indexOf(uid+",")>=0){
							f3.filters=[];
							IMGManager.setSaturation(f1,-100);
							IMGManager.setSaturation(f2,-100);
							favorstate=2;
						}
					}
				}
			}
		}
		public function getRate(total:int,wc:Array):String{
			var win:int=0;
			for(var i in wc){
				win+=int(wc[i]);
			}
			return Number(int(win/total*10000)/100)+"%";
		}
		protected function onclosebtnclick(event:MouseEvent):void
		{
			this.close();
		}
		
		public function getRoleInfo(userId:int):void{
			if(uid==userId)return;
			uid=userId;
			SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.GetRoleInfo,{uid:uid});
		}
	}
}