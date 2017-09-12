package
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.TweenNano;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Linear;
	import com.greensock.plugins.Physics2DPlugin;
	import com.greensock.plugins.PhysicsPropsPlugin;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.ui.test.HeroFrameUI;
	
	import morn.core.components.Button;
	import morn.core.components.TextArea;
	import morn.core.handlers.Handler;
	
	import util.GUtil;
	
	import utils.ArrayUtil;

	public class Test extends Sprite
	{
		private var obj:Object={x:0};
		var spr:Sprite=new Sprite();
		public function Test(){
			TweenPlugin.activate([PhysicsPropsPlugin,com.greensock.plugins.TransformAroundCenterPlugin]); 
			trace(Math.pow(2,3));
			App.init(this);
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN,onMousedOWN);
			App.loader.loadAssets(["assets/comp.swf","assets/custom.swf","assets/rpg.swf"], new Handler(loadComplete), new Handler(loadProgress));
//			graphics.beginFill(0xff0000,1);
//			graphics.drawCircle(500,500,3);
//			graphics.endFill();
//			addChild(spr);
//			stage.addEventListener(MouseEvent.CLICK,ccc);
		}
		
		protected function onMousedOWN(event:MouseEvent):void
		{
			TweenMax.from(hero,0.5, {repeat:-1,y:hero.y-20, ease:Linear.easeIn});
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			stage.addEventListener(Event.ENTER_FRAME,onenterframe);
			
		}
		
		protected function onenterframe(event:Event):void
		{
			if(hero.x<stage.mouseX){
				hero.x+=5;
				if(hero.x>=stage.mouseX)stage.removeEventListener(Event.ENTER_FRAME,onenterframe);
			}else{
				hero.x-=5;
				if(hero.x<=stage.mouseX)stage.removeEventListener(Event.ENTER_FRAME,onenterframe);
			}
			
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			var arr:Array=TweenMax.getTweensOf(hero);
//			TweenMax.killChildTweensOf(this,true);
			TweenMax(arr[0]).resume();
			stage.removeEventListener(Event.ENTER_FRAME,onenterframe);
		}
		
		protected function ccc(event:MouseEvent):void
		{
			index=0;
			cx=0;
			dt=10;
			tx=ty=0;
			spr.x=stage.mouseX;
			spr.y=stage.mouseY;
			dx=stage.mouseX-500;
			dy=stage.mouseY-500;
			
			dist=Math.sqrt(dx*dx+dy*dy);
			rt=Math.atan2(dy,dx)*(180/Math.PI)+180;
			spr.rotation=rt;
			end=int((dist-15)/10+1);
			App.timer.doLoop(5,aaa);
		}
		
		private function loadProgress(value:Number):void
		{
			// TODO Auto Generated method stub
			
		}
		private var hero:HeroFrameUI;
		private function loadComplete():void
		{
			hero=new HeroFrameUI();
			addChild(hero);
			hero.x=hero.y=300;
//			hero.addEventListener(MouseEvent.CLICK,bbbbb);
//			var b:Button=new Button();
//			b.width=50;
//			b.height=20;
//			b.label="click";
//			b.addEventListener(MouseEvent.CLICK,bbb);
//			addChild(b);
//			
		}
		public function shakeTween(item:Sprite, repeatCount:int):void 
		{ 
//			TweenPlugin.activate([Physics2DPlugin]); //activation is permanent in the SWF, so this line only needs to be run once.
//			TweenPlugin.activate([Positions2DPlugin]); //activation is permanent in the SWF, so this line only needs to be run once
//			TweenLite.to(mc, 3, {positions2D:[{x:250, y:50}, {x:500, y:0}]}); 
//			TweenLite.to(mc, 2, {physicsProps:{
//				x:{velocity:100, acceleration:200},
//				y:{velocity:-200, friction:0.1}
//			}
//			});
//			TweenLite.to(item, 2, {physics2D:{velocity:300, angle:-60, gravity:400}});
			//--OR--
//			TweenLite.to(item, 2, {physics2D:{velocity:300, angle:-60, friction:0.1}}); 
			//--OR--
//			TweenLite.to(item, 1, {physics2D:{velocity:300, angle:-60, acceleration:50, accelerationAngle:180}}); 
			TweenMax.from(item,0.3, {y:item.y-20, ease:Linear.easeIn});
//			TweenMax.to(item, 1, {y: 300, ease: Bounce.easeOut});
//			TweenMax.to(item,0.5,{transformAroundCenter:{rotationY:90}});
//			TweenMax.to(item,0.5,{delay:0.5,transformAroundCenter:{rotationY:0}})
//			TweenMax.from(item, 1, {y:y-100, ease:Bounce.easeOut,onUpdate:moveMe});
			
//			TweenLite.to(item, 0.5, {physicsProps:{x:{velocity:50}, y:{velocity:-100, acceleration:300}}});
//			TweenMax.to(item,0.1,{repeat:repeatCount-1, y:item.y+(1+Math.random()*5), x:item.x+(1+Math.random()*5), delay:0.1, ease:Expo.easeInOut}); 
//			TweenMax.to(item,0.1,{y:item.y, x:item.x, delay:(repeatCount+1) * .1, ease:Expo.easeInOut}); 
		} 
		private function moveMe():void {
			hero.x +=  5;
		}
		protected function bbbbb(event:MouseEvent):void
		{
			
//			shakeTween(hero, 10);
		}
		public var dx:int=500,dy:int=500,tx:int=0,ty:int=0, dist:Number,rt:Number,dt:int=10;
		protected function bbb(event:MouseEvent):void
		{
			index=0;
			cx=0;
			dt=10;
			tx=ty=0;
			dist=Math.sqrt(dx*dx+dy*dy);
			rt=Math.atan2(dy,dx)*(180/Math.PI);
			spr.rotation=rt;
			end=int((dist-15)/10+1);
			App.timer.doLoop(5,aaa);
		}
		var cx:int=0,cy:int=0,index:int=0,end:int=0;
		public function aaa():void{
//			tx=dt*Math.cos(rt)+0;
//			ty=dt*Math.sin(rt)+0;
//			dt+=10;
			var a:Arrow1=new Arrow1();
			spr.addChild(a);
			a.x=cx;
			a.y=cy;
			cx+=10;
//			a.x=tx;
//			a.y=ty;
//			a.rotation=rt;
			
			index++;
			if(index==end)App.timer.clearTimer(aaa);
		}
	}
}