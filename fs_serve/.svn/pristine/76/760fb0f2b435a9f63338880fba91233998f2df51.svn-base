package views
{
	import com.greensock.TweenMax;
	
	import game.ui.test.PopViewUI;
	
	public class PopView extends PopViewUI
	{
		public function PopView()
		{
			super();
		}
		public function show(str:String):void{
			txt.text=str;
			TweenMax.from(this,0.3,{scaleY:0});
			App.timer.doOnce(2000,onTimeout);
		}
		
		private function onTimeout():void
		{
			TweenMax.to(this,1,{y:this.y-100,alpha:0,onComplete:moveout});
		}
		private function moveout():void
		{
			InfoManager(parent).clearPop(this);
		}
	}
}