package core.mng
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import morn.core.components.View;

	public class MMNG extends EventDispatcher
	{
		private static var mmng:MMNG=new MMNG();
		private var complteFun:Function;
		private var currentModue:View;
		public var root:Sprite;
		public static function get inst():MMNG
		{
			return mmng;
		}
		private var loader:Loader;
		public function loadModule(spr:View):void{
			root.addChild(spr);
			currentModue=spr;
		}
		
		public function removeCurrentModule():void{
			if(currentModue)
				root.removeChild(currentModue);
			currentModue.dispose();
			currentModue=null;
		}
		
		protected function onLoadedModule(event:Event):void
		{
			var spr:Sprite=event.currentTarget.content as Sprite
			root.addChild(spr);
//			currentModue=spr;
			if(complteFun)complteFun.call();
			loader.unload();
		}
	}
}