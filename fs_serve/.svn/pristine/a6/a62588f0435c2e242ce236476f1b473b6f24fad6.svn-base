package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.Security;

	[SWF(width="1000",height="700",frameRate="60",backgroundColor=0)]
	public class CardProj extends Sprite
	{
		public static  var stag:Stage;
		public function CardProj()
		{
			Security.allowDomain("*");
//			Security.loadPolicyFile("xmlsocket://wo88.zicp.net:30184")
//			Security.loadPolicyFile("xmlsocket://wo88.zicp.net:30060")
//			Security.loadPolicyFile("xmlsocket://124.89.70.158:5002");
//			Security.loadPolicyFile("xmlsocket://127.0.0.1:5002");
//			Security.loadPolicyFile("http://124.89.70.158/crossdomain.xml");
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stag=stage;
//			App.stage=stage;
//			App.init(this);
			var ld:Loader=new Loader();
			ld.contentLoaderInfo.addEventListener(Event.COMPLETE,preloadComplete);
			ld.load(new URLRequest("assets/Preload.swf?v=0.138"));
		}
		private var preLoadMC:Object;
		private function preloadComplete(evt:Event):void{
			preLoadMC=evt.currentTarget.content;
			addChild(preLoadMC as MovieClip);
			var ld:Loader=new Loader();
			ld.contentLoaderInfo.addEventListener(Event.COMPLETE,mainComplete);
			ld.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onprogress);
			ld.load(new URLRequest("Main.swf"));
		}
		
		protected function onprogress(event:ProgressEvent):void
		{
			loadProgress(event.bytesLoaded/event.bytesTotal*100);
		}
		private function mainComplete(evt:Event):void{
			addChild(evt.currentTarget.content as Sprite);
		}
		private function loadProgress(value:Number):void {
			preLoadMC.setPross(value);
		}
		
		public function log(str:String):void{
			preLoadMC.setInfo(str);
		}
	}
}