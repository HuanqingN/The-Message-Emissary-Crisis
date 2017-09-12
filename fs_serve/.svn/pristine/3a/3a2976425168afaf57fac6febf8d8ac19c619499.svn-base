package core.mng
{
	import flash.events.EventDispatcher;
	
	import events.WEvent;

	public class Evt extends EventDispatcher 
	{
		private static var evtdispatcher:Evt=new Evt();
		public static function inst():Evt{
			return evtdispatcher;
		}
		public static function add(type:String,listener:Function,useCapture:Boolean=false,priority:int=0,useWeakReference:Boolean=false):void{
			evtdispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		
		public static function dipatch(eventname:String,obj:Object):void{
			evtdispatcher.dispatchEvent(new WEvent(eventname,obj));
		}
		
		public static function remove(type:String,fun:Function,uc:Boolean=false):void{
			evtdispatcher.removeEventListener(type,fun,uc);
		}
	}
}