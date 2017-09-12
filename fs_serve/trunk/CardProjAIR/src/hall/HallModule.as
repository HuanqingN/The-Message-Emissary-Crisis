package hall
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import core.mng.MMNG;
	import core.mng.ModuleBase;
	import core.mng.SFS;
	
	import datas.Cons;
	
	import it.gotoandplay.smartfoxserver.SFSEvent;
	import it.gotoandplay.smartfoxserver.data.Room;

	public class HallModule extends ModuleBase
	{
		[Embed(source="../moduleswfs/Hall.swf",symbol="bbb")] 
		private var SClass:Class;
		private var frames:Array=[];
		private var titles:Array=["新手场","普通场","对抗场","比赛场"];
		public function HallModule()
		{
			content=new SClass();
			
			for (var i:int = 0; i < 4; i++) 
			{
				frames.push(content["frame"+i]);
				frames[i].txt.text=titles[i];
				frames[i].img.gotoAndStop(i+1);
				frames[i].btn.addEventListener(MouseEvent.CLICK,this["onEnter"+i]);
			}
			var room:Room=SFS.inst.sfs.getActiveRoom();
			if(room){
				if(room.getName()==Cons.room.Hall){
					addChild(content as Sprite);
				}	else{       //这时可是正在其它房间，需要另外处理    
					
				}
			}else{   //这时还没有初始化房间列表，可能是服务端没返回或其它情况，需要处理
			
			}
		}
		
		override public function clearEvents():void
		{
			super.clearEvents();
			for (var i:int = 0; i < 4; i++) 
			{
				frames[i].btn.removeEventListener(MouseEvent.CLICK,this["onEnter"+i]);
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
		
		public function onEnter0(evt:MouseEvent):void{
			SFS.inst.joinRoom(Cons.room.Normal,onJoinSuccess);
		}
		
		private function onJoinSuccess(evt:SFSEvent):void
		{
			var n:String=evt.params.room.getName();
			if(n==Cons.room.Hall){
				MMNG.inst.removeCurrentModule();
//				MMNG.inst.loadModule(Cons.module.Hall);
			}else{
				MMNG.inst.removeCurrentModule();
//				MMNG.inst.loadModule(Cons.module.Room);
			}
		}
		public function onEnter1(evt:MouseEvent):void{
			SFS.inst.joinRoom(Cons.room.Advance,onJoinSuccess);
		}
		public function onEnter2(evt:MouseEvent):void{
			SFS.inst.joinRoom(Cons.room.Compete,onJoinSuccess);
		}
		public function onEnter3(evt:MouseEvent):void{
			SFS.inst.joinRoom(Cons.room.Match,onJoinSuccess);
		}
		
	}
}