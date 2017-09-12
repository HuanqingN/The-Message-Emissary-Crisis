package views
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import game.ui.test.SetOutViewUI;
	
	public class SetOutView extends SetOutViewUI
	{
		public function SetOutView()
		{
			super();
			addMouseEvt(leftbtn);
			addMouseEvt(rightbtn);
			cc1.img.url="assets/background/setout/1.jpg";
			cc2.img.url="assets/background/setout/2.jpg";
			cc2.cname.text="熔火矿坑";
			ccu=[cc1,cc2];
			closebtn.addEventListener(MouseEvent.MOUSE_UP,onCloseMouseUP);
		}
		protected function onCloseMouseUP(event:MouseEvent):void
		{
			TweenLite.to(this,0.5,{y:-700,alpha:0,ease:com.greensock.easing.Linear.easeOut,onComplete:tweenEnd});
		}
		private function tweenEnd():void{
			App.scene.removeChild(this);
		}
		private function addMouseEvt(btn:Sprite):void{
			App.effect.add(btn,0.1, {transformAroundCenter:{scaleX:0.8, scaleY:0.8}, ease:Linear.easeNone},{transformAroundCenter:{scaleX:1, scaleY:1}, ease:Elastic.easeOut});
			btn.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		private var ccu:Array;
		protected function onMouseUp(event:MouseEvent):void
		{
			ccu[0].mouseChildren=false;
			ccu[0].mouseEnabled=false;
			ccu[1].mouseEnabled=true;
			ccu[1].mouseChildren=true;
			switch(event.currentTarget.name)
			{
				case "leftbtn":
					TweenLite.to(ccu[0],0.5,{x:735,y:-200,alpha:0});
					ccu[1].y=-200;
					ccu[1].x=100;
					ccu[1].alpha=0;
					TweenLite.to(ccu[1],0.5,{x:311,y:34,alpha:1});
					ccu.push(ccu.shift());
					break;
				case "rightbtn":
					TweenLite.to(ccu[0],0.5,{x:100,y:-200,alpha:0});
					ccu[1].y=-200;
					ccu[1].x=735;
					ccu[1].alpha=0;
					TweenLite.to(ccu[1],0.5,{x:311,y:34,alpha:1});
					ccu.push(ccu.shift());
					break;
			}
		}
	}
}