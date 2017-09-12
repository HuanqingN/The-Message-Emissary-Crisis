package utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	[Event(name="complete", type="flash.events.Event")]
	
	public class TotalBytes extends EventDispatcher
	{
		private var _url:Array;
		private var _p:int;
		private var _totalBytes:Number;
		
		public function TotalBytes(url:Array)
		{
			_url = url;
		}
		
		public function get totalBytes():Number
		{
			return _totalBytes;
		}
		
		public function getSize(url:Array=null):void
		{
			if ( url!=null )
			{
				_url = url;
			}
			if ( _url && _url.length>0 )
			{
				_p = 0;
				_totalBytes = 0;
				load();
			}
		}
		
		private function load():void
		{
			if ( _p>=_url.length )
			{
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.load(new URLRequest(_url[_p]));
		}
		
		private function progressHandler(evt:ProgressEvent):void
		{
			var loader:URLLoader = evt.currentTarget as URLLoader;
			if ( evt.bytesTotal>0 )
			{
				_totalBytes += evt.bytesTotal;
				loader.close();
				loader.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
				_p++;
				load();
			}
		}

	}
}