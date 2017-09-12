package views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	
	import flash.events.MouseEvent;
	
	import game.ui.test.GambleStoneViewUI;
	
	public class GamblingStoneView extends GambleStoneViewUI
	{
		public function GamblingStoneView()
		{
			super();
			dev.alpha=0;
//			dev.scaleX=dev.scaleY=0.8;
			closebtn.addEventListener(MouseEvent.MOUSE_UP,onMouseUP);
			devbtn.addEventListener(MouseEvent.MOUSE_UP,onDevMouseUP);
		}
		
		protected function onDevMouseUP(event:MouseEvent):void{
			TweenLite.to(devbtn,0.5,{transformAroundCenter:{rotation:devbtn.rotation==0?45:0},ease:com.greensock.easing.Circ.easeOut});
			if(devbtn.rotation==0)
			TweenLite.to(dev,0.5,{alpha:1,transformAroundCenter:{scaleX:1,scaleY:1},ease:com.greensock.easing.Circ.easeOut});
			else
			TweenLite.to(dev,0.5,{alpha:0,transformAroundCenter:{scaleX:0.8,scaleY:0.8},ease:com.greensock.easing.Circ.easeOut});
			
		}
		protected function onMouseUP(event:MouseEvent):void
		{
			TweenLite.to(this,0.5,{y:-700,alpha:0,ease:com.greensock.easing.Linear.easeOut,onComplete:tweenEnd});
		}
		private function tweenEnd():void{
			App.scene.removeChild(this);
		}
	}
}