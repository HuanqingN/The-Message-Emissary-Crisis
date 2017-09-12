package views
{
	import com.adobe.utils.StringUtil;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import core.mng.Evt;
	import core.mng.SFS;
	
	import datas.Cons;
	
	import events.WEvent;
	
	import game.ui.test.NoticUI;
	import game.ui.test.RegisterViewUI;
	
	import handlers.LoginHandler;

	public class Notic extends NoticUI
	{
		public function Notic()
		{
			super();
			closebtn.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		
		public function onClick(evt:MouseEvent):void{
			switch(evt.currentTarget.name)
			{
				case "closebtn":
					App.dialog.close(this);
					break;
				
			}
		}
	}
}