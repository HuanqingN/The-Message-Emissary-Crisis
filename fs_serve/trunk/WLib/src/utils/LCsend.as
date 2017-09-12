package utils
{
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	public class LCsend
	{
		public function LCsend()
		{
		}
		
		public static function send(value:String):void
		{
			var conn:LocalConnection = new LocalConnection();
			
			conn.addEventListener(StatusEvent.STATUS, onStatus);
			function onStatus(event:StatusEvent):void {
            switch (event.level) {
                case "status":
                    trace("LocalConnection.send() succeeded");
                    break;
                case "error":
                    trace("LocalConnection.send() failed");
                    break;
	            }
	        }

			if (value is String)
			{
				conn.send('_shediao','showValue',value);
			}
		}
	}
}