package manage
{
	import flash.events.KeyboardEvent;
	
	import datas.Cons;
	import datas.GL;
	
	import views.Controler;

	public class KeyBoardManager
	{
		public function addQuickKick():void{
			App.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyBoardDown);
			App.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyBoardUp);
		}
		
		protected function onKeyBoardUp(event:KeyboardEvent):void
		{
			if(event.ctrlKey)keyA=false;
			if(event.shiftKey)keyB=false;
			if(event.keyCode==49)keyC=false;
			if(event.keyCode==54)keyD=false;
		}
		private var controller:Controler;
		protected function onKeyBoardDown(event:KeyboardEvent):void
		{
			if(event.ctrlKey)keyA=true;
			if(event.shiftKey)keyB=true;
			if(event.keyCode==49)keyC=true;
			if(event.keyCode==54)keyD=true;
			if(keyA && keyB && keyC && keyD){
				if(!controller){
					controller=new Controler();
					controller.popupCenter=true;
				}
				App.dialog.show(controller);
			}
		}
		private var keyA:Boolean=false;
		private var keyB:Boolean=false;
		private var keyC:Boolean=false;
		private var keyD:Boolean=false;
		public function removeQuickKick():void{
			App.stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyBoardUp);
		}
	}
}