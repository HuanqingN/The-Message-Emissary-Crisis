package views
{
	import flash.events.MouseEvent;
	
	import core.mng.SFS;
	
	import datas.Cons;
	
	import game.ui.test.PassInputUI;
	
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	
	public class PassInput extends PassInputUI
	{
		public function PassInput()
		{
			super();
			bt1.addEventListener(MouseEvent.CLICK,onclick);
			closebtn.addEventListener(MouseEvent.CLICK,onclose);
		}
		
		protected function onclose(event:MouseEvent):void
		{
			this.close();
		}
		
		protected function onclick(event:MouseEvent):void
		{
			SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.JoinRoom,{id:rid,ctype:0,pass:ti1.text},SmartFoxClient.XTMSG_TYPE_XML);
			this.close();
		}
		private var rid:int;
		public function refresh(rid:int):void
		{
			this.rid=rid;
			ti1.text="";
		}
	}
}