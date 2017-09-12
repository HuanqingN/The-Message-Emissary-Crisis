package
{
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import core.mng.MMNG;
	import core.mng.SFS;
	
	import datas.ServerInfo;
	
	import morn.core.handlers.Handler;
	
	import views.LoginView;
	import views.TipView;

	[SWF(width="1000",height="700",frameRate="60",backgroundColor=0)]
	public class CardProjAIR extends Sprite
	{
		[Embed(source="config.xml",mimeType="application/octet-stream")] 
		private var config:Class;
		public function CardProjAIR()
		{
			MMNG.inst.root=this;
			App.init(this);
			TweenPlugin.activate([TransformAroundCenterPlugin]); 
			var byteDataXml:ByteArray = new config();  
			var xml:XML    = XML(byteDataXml.readUTFBytes(byteDataXml.bytesAvailable));
			ServerInfo.initiaByXml(xml);
			App.loader.loadAssets(["assets/comp.swf","assets/custom.swf","assets/rpg.swf"], new Handler(loadComplete), new Handler(loadProgress));
		}
		private function loadProgress(value:Number):void {
		}
		
		private function loadComplete():void {
			App.tipview=new TipView();
			SFS.inst.startConnected(ServerInfo.inst.IP,ServerInfo.inst.PORT,onConnected);
		}
		protected function onConnected():void{
			MMNG.inst.loadModule(new LoginView);
		}
	}
}