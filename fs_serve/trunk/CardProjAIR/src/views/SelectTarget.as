package views
{
	import flash.events.MouseEvent;
	
	import game.ui.test.SelectTargetUI;
	
	public class SelectTarget extends SelectTargetUI
	{
		public function SelectTarget()
		{
			super();
			yesbtn.addEventListener(MouseEvent.CLICK,onclick);
			nobtn.addEventListener(MouseEvent.CLICK,onclick);
		}
		
		protected function onclick(event:MouseEvent):void
		{
				if(cfun)cfun.call(null,event.currentTarget.name);
				App.dialog.close(this);
		}
		private var cfun:Function;
		public function setInfo(info:String, fun:Function,boo=false):void
		{
				cfun=fun;
				txt.text=info;
				nobtn.visible=boo;
		}
	}
}