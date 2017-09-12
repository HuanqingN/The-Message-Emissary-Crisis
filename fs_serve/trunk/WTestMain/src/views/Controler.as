package views
{
	import flash.events.MouseEvent;
	
	import core.mng.SFS;
	
	import datas.Cons;
	
	import game.ui.test.ControlerUI;
	
	public class Controler extends ControlerUI
	{
		public function Controler()
		{
			super();
			closebtn.addEventListener(MouseEvent.CLICK,aaaa);
			bt1.addEventListener(MouseEvent.CLICK,bbbb);
			bt2.addEventListener(MouseEvent.CLICK,cccc);
		}
		
		protected function cccc(event:MouseEvent):void
		{
			if(tinput.text=="")return;
			SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.SystemInfo,{msg:tinput.text});
		}
		
		protected function bbbb(event:MouseEvent):void
		{
			SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.SaveAllDatas,null);
		}
		
		protected function aaaa(event:MouseEvent):void
		{
			this.close();
		}
	}
}