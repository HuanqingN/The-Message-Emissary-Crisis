package core.mng
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import datas.Cons;
	import datas.GL;
	
	import events.WEvent;
	
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	
	import manage.BM;
	
	import morn.core.handlers.Handler;

	public class SFS
	{
		public var sfs:SmartFoxClient;
		private static var SFSInst:SFS=new SFS();
		
		public static function get  inst():SFS{
			return SFSInst;
		}
		public var newOid:int=0;
		public var OldOid:int=0;
		public function SFS()
		{
			sfs = new SmartFoxClient(true);
			// Register for SFS events
			sfs.addEventListener(SFSEvent.onConnection, onConnection);
			sfs.addEventListener(SFSEvent.onConnectionLost, onConnectionLost);
			sfs.addEventListener(SFSEvent.onLogin, onLogin);
			sfs.addEventListener(SFSEvent.onRoomListUpdate, onRoomListUpdate);
			sfs.addEventListener(SFSEvent.onJoinRoom, onJoinRoom);
			sfs.addEventListener(SFSEvent.onJoinRoomError, onJoinRoomError);
			sfs.addEventListener(SFSEvent.onExtensionResponse, onExtensionResponse);
			sfs.addEventListener(SFSEvent.onRoomAdded,onRoomAdded );
			sfs.addEventListener(SFSEvent.onRoomDeleted,onRoomDeleted );
			sfs.addEventListener(SFSEvent.onRoomVariablesUpdate,onRoomVariablesUpdate);
			sfs.addEventListener(SFSEvent.onLogout,onLogout);
			sfs.addEventListener(SFSEvent.onUserCountChange,onUserCountChange);
			sfs.addEventListener(SFSEvent.onUserEnterRoom,onUserEnterRoom);
			sfs.addEventListener(SFSEvent.onUserLeaveRoom,onUserLeaveRoom);
			sfs.addEventListener(SFSEvent.onUserVariablesUpdate,onUserVariablesUpdate);
			sfs.addEventListener(SFSEvent.onPublicMessage,onPublicMessage);
			// Register for generic errors
			sfs.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError)
			sfs.addEventListener(IOErrorEvent.IO_ERROR, onIOError)
		}
		
		public static function send(servname:String,cmd:String,param:Object):void{
			SFSInst.sfs.sendXtMessage(servname,cmd,param,SmartFoxClient.XTMSG_TYPE_XML);	
		}
		public static function sendWith(servname:String,cmd:String,param:Object):void{
			App.log.info("发送消息OID:::: "+BM.inst.oid);
			if(BM.inst.oid>0)
			SFSInst.sfs.sendXtMessage(servname,cmd,param,SmartFoxClient.XTMSG_TYPE_XML);	
			BM.inst.oid=0;
		}
		private var msgevt:WEvent=new WEvent(WEvent.ON_MESSAGE);
		protected function onPublicMessage(event:SFSEvent):void
		{
			Evt.dipatch(WEvent.ON_MESSAGE,event.params);
		}
		
		protected function onUserVariablesUpdate(event:SFSEvent):void
		{
			debugTrace("onUserVariablesUpdate");
		}
		
		protected function onUserLeaveRoom(event:SFSEvent):void
		{
			debugTrace("onUserLeaveRoom");
		}
		
		protected function onUserEnterRoom(event:SFSEvent):void
		{
			debugTrace("onUserEnterRoom");
		}
		
		protected function onUserCountChange(event:SFSEvent):void
		{
			debugTrace("onUserCountChange");
		}
		
		protected function onLogout(event:SFSEvent):void
		{
			debugTrace("onLogout");
		}
		
		protected function onRoomVariablesUpdate(event:SFSEvent):void
		{
			debugTrace("onRoomVariablesUpdate");			
		}
		
		protected function onRoomDeleted(event:SFSEvent):void
		{
			debugTrace("onRoomDeleted");			
		}
		
		protected function onRoomAdded(event:SFSEvent):void
		{
			debugTrace("onRoomAdded");
		}
		
		protected function onExtensionResponse(event:SFSEvent):void
		{
			debugTrace("onExtensionResponse");
			if(event.params && event.params.dataObj){
				Assign.inst.invoke(event.params.dataObj);
			}
		}
		
		private var complteFun:Function;
		public function startConnected(Ip:String,Port:int,completFun:Function):void
		{
			this.complteFun=completFun;
			if (!sfs.isConnected){
				App.log.info("连接"+Ip+":"+Port);
				sfs.connect(Ip,Port);
			}
			else
				debugTrace("You are already connected!");
		}
		public function doLogin(acc:String,pwd:String):void{
			sfs.login(Cons.ZONE,acc,pwd);
		}
		/**
		 * Handle connection
		 */
		protected function onConnection(evt:SFSEvent):void
		{
			
			var success:Boolean = evt.params.success;
			
			if (success)
			{
				App.log.info("连接成功");
				heartBeat();
				App.log.info(complteFun);
				App.log.info("Connection successfull!");
				if(complteFun)complteFun.call();
//				sfs.login("simpleChat", "", "");
			}
			else
			{
				App.log.info("Connection failed!");	
			}
		}
		
		private function heartBeat():void
		{
				App.timer.doLoop(30000,onTimeLoop);
		}
		
		private function onTimeLoop():void
		{
				sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.HeartBeat,{ctype:0});			
		}
		
		protected function onConnectionLost(evt:SFSEvent):void
		{
			App.log.info("连不上");
//			CardProj.log("Socket断开"+evt.params);
		}
		
		protected function onLogin(evt:SFSEvent):void
		{
			if (evt.params.success)
			{
				App.log.info("Successfully logged in");
			}
			else
			{
				App.log.info("Login failed. Reason: " + evt.params.error);
			}
		}
		
		protected function onRoomListUpdate(evt:SFSEvent):void
		{
			App.log.info("onRoomListUpdate");
			sfs.autoJoin();
		}
		
		protected function onJoinRoom(evt:SFSEvent):void
		{
			if(joinSuccessFun)joinSuccessFun.call(null,evt);
			GL.roomId=evt.params.room.getId();
		}
		
		protected function onJoinRoomError(evt:SFSEvent):void
		{
			App.log.info("onJoinRoomError: " + evt.params.error);	
		}
		
		protected function onSecurityError(evt:SecurityErrorEvent):void
		{
			App.log.info("Security error: " + evt.text);
		}
		
		/**
		 * Handle an I/O Error
		 */
		protected function onIOError(evt:IOErrorEvent):void
		{
			App.log.info("I/O Error: " + evt.text);
		}
		
		protected function debugTrace(msg:String):void
		{
			trace(msg);
		}
		private var joinSuccessFun:Function;
		public static var onRoomListUpdated:String="ONROOMLISTUPDATED";
		public function joinRoom(rname:String,joinSuccessFun:Function=null):void
		{
				this.joinSuccessFun=joinSuccessFun;
				sfs.joinRoom(rname);			
		}
	}
}