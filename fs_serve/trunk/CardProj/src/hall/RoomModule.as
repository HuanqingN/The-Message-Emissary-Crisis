package hall
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import core.mng.MMNG;
	import core.mng.ModuleBase;
	import core.mng.SFS;
	
	import datas.Cons;
	
	import it.gotoandplay.smartfoxserver.SFSEvent;
	
	public class RoomModule extends ModuleBase
	{
		[Embed(source="../moduleswfs/RoomUI.swf",symbol="bbb")] 
		private var SClass:Class;
		public function RoomModule()
		{
			content=new SClass();
			
			for (var i:int = 0; i < 6; i++) 
			{
				content["t"+(i+1)].mouseEnabled=false;
			}
			content.btn6.addEventListener(MouseEvent.CLICK,onReturn);
			addChild(content as Sprite);
		}
		public function onReturn(evt:MouseEvent):void{
			SFS.inst.joinRoom(Cons.room.Hall,joinRoomSuccess);
		}
		
		private function joinRoomSuccess(evt:SFSEvent):void
		{
			MMNG.inst.removeCurrentModule();
//			MMNG.inst.loadModule(Cons.module.Hall);
		}
	}
}