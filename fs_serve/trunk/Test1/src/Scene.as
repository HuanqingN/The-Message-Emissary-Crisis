package
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.URLRequest;

	public class Scene extends Sprite
	{
		public function Scene()
		{
			
		}
		
		public var img:BitmapData;
		
		public function loadMap(url:String):void{
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,oncomplete);
			loader.load(new URLRequest(url));
		}
		
		protected function oncomplete(event:Event):void
		{
			img=event.currentTarget.content.bitmapData;
			var m:Matrix=new Matrix();
			m.createBox(-1,1,0,0,0);
			this.graphics.beginBitmapFill(img);
			this.graphics.drawRect(0,0,img.width,img.height);
			this.graphics.endFill();
			this.graphics.beginBitmapFill(img,m);
			this.graphics.drawRect(img.width,0,img.width,img.height);
			this.graphics.endFill();
			
		}
	}
}