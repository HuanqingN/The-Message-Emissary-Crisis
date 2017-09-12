package core.mng
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ModuleBase extends Sprite
	{
		public var content:Object;
		public function ModuleBase()
		{
			initEvents();		
			addEventListener(Event.REMOVED_FROM_STAGE,removedFormStage);
		}
		
		public function initEvents():void
		{
		}
		
		private function removedFormStage(evt:Event):void{
			dispose();
		}
		
		public function dispose():void
		{
			clearEvents();
		}
		
		public function clearEvents():void{
			removeEventListener(Event.REMOVED_FROM_STAGE,removedFormStage);
		}
	}
}