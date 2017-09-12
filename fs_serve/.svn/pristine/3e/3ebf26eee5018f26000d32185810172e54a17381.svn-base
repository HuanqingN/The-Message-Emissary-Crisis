package
{
	import com.greensock.TweenMax;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[SWF(width="1000",height="700",frameRate="60",backgroundColor=0)]
	public class Test3 extends Sprite
	{
		public var sc:Scene
		private var team:Team;
		
		
		public var isRight:Boolean=true;
		public function Test3()
		{
			super();
			TweenPlugin.activate([com.greensock.plugins.TransformAroundCenterPlugin]);
			stage.scaleMode=StageScaleMode.NO_SCALE;
			sc=new Scene();
			addChild(sc);
			sc.loadMap("scene1.jpg");
			team=new Team(this);
			team.init();		
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mousedown);
		}
		
		protected function mousedown(event:MouseEvent):void
		{
			isRight=(team.firstone.x+100/2)<stage.mouseX
			team.run(isRight);
//			hero.turnOver(isRight);
			stage.addEventListener(Event.ENTER_FRAME,aaa);			
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseup);
		}
		
		protected function mouseup(event:MouseEvent):void
		{
			stage.removeEventListener(Event.ENTER_FRAME,aaa);		
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseup);
			team.stopRun();
//			hero.stopRun();
		}
		
		protected function aaa(event:Event):void
		{
			
			sc.x+=isRight?-3:3;
		}
	}
}