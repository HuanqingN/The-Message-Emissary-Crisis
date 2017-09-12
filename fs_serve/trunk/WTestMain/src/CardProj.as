package
{
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.KeyLocation;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	
	import core.mng.MMNG;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	import datas.ServerInfo;
	
	import game.ui.test.AboutUI;
	
	import morn.core.handlers.Handler;
	
	import views.LoginView;
	import views.TipView;
	
	[SWF(width="1000",height="700",frameRate="60",backgroundColor=0)]
	public class CardProj extends Sprite
	{
		[Embed(source="config.xml",mimeType="application/octet-stream")] 
		private var config:Class;
//		private static var tf:TextField=new TextField;
//		protected function onKeydown(event:KeyboardEvent):void
//		{
//			if(event.keyCode==Keyboard.K){
//				tf.visible=!tf.visible;
//				App.stage.addChild(tf);
//			}
//		}
		public function CardProj()
		{
			Security.allowDomain("*");
			Security.loadPolicyFile("xmlsocket://wo88.zicp.net:30060")
//			addBackGround();
//			addTf();
//			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeydown);
//			stage.scaleMode=StageScaleMode.NO_SCALE;
			MMNG.inst.root=this;
			TweenPlugin.activate([TransformAroundCenterPlugin]); 
			var byteDataXml:ByteArray = new config();  
			var xml:XML    = XML(byteDataXml.readUTFBytes(byteDataXml.bytesAvailable));
			ServerInfo.initiaByXml(xml);
			initSingleClass();
//			log("准备初始化App.......");
//			App.init(this);
//			log("初始化App完毕.......");
//			log("准备加载资源.......");
			var ld:Loader=new Loader();
			ld.contentLoaderInfo.addEventListener(Event.COMPLETE,preloadComplete);
			ld.load(new URLRequest("assets/Preload.swf"));
//			App.loader.loadAssets(["assets/comp.swf","assets/custom.swf"], new Handler(loadComplete), new Handler(loadProgress));
		}
		private var preLoadMC:Object;
		private function preloadComplete(evt:Event):void{
			preLoadMC=evt.currentTarget.content;
			addChild(preLoadMC as MovieClip);
			App.loader.loadAssets(["assets/comp.swf","assets/custom.swf","assets/rpg.swf"], new Handler(loadComplete), new Handler(loadProgress));
		}
		private function addBackGround():void
		{
			var bmd:BitmapData=new BackImg();
			this.graphics.beginBitmapFill(bmd);
			this.graphics.drawRect(0,0,1200,900);
			this.graphics.endFill();
		}
		
		private function initSingleClass():void
		{
		}
		private function loadProgress(value:Number):void {
			preLoadMC.setPross(value);
		}
		
		private function loadComplete():void {
//			log("加载资源完毕.......");
//			log("准备连接服务器.......");
			App.tipview=new TipView();
			removeChild(preLoadMC as MovieClip);
			preLoadMC=null;
			SFS.inst.startConnected(ServerInfo.inst.IP,ServerInfo.inst.PORT,onConnected);
		}
		protected function onConnected():void{
			//			addChild(new LoginView);
//			log("连接服务器完毕.......");
			MMNG.inst.loadModule(new LoginView);
		}
		public function log(str:String):void{
			preLoadMC.setInfo(str);
//			text+="\n"+str;
		}
//		private function addTf():void{
//			addChild(tf);
//			tf.backgroundColor=0xffffff; 
//			tf.width=350;
//			tf.height=600;
//			tf.selectable=false;
//			var tfm:TextFormat=new TextFormat();
//			tfm.size=15;
//			tfm.color=0xffffff;
//			tf.width=500;
//			tf.height=600;
//			tf.defaultTextFormat=tfm;
//			tf.setTextFormat(tfm);
//		}
	}
}