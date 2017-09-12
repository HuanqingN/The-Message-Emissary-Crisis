package views
{
	import flash.events.MouseEvent;
	
	import core.mng.Evt;
	
	import events.WEvent;
	
	import game.ui.test.PopDialogUI;
	
	public class PopDialog extends PopDialogUI
	{
		public function PopDialog()
		{
			super();
			bt1.addEventListener(MouseEvent.CLICK,onBtnclick);
			bt2.addEventListener(MouseEvent.CLICK,onBtnclick);
		}
		
		protected function onBtnclick(event:MouseEvent):void
		{
			if(event.currentTarget.name=="bt1")
			{
				Evt.dipatch(WEvent.ON_INBATTLECONFIRM,{type:1});
				
			}else{
				Evt.dipatch(WEvent.ON_INBATTLECONFIRM,{type:0});
			}
			this.close();
		}
		
		public function initInfo(type:int):void{
			switch(type)
			{
				case 1:
					txt.text="你有正在进行的战斗，是否要继续？";
					bt1.label="算了";
					bt2.label="进入";
					break;
			}
		}
	}
}