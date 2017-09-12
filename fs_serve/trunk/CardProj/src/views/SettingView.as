package views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import game.ui.test.SettingViewUI;
	
	public class SettingView extends SettingViewUI
	{
		//186,489
		public function SettingView()
		{
			super();
			closebtn.addEventListener(MouseEvent.MOUSE_UP,onMouseUP);
			btn.addEventListener(MouseEvent.MOUSE_UP,onMouseUP);
			musicbar.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			voicebar.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			App.effect.add(btn,0.1, {transformAroundCenter:{scaleX:0.8, scaleY:0.8}, ease:Linear.easeNone},{transformAroundCenter:{scaleX:1, scaleY:1}, ease:Elastic.easeOut});
			App.effect.add(closebtn,0.1, {transformAroundCenter:{scaleX:0.8, scaleY:0.8}, ease:Linear.easeNone},{transformAroundCenter:{scaleX:1, scaleY:1}, ease:Elastic.easeOut});
		}
		private var selectedTarget:Sprite;
		protected function onMouseDown(event:MouseEvent):void
		{
			selectedTarget=event.currentTarget as Sprite;
			this.addEventListener(MouseEvent.MOUSE_MOVE,onMove);			
			this.addEventListener(MouseEvent.MOUSE_UP,onUp);			
		}
		
		protected function onUp(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);			
			this.removeEventListener(MouseEvent.MOUSE_UP,onUp);		
		}
		
		protected function onMove(event:MouseEvent):void
		{
			selectedTarget.x=this.mouseX;
			if(selectedTarget.x<186)selectedTarget.x=186;
			else if(selectedTarget.x>489)selectedTarget.x=489;
			
			var nowValue:Number=(selectedTarget.x-186)/303;
			if(selectedTarget.name=="musicbar")
				App.audio.musicVolume=nowValue;
			else
				App.audio.voiceVolume=nowValue;
		}
		protected function onMouseUP(event:MouseEvent):void
		{
			TweenLite.to(this,0.5,{y:-700,alpha:0,ease:com.greensock.easing.Linear.easeOut,onComplete:tweenEnd});
		}
		private function tweenEnd():void{
			this.close();
		}
	}
}