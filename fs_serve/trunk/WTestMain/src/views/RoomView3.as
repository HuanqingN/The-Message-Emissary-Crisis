package views
{
	import flash.events.MouseEvent;
	import core.mng.Assign;
	import core.mng.Evt;
	import core.mng.MMNG;
	import core.mng.SFS;
	import datas.Cons;
	import datas.GL;
	import events.WEvent;
	import filter.ImageFilter;
	import game.ui.test.RoleItemUI;
	import game.ui.test.RoomViewUI;
	import handlers.RoomHandler;
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	import morn.core.components.Box;
	import morn.core.handlers.Handler;
	import utils.ArrayUtil;
	import utils.HashMap;
	import utils.effect.IMGManager;
	
	public class RoomView3 extends RoomViewUI
	{
		private	var btns:Array=["bt1","bt2","bt3","bt4","op6","kickbtn","readybtn","exitbtn"];
		private var roomlist:HashMap=new HashMap();
		private var rldata:Array=[];  //房间列表数据源
		private var roomItems:Array=[];
		public function RoomView3()
		{
			for each (var i:String in btns) 
			{
				this[i].addEventListener(MouseEvent.CLICK,onBtnClick);
			}
			for (var j:int = 1; j <=8; j++) 
			{
				roomItems[j]=this["r"+j];
			}
			u1.text=GL.nick;
			setCurrentCell(null);
			rlist.array=null;
			rlist.mouseHandler = new Handler(onCheckListMouse);
			Assign.inst.register(Cons.handler.RoomHandler,new RoomHandler);
			Evt.add(RoomHandler.onRoomCreatedRetrive,onRoomCreatedRetrive);
			Evt.add(RoomHandler.onJoinRoomRetrive,onJoinRoomRetrive);
			Evt.add(RoomHandler.onDoReadyRetrive,onDoReadyRetrive);
			Evt.add(RoomHandler.onChangeStartState,onChangeStartState);
			Evt.add(RoomHandler.onStartGame,onStartGame);
			Evt.add(RoomHandler.onGetRoomList,onGetRoomList);
			Evt.add(RoomHandler.onLeave,onLeave);
			SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.GetTableList,{ctype:0});
		}
		
		private function onStartGame(evt:WEvent):void
		{
			GL.battleInfo=roomlist.get(currentRoomId);
			GL.tableId=currentRoomId;
			MMNG.inst.removeCurrentModule();
			MMNG.inst.loadModule(new BattleView);
		}
		
		private function onChangeStartState(evt:WEvent):void
		{
			readybtn.disabled=!evt.param.begin;
			if(evt.param.begin)App.audio.play(Cons.audio.Start);
		}
		
		private function onDoReadyRetrive(evt:WEvent):void
		{
			this["r"+(evt.param.position+1)].ready.visible=evt.param.isReady;
			if(evt.param.id==GL.id)
				readybtn.label=evt.param.isReady?"取消":"准备";
			
			if(evt.param.isReady)App.audio.play(Cons.audio.Ready);
		}
		
		private function onJoinRoomRetrive(evt:WEvent):void
		{
			var obj:Object
			if(evt.param.type==1){   //自己
				obj=roomlist.get(evt.param.id);		
				obj.ulist=evt.param.ulist;
				setBoxVisible(true,obj);
				box1.visible=false;
			}else if(evt.param.type==2){   //别人
				obj=roomlist.get(currentRoomId);
				obj.ulist.push(evt.param.user);
				setRoleItemData(this["r"+(evt.param.user.position+1)],evt.param.user);
			}else{
				obj=roomlist.get(evt.param.id);		
				getDataByID(evt.param.id).rcount=evt.param.min+"/"+obj.max;
				rlist.refresh();
			}
			bt3.disabled=bt4.disabled=false;
		}
		
		private function onCheckListMouse(e:MouseEvent, index:int):void
		{
			if (e.type == MouseEvent.CLICK) {
				var cell:Box = rlist.getCell(index);
				IMGManager.setBrightness(cell,50);
				setCurrentCell(cell);
//				var checkBox:CheckBox = cell.getChildByName("check") as CheckBox;
//				cell.dataSource["check"] = checkBox.selected;
			}			
		}
		
		private function setCurrentCell(cell:Box):void
		{
			currentCell=cell;
			bt3.disabled=currentCell==null;
		}
		
//		private function onGetSelfInfo(evt:WEvent):void
//		{
//			GL.name=evt.param.name;				
//			GL.nick=evt.param.nick;				
//			GL.id=evt.param.id;		
//			u1.text=GL.nick;
//		}
		override public function dispose():void
		{
			for each (var i:String in btns) 
			{
				this[i].removeEventListener(MouseEvent.CLICK,onBtnClick);
			}
			Assign.inst.remove(Cons.handler.RoomHandler);
			Evt.remove(RoomHandler.onRoomCreatedRetrive,onRoomCreatedRetrive);
//			Evt.remove(RoomHandler.onGetSelfInfo,onGetSelfInfo);
			Evt.remove(RoomHandler.onJoinRoomRetrive,onJoinRoomRetrive);
			Evt.remove(RoomHandler.onDoReadyRetrive,onDoReadyRetrive);
			Evt.remove(RoomHandler.onChangeStartState,onChangeStartState);
			Evt.remove(RoomHandler.onStartGame,onStartGame);
			Evt.remove(RoomHandler.onGetRoomList,onGetRoomList);
			Evt.remove(RoomHandler.onLeave,onLeave);
			rlist.mouseHandler=null;
		}
		
		private function onLeave(evt:WEvent):void
		{
			if(evt.param.allLeave){
				removeDataByID(evt.param.id);					
				rlist.refresh();
//				setBoxVisible(false);
//				box1.visible=true;
			}else{
				var obj:Object=roomlist.get(evt.param.id);
				if(evt.param.uid==GL.id){
					setBoxVisible(false);
					box1.visible=true;
				}else 	if(currentRoomId==evt.param.id){  //正在此桌的人
					utils.ArrayUtil.removeItemByParm(obj.ulist,"id",evt.param.uid);
					setRoleItemData(roomItems[evt.param.pos+1],null);
					if(evt.param.owner>0){
						var o:Object=utils.ArrayUtil.getItemByParm(obj.ulist,"id",evt.param.owner);
						o.isOwner=true;
						setRoleItemData(roomItems[evt.param.ownerpos+1],o);
						readybtn.label= evt.param.owner==GL.id?"开始":"准备";
						kickbtn.visible= evt.param.owner==GL.id;
						readybtn.disabled=evt.param.owner==GL.id;
					}
				}
				getDataByID(evt.param.id).rcount=evt.param.min+"/"+obj.max;
				rlist.refresh();			
			}
		}
		
		private function onGetRoomList(evt:WEvent):void
		{
			var arr:Array=evt.param.rlist as Array;
			for each(var obj:Object in arr){
				roomlist.put(obj.id,obj);
				rldata.push({count:obj.id,rcount:obj.min+"/"+obj.max,status:obj.isBattle?"游戏中":"准备中",rname:obj.ownername+"的房间"});
			}
			rlist.array=rldata;
		}
		protected function onBtnClick(event:MouseEvent):void
		{
			switch(event.currentTarget.name){
				case "t2":
					break;
				case "t3":
					break;
				case "t4":
					break;
				case "t5":
					break;
				case "t6":
					break;
				case "bt1":
					SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.CreateRoom,getParamsOfCreateRoom(),SmartFoxClient.XTMSG_TYPE_XML);
					break;
				case "bt2":
					break;
				case "bt3"://加入房间
					bt3.disabled=true;
					SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.JoinRoom,{id:currentCell.dataSource.count,ctype:0},SmartFoxClient.XTMSG_TYPE_XML);
					break;
				case "bt4":  //快速加入
					bt4.disabled=true;
					SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.QuickJoin,{ctype:0},SmartFoxClient.XTMSG_TYPE_XML);
					break;
				case "op6":
					SFS.inst.joinRoom(Cons.room.Hall,joinRoomSuccess);
					break;
				case "kickbtn":
					break;
				case "readybtn":
					if(readybtn.label=="开始"){
						readybtn.mouseEnabled=false;
						SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.StartBattle,{id:currentRoomId,ctype:0},SmartFoxClient.XTMSG_TYPE_XML);
					}else{
						SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.DoReady,{id:currentRoomId,ctype:0},SmartFoxClient.XTMSG_TYPE_XML);
					}
					break;
				case "exitbtn":
					SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.LeaveRoom,{id:currentRoomId,ctype:0},SmartFoxClient.XTMSG_TYPE_XML);
					App.audio.play(Cons.audio.Return);
					break;
			}			
		}
		
		private function onRoomCreatedRetrive(evt:WEvent):void
		{
			updateRoomListView(evt.param);  
		}
		private function getDataByID(rid:int):Object{
			for each(var o:Object in rldata){
				if(o.count==rid)return o;
			}
			return null;
		}
		private function removeDataByID(rid:int):void{
			for (var i:int in rldata){
				if(rldata[i].count==rid){
					rldata.splice(i,1);
					break;
				}
			}
		}
		private function updateRoomListView(obj:Object):void
		{
			roomlist.put(obj.id,obj);
			rldata.push({count:obj.id,rcount:obj.min+"/"+obj.max,status:obj.isBattle?"游戏中":"准备中",rname:obj.ownername+"的房间"});
			rlist.array=rldata;
			if(obj.ownerid==GL.id){
				setBoxVisible(true,obj);
				box1.visible=false;
			}
		}
		private var currentRoomId:int=-1;
		private function setBoxVisible(b:Boolean,obj:Object=null):void
		{
				if(b){
					currentRoomId=obj.id;
					var size:int=obj.max;
					for (var i:int =1; i <=8 ; i++)      //多余位置不可见 
					{
							if(i>size){
								this["r"+i].visible=false;
							}else{
								ImageFilter.saturation(this["r"+i],0.5,0.5,0.5);
							}
					}
					
					var arr:Array=obj.ulist;
					var temp:Object;
					for(var i in arr){
						temp=arr[i];
						setRoleItemData(this["r"+(temp.position+1)],temp);
					}
					readybtn.label= obj.ownerid==GL.id?"开始":"准备";
					kickbtn.visible= obj.ownerid==GL.id;
					readybtn.disabled=obj.ownerid==GL.id;
				}else{
//					currentRoomId=-1;
				}
				if(!b){
					for(var i:int in roomItems){
					setRoleItemData(roomItems[i],null);
					}
				}
					box2.visible=b;
		}
		
		private function setRoleItemData(ru:RoleItemUI, da:Object):void
		{
				if(da){
					ru.filters=[];
					ru.rname.text=da.name;
					ru.lv.text="1";
					ru.ready.visible=da.isReady;
					ru.owner.visible=da.isOwner;
				}else{
					ru.filters=[];
					ru.rname.text="";
					ru.lv.text="";
					ru.ready.visible=false;
					ru.owner.visible=false;
				}
		}
		
		private function getParamsOfCreateRoom():Object{
			var obj:Object={};
			trace(GL.currentRoomName);
			if(GL.currentRoomName==Cons.room.Normal)obj.maxU="3";
			if(GL.currentRoomName==Cons.room.Advance)obj.maxU="5";
			if(GL.currentRoomName==Cons.room.Compete)obj.maxU="6";
			if(GL.currentRoomName==Cons.room.Match)obj.maxU="8";
			obj.isGame="true";
			obj.uCount="true";
			obj.name=GL.name;
			obj.ctype=0;
			return obj;
		}
		private function joinRoomSuccess(evt:SFSEvent):void
		{
			MMNG.inst.removeCurrentModule();
			MMNG.inst.loadModule(new HallView);
		}
	}
}