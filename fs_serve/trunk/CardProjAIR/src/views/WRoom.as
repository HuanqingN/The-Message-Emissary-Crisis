package views
{
	import flash.events.MouseEvent;
	
	import core.mng.Evt;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import events.WEvent;
	
	import game.ui.test.RoomUI;
	
	import handlers.RoomHandler;
	
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	
	public class WRoom extends RoomUI
	{
		private var rview:RoomView;
		public static var tableOwner:int=0;
		private var roomitems:Array=[];
		public function WRoom(v:RoomView)
		{
			this.rview=v;
			var cx:int=100,cy:int=91,hgap:int=3,ygap:int=1;
			for (var i:int = 0,j:int=0; i < 8; i++,j++) 
			{
				if(i==4){
					j=0;
					cy=cy+211+ygap;
					cx=100;
				}
				var ri:RoleItem=new RoleItem();
				ri.index=i;
				ri.x=cx+j*(150+hgap);ri.y=cy;
				ri.check.addEventListener(MouseEvent.CLICK,onCheck);
				ri.kickbtn.addEventListener(MouseEvent.CLICK,onkick);
				addChild(ri);
				roomitems.push(ri);
			}
			exitbtn.addEventListener(MouseEvent.CLICK,onclick);
//			kickbtn.addEventListener(MouseEvent.CLICK,onclick);
			readybtn.addEventListener(MouseEvent.CLICK,onclick);
			chooseRoleBtn.addEventListener(MouseEvent.CLICK,onclick);
			Evt.add(RoomHandler.onRoomUpdate,onRoomUpdate);
			Evt.add(RoomHandler.onChangeBan,onChangeBan);
		}
		
		protected function onkick(event:MouseEvent):void
		{
			if(event.currentTarget.parent.data){
				var obj:Object=event.currentTarget.parent.data;
				SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.LeaveRoom,{id:GL.tableId,iskick:true,uid:obj.id,ctype:0},SmartFoxClient.XTMSG_TYPE_XML);
			}
		}
		private var roleInfo:RoleInfo;
		protected function onCheck(event:MouseEvent):void
		{
			if(event.currentTarget.parent.data){
				if(!roleInfo){
					roleInfo=new RoleInfo();
					roleInfo.popupCenter=true;
				}
				var obj:Object=event.currentTarget.parent.data;
				if(roleInfo.isPopup){
					if(roleInfo.uid==obj.id){
						roleInfo.close();
					}else{
						roleInfo.getRoleInfo(obj.id);						
					}
				}else{
					roleInfo.getRoleInfo(obj.id);						
					App.dialog.show(roleInfo,true);
				}
			}
		}
		
		override public function dispose():void
		{
			rview=null;
			roomitems=null;
			exitbtn.removeEventListener(MouseEvent.CLICK,onclick);
//			kickbtn.removeEventListener(MouseEvent.CLICK,onclick);
			readybtn.removeEventListener(MouseEvent.CLICK,onclick);
			Evt.remove(RoomHandler.onRoomUpdate,onRoomUpdate);
			Evt.remove(RoomHandler.onChangeBan,onChangeBan);
		}
		
		
		private function onChangeBan(evt:WEvent):void
		{
			canban=true;
			setBanstate(evt.param.ban);			
		}
		private function setBanstate(arr:Array):void{
			var count:int=0;
			for(var i:int in arr){
				roomitems[i].isban=arr[i];
				if(arr[i])count++;
			}
			setIdenBtns(8-count);
		}
		
		private function setIdenBtns(count:int):void
		{
			switch(count)
			{
				case 3:
					b1.label="潜";
					b1.skin="jpg.custom.btn_red";
					b2.label="酱";
					b2.skin="jpg.custom.btn_black";
					b3.visible=b4.visible=b5.visible=b6.visible=b7.visible=false;
					break;
				case 4:
					b1.label="军";
					b1.skin="jpg.custom.btn_blue";
					b2.label="潜";
					b2.skin="jpg.custom.btn_red";
					b3.label="潜";
					b3.skin="jpg.custom.btn_red";
					b3.visible=true;
					b4.visible=b5.visible=b6.visible=b7.visible=false;
					break;
				case 5:
					b1.label="军";
					b1.skin="jpg.custom.btn_blue";
					b2.label="潜";
					b2.skin="jpg.custom.btn_red";
					b3.label="潜";
					b3.skin="jpg.custom.btn_red";
					b4.label="酱";
					b4.skin="jpg.custom.btn_black";
					b4.visible=true;
					b5.visible=b6.visible=b7.visible=false;
					break;
				case 6:
					b1.label="军";
					b1.skin="jpg.custom.btn_blue";
					b2.label="潜";
					b2.skin="jpg.custom.btn_red";
					b3.label="潜";
					b3.skin="jpg.custom.btn_red";
					b4.label="酱";
					b4.skin="jpg.custom.btn_black";
					b5.label="酱";
					b5.skin="jpg.custom.btn_black";
					b5.visible=true;
					b6.visible=b7.visible=false;
					break;
				case 7:
					b1.label="军";
					b1.skin="jpg.custom.btn_blue";
					b2.label="军";
					b2.skin="jpg.custom.btn_blue";
					b3.label="潜";
					b3.skin="jpg.custom.btn_red";
					b4.label="潜";
					b4.skin="jpg.custom.btn_red";
					b5.label="潜";
					b5.skin="jpg.custom.btn_red";
					b6.label="酱";
					b6.skin="jpg.custom.btn_black";
					b4.visible=b5.visible=b6.visible=true;
					b7.visible=false;
					break;
				case 8:
					b1.label="军";
					b1.skin="jpg.custom.btn_blue";
					b2.label="军";
					b2.skin="jpg.custom.btn_blue";
					b3.label="潜";
					b3.skin="jpg.custom.btn_red";
					b4.label="潜";
					b4.skin="jpg.custom.btn_red";
					b5.label="潜";
					b5.skin="jpg.custom.btn_red";
					b6.label="酱";
					b6.skin="jpg.custom.btn_black";
					b6.visible=b7.visible=true;
					break;
			}
		}
		protected function onclick(event:MouseEvent):void
		{
			switch(event.currentTarget.name)
			{
				case "exitbtn":
					SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.LeaveRoom,{id:GL.tableId,iskick:false,uid:GL.id,ctype:0},SmartFoxClient.XTMSG_TYPE_XML);
					App.audio.play(Cons.audio.Return);
					break;
				case "kickbtn":
					break;
				case "chooseRoleBtn":
					Evt.dipatch(Evt.onCollectionViewShow,null);
					break;
				case "readybtn":
					if(readybtn.label=="开始对战"){
						readybtn.disabled=true;
						SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.StartBattle,{id:GL.tableId,ctype:0},SmartFoxClient.XTMSG_TYPE_XML);
					}else{
						SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.DoReady,{id:GL.tableId,ctype:0},SmartFoxClient.XTMSG_TYPE_XML);
					}
					break;
			}			
		}
		private function onRoomUpdate(evt:WEvent):void
		{
			var type:int=evt.param.type;
			switch(type)
			{
				case 1: //加
					var arr:Array=evt.param.roles;
					setOwner(evt.param.uid);
					GL.tableId=evt.param.tid;
					ante.text=evt.param.ante;
					for(var i:int in arr){
						roomitems[i].setData(arr[i]);
					}
					if(!rview.contains(this)){
						this.x=70;this.y=50;
						rview.addChild(this);
						rview.box1.visible=false;
						rview.title1.visible=false;
					}
					if(evt.param.hasOwnProperty("bans")){
						var bans:Array=evt.param.bans.split(',');
						var count:int=0;
						for(var i:int in roomitems){
							if(bans[i]!=0)count++;
							if(roomitems[i].data){
								roomitems[i].data.isban=bans[i]!=0;
								roomitems[i].setData(roomitems[i].data);
							}else{
//								roomitems[i].setData({isban:bans[i]!=0});
								roomitems[i].isban=bans[i]!=0;
							}
						}
						setIdenBtns(8-count);
					}
					break;
				case 2:  //减
					roomitems[evt.param.seat].setData(null);
					if(evt.param.hasOwnProperty("uid")){
						if(evt.param.uid==GL.id){
							rview.removeChild(this);
							rview.box1.visible=true;
							rview.title1.visible=true;
							cleardatas();
							if(evt.param.hasOwnProperty("iskick") && evt.param.iskick==true){
								App.info.show("你被房主踢出房间");
							}
						}
					}
					break;
				case 3:  //更新
					var d:Object=roomitems[evt.param.seat].data;
					if(evt.param.datas.hasOwnProperty("isOwner"))
					setOwner(evt.param.datas.isOwner);
					if(evt.param.datas.hasOwnProperty("begin"))
					setBegin(evt.param.datas.begin);
					updateOneProp("name",evt.param.datas,d);
					updateOneProp("id",evt.param.datas,d);
					updateOneProp("isReady",evt.param.datas,d);
					updateOneProp("isOwner",evt.param.datas,d);
					updateOneProp("isban",evt.param.datas,d);
					roomitems[evt.param.seat].setData(d);
					break;
			}
		}
		
		private function cleardatas():void
		{
			for(var i:int in roomitems){
				if(roomitems[i].data){
					roomitems[i].setData(null);
				}else{
					roomitems[i].isban=false;
				}
			}
			setOwner(-1);
		}
		public function setBegin(boo:Boolean):void{
			if(boo){
			readybtn.disabled=false;
			App.audio.play(Cons.audio.Start);
			}else{
				readybtn.disabled=true;
			}
		}
		public function setOwner(oid:int):void{
			tableOwner=oid;
			if(oid==GL.id){
				readybtn.label="开始对战";
				readybtn.disabled=true;
				addItemClick(true);
			}else{
				readybtn.label="准备";
				readybtn.disabled=false;
				addItemClick(false);
			}
		}
		private var canban:Boolean=true;
		private function onitemclick(evt:MouseEvent):void{
			if(evt.currentTarget.isban){
				if(!canban)return;
				canban=false;
				SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.ChangeBan,{id:GL.tableId,index:evt.currentTarget.index,ban:0,ctype:0},SmartFoxClient.XTMSG_TYPE_XML);
			}else if(!evt.currentTarget.data){
				var count:int=0;
				for(var i:int in roomitems){
					if(!roomitems[i].isban)count++;
				}
				if(count<=3)return;
				if(!canban)return;
				canban=false;
				SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.ChangeBan,{id:GL.tableId,index:evt.currentTarget.index,ban:1,ctype:0},SmartFoxClient.XTMSG_TYPE_XML);
			}
		}
		private function addItemClick(boo:Boolean):void{
			for(var i:int in  roomitems){
				if(boo)
				roomitems[i].addEventListener(MouseEvent.CLICK,onitemclick);
				else
				roomitems[i].removeEventListener(MouseEvent.CLICK,onitemclick);
			}
		}
		private function updateOneProp(str:String,from:Object,to:Object):void{
			if(from.hasOwnProperty(str))to[str]=from[str];
		}
		
		public function clearAllReady():void
		{
			for(var i:int in roomitems){
				if(roomitems[i].data && roomitems[i].data.isOwner<0){
					roomitems[i].data.isReady=false;
					roomitems[i].setData(roomitems[i].data);
				}
			}
		}
	}
}