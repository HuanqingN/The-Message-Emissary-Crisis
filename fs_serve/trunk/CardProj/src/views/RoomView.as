package views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Linear;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import core.mng.Evt;
	import core.mng.MMNG;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import events.WEvent;
	
	import game.ui.test.RoomListItemUI;
	import game.ui.test.RoomViewUI;
	
	import handlers.RoomHandler;
	
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	
	import manage.BM;
	
	import morn.core.components.Box;
	import morn.core.events.UIEvent;
	import morn.core.handlers.Handler;
	
	import utils.ArrayUtil;
	import utils.effect.EffectsManager;
	
	public class RoomView extends RoomViewUI
	{
		private	var btns:Array=["bt1","bt2","bt3","bt4"];
		private var roomdata:Array=[];  //房间列表数据源
		private var currentCell:Box;   //当前选择的房间列表Item
		private var room:WRoom;
		override public function dispose():void{
			for each (var i:String in btns) 
			{
				this[i].removeEventListener(MouseEvent.CLICK,onBtnClick);
			}
			rlist.array=null;
			rlist.mouseHandler=null;
//			music.removeEventListener(MouseEvent.CLICK,onMusicclick);
//			voise.removeEventListener(MouseEvent.CLICK,onvoiselick);
//			rank.removeEventListener(MouseEvent.CLICK,onrankclick);
//			rinfo.removeEventListener(MouseEvent.CLICK,onrankclick);
//			cimage.removeEventListener(MouseEvent.CLICK,onrankclick);
//			getday.removeEventListener(MouseEvent.CLICK,onrankclick);
//			shop.removeEventListener(MouseEvent.CLICK,onrankclick);
//			msginput.removeEventListener(KeyboardEvent.KEY_DOWN,onMsgSend);
//			send.removeEventListener(MouseEvent.CLICK,onMsgSend);
			Evt.remove(RoomHandler.onJoinRoomRetrive,onJoinRoomRetrive);
			Evt.remove(RoomHandler.onDoReadyRetrive,onDoReadyRetrive);
			Evt.remove(RoomHandler.onStartGame,onStartGame);
			Evt.remove(RoomHandler.onGetRoomList,onGetRoomList);
			Evt.remove(RoomHandler.onEndBattle,onEndBattle);
			Evt.remove(RoomHandler.onHallUpdate,onHallUpdate);
//			Evt.remove(WEvent.ON_MESSAGE,ON_MESSAGE);
			if(battlefield)battlefield.dispose()
			battlefield=null;
			battledata=null;
			btns=null;
			roomdata=null;
			currentCell=null;
			if(room)room.dispose();
			room=null;
		}
		private var rankview:RankView;
		private var roleInfo:RoleInfo;
		private var shopview:ShopView;
		private var collectionview:CollectionView;
		protected function onrankclick(event:MouseEvent):void
		{
			switch(event.currentTarget.name)
			{
				case "rank":
					if(!rankview){
						rankview=new RankView();
						rankview.popupCenter=true;
					}
					rankview.showData();
					App.dialog.show(rankview,true);
					break;
				case "rinfo":
					if(!roleInfo){
						roleInfo=new RoleInfo();
						roleInfo.popupCenter=true;
					}
					if(roleInfo.isPopup){
						if(roleInfo.uid==GL.id){
							roleInfo.close();
						}else{
							roleInfo.getRoleInfo(GL.id);						
						}
					}else{
						roleInfo.getRoleInfo(GL.id);						
						App.dialog.show(roleInfo,true);
					}
					break;
				case "cimage":
					if(!collectionview){
						collectionview=new CollectionView();
						collectionview.popupCenter=true;
					}
					collectionview.showData();
					App.dialog.show(collectionview,true);
					break;
				case "getday":
					App.info.show("此功能暂未开放");
					break;
				case "shop":
					if(!shopview){
						shopview=new ShopView();
						shopview.popupCenter=true;
					}
					shopview.showData();
					App.dialog.show(shopview,true);
					break;
			}
		}
		protected function onDevMouseUP(event:MouseEvent):void{
			TweenLite.to(devbtn,0.5,{transformAroundCenter:{rotation:devbtn.rotation==0?45:0},ease:com.greensock.easing.Circ.easeOut});
			if(devbtn.rotation==0)
				TweenLite.to(dev,0.5,{alpha:1,transformAroundCenter:{scaleX:1,scaleY:1},ease:com.greensock.easing.Circ.easeOut});
			else
				TweenLite.to(dev,0.5,{alpha:0,transformAroundCenter:{scaleX:0.8,scaleY:0.8},ease:com.greensock.easing.Circ.easeOut});
			dev.mouseChildren=dev.mouseEnabled=devbtn.rotation==0;
		}
		protected function onMouseUP(event:MouseEvent):void
		{
			TweenLite.to(this,0.5,{y:-700,alpha:0,ease:com.greensock.easing.Linear.easeOut,onComplete:tweenEnd});
		}
		private function tweenEnd():void{
			App.scene.removeChild(this);
		}
		public function RoomView()
		{
			dev.mouseChildren=dev.mouseEnabled=false;
			closebtn.addEventListener(MouseEvent.MOUSE_UP,onMouseUP);
			devbtn.addEventListener(MouseEvent.MOUSE_UP,onDevMouseUP);
			App.audio.backPlay(Cons.audio.BACK);
			App.keyboard.addQuickKick();
			SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.GetTableList,{ctype:0});
			room=new WRoom(this);
			for each (var i:String in btns) 
			{
				this[i].addEventListener(MouseEvent.CLICK,onBtnClick);
			}
//			u1.text=GL.nick;
//			cointxt.text=GL.coin.toString();
			rlist.addEventListener(UIEvent.ITEM_RENDER,ListItemRender);
			rlist.array=roomdata;
			rlist.mouseHandler = new Handler(onCheckListMouse);
//			music.addEventListener(MouseEvent.CLICK,onMusicclick);
//			msginput.addEventListener(KeyboardEvent.KEY_DOWN,onMsgSend);
//			rank.addEventListener(MouseEvent.CLICK,onrankclick);
//			rinfo.addEventListener(MouseEvent.CLICK,onrankclick);
//			cimage.addEventListener(MouseEvent.CLICK,onrankclick);
//			getday.addEventListener(MouseEvent.CLICK,onrankclick);
//			shop.addEventListener(MouseEvent.CLICK,onrankclick);
//			send.addEventListener(MouseEvent.CLICK,onMsgSend);
//			voise.addEventListener(MouseEvent.CLICK,onvoiselick);
			Evt.add(RoomHandler.onJoinRoomRetrive,onJoinRoomRetrive);
			Evt.add(RoomHandler.onDoReadyRetrive,onDoReadyRetrive);
			Evt.add(RoomHandler.onStartGame,onStartGame);
			Evt.add(RoomHandler.onGetRoomList,onGetRoomList);
			Evt.add(RoomHandler.onEndBattle,onEndBattle);
			Evt.add(RoomHandler.onHallUpdate,onHallUpdate);
			Evt.add(RoomHandler.onSystemInfo,onSystemInfo);
			Evt.add(RoomHandler.onErrorInfo,onErrorInfo);
			Evt.add(RoomHandler.onContinueGame,onContinueGame);
			SFS.send(Cons.extension.roomserv,Cons.cmd.CheckInBattle,null);
		}
		protected function ListItemRender(evt:UIEvent):void
		{
			var rui:RoomListItemUI=RoomListItemUI(evt.data[0]);
			rui.lock.visible=(rui.dataSource && rui.dataSource.isLock);
		}
		
		private function onErrorInfo(evt:WEvent):void
		{
			App.info.show(Cons.err.getErrorString(evt.param.type));			
		}
		/**
		 *type 
		 * 1:玩家正在进行战斗
		 * 2.显示系统消息
		 */		
		private function onSystemInfo(evt:WEvent):void
		{
				switch(evt.param.type)
				{
					case 1:
						App.info.showInBattle();
						Evt.add(WEvent.ON_INBATTLECONFIRM,onInBattleConfirm);
						break;
					case 2:
						App.info.show(evt.param.msg);	
						break;
				}
		}
		private var tinymov:MovieClip;
		private function onInBattleConfirm(evt:WEvent):void
		{
			Evt.remove(WEvent.ON_INBATTLECONFIRM,onInBattleConfirm);
			if(evt.param.type==0){
				tinymov=new TinyLoading();
				App.stage.addChild(tinymov);
				tinymov.x=(1000-tinymov.width)/2;
				tinymov.y=(700-tinymov.width)/2;
			}
			SFS.send(Cons.extension.roomserv,Cons.cmd.GetBattleDatas,{type:evt.param.type});
		}
		
		
		//		private var msgTime:Number=0;
//		private function ON_MESSAGE(evt:WEvent):void
//		{
//			var us:User=evt.param.sender;
//			msgarea.appendText("["+StringUtils.getColorString(us.getVariable("nick"),0x99cc00)+"] : "+evt.param.message);
//			msgarea.scrollTo(msgarea.maxScrollV);
//		}
		
//		protected function onMsgSend(event:Event):void
//		{
//			if(event.type==KeyboardEvent.KEY_DOWN){
//				if(KeyboardEvent(event).keyCode!=Keyboard.ENTER)return;
//			}
//			if(getTimer()-msgTime<5000){
//				msgarea.appendText(StringUtils.getColorString("别太频繁发消息哦,骚年们;)",0xff0000));
//				msginput.text="";
//				return;
//			}
//			SFS.inst.sfs.sendPublicMessage(msginput.text,GL.roomId);	
//			msginput.text="";
//			msgTime=getTimer();
//		}
		
		protected function onvoiselick(event:MouseEvent):void
		{
//			if(voise.label=="音效关"){
//				App.audio.voiceOn=false;
//				voise.label="音效开";
//			}else{
//				App.audio.voiceOn=true;
//				voise.label="音效关";
//			}
		}
		
		protected function onMusicclick(event:MouseEvent):void
		{
//			if(music.label=="音乐关"){
//				App.audio.musicOn=false;;
//				music.label="音乐开";
//			}else{
//				App.audio.musicOn=true;;
//				music.label="音乐关";
//			}
		}
		
		private function onHallUpdate(evt:WEvent):void
		{
			var type:int=evt.param.type;
			switch(type)
			{
				case 1: //加
					roomdata.push(evt.param);
					break;
				case 2:  //减
					ArrayUtil.removeItemByParm(roomdata,"rid",evt.param.rid);
					break;
				case 3:  //更新
					var obj:Object=ArrayUtil.getItemByParm(roomdata,"rid",evt.param.rid);
					updateOneProp("rcount",evt.param,obj);
					updateOneProp("status",evt.param,obj);
					break;
			}
			rlist.refresh();
		}
		private function updateOneProp(str:String,from:Object,to:Object):void{
			if(from.hasOwnProperty(str))to[str]=from[str];
		}
		private function onEndBattle(evt:WEvent):void
		{
//			MMNG.inst.root.removeChild(battlefield);
			App.scene.removeChild(battlefield);
			BM.inst.dispose();
			room.clearAllReady();
			this.visible=true;
			room.iden.visible=true;
			battlefield.dispose();
			battlefield=null;
			Evt.dipatch(Evt.onMsgViewShow,{isShow:true});
//			cointxt.text=GL.coin.toString();
		}
		
		private function onGetRoomList(evt:WEvent):void
		{
			var arr:Array=evt.param.rlist;
			for(var i:int in arr){
				roomdata.push(arr[i]);
			}
			rlist.refresh();
		}
		private var battlefield:BattleView;
		private var battledata:Object;
		private function onStartGame(evt:WEvent):void
		{
			battledata=evt.param;
			GL.battleMaxU=evt.param.maxu;
			if(!battlefield)battlefield=new BattleView();
			battlefield.visible=false;
			Evt.dipatch(Evt.onMsgViewShow,{isShow:false});
//			MMNG.inst.root.addChild(battlefield);
			App.scene.addChild(battlefield);
			
			entertime=5;
//			room.iden.visible=false;
			room.enternum.text=entertime.toString();
			room.enternum.visible=true;
			room.entertxt.visible=true;
			room.exitbtn.disabled=true;
			room.readybtn.disabled=true;
//			room.kickbtn.disabled=true;
			App.timer.doLoop(1000,onEnterTimer);
		}
		private var entertime:int=5;
		public function onEnterTimer():void{
			entertime--;
			room.enternum.text=entertime.toString();
			if(entertime==0){
				App.timer.clearTimer(onEnterTimer);
				battlefield.visible=true;
				this.visible=false;
				room.enternum.visible=false;
				room.entertxt.visible=false;
				room.exitbtn.disabled=false;
				room.readybtn.disabled=false;
//				room.kickbtn.disabled=false;
				battlefield.start(battledata);
			}
		}
		private function onContinueGame(evt:WEvent):void
		{
			App.stage.removeChild(tinymov);
			tinymov=null;
			var param:Object=evt.param;
			GL.battleMaxU=param.maxu;
			GL.tableId=param.tid;
			if(!battlefield)battlefield=new BattleView();
			battlefield.reset(param);
			App.scene.addChild(battlefield);
		}
		private function onDoReadyRetrive():void
		{
		}
		
		private function onJoinRoomRetrive():void
		{
		}
		private var nowindex:int=-1;
		private function onCheckListMouse(e:MouseEvent, index:int):void
		{
			if(e.type==MouseEvent.CLICK){
			if(nowindex>=0){
				rlist.getCell(nowindex).filters=[];
			}
			nowindex=index;
			EffectsManager.Glow(rlist.getCell(nowindex),0x00ff00,1,2,2,5);
			}
		}
		private var createRoom:CreateRoom;
		private var passInput:PassInput;
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
					if(!createRoom){
						createRoom=new CreateRoom();
						createRoom.popupCenter=true;
					}
					if(createRoom.isPopup){
						createRoom.close();					
					}else{
						createRoom.refresh(null);
						App.dialog.show(createRoom);
					}
					break;
				case "bt2":
					break;
				case "bt3"://加入房间
					if(nowindex<0)return;
					if(roomdata[nowindex].isLock){
						if(!passInput){
							passInput=new PassInput();
							passInput.popupCenter=true;
						}
						passInput.refresh(roomdata[nowindex].rid);
						App.dialog.popup(passInput);
					}else{
						SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.JoinRoom,{id:roomdata[nowindex].rid,ctype:0,pass:""},SmartFoxClient.XTMSG_TYPE_XML);
					}
//					bt3.disabled=true;
					break;
				case "bt4":  //快速加入
					SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.QuickJoin,{ctype:0},SmartFoxClient.XTMSG_TYPE_XML);
					break;
				case "op6":
					SFS.inst.joinRoom(Cons.room.Hall,joinRoomSuccess);
					break;
			}			
		}
		private function joinRoomSuccess(evt:SFSEvent):void
		{
			MMNG.inst.removeCurrentModule();
			MMNG.inst.loadModule(new HallView);
		}
	}
}