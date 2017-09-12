package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;

	[SWF(width="1000",height="700",frameRate="60",backgroundColor=0)]
	public class WTestMain extends Sprite
	{
		public function WTestMain()
		{
			App.init(this);
			stage.scaleMode=StageScaleMode.NO_SCALE;
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,aaa);
			loader.load(new URLRequest("CardProj.swf"));;
		}
		
		protected function aaa(event:Event):void
		{
			var mc:Object=event.currentTarget.content;
			addChild(mc as Sprite);
		}
	}
}