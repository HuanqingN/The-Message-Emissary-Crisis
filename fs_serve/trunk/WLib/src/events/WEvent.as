package events
{
	import flash.events.Event;
	
	public class WEvent extends Event
	{
		public var param:Object;
		public static const ON_MESSAGE:String="ON_MESSAGE";
		public static const ON_INBATTLECONFIRM:String="ON_INBATTLECONFIRM";
		public function WEvent(type:String,param:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.param=param;
			super(type, bubbles, cancelable);
		}
	}
}