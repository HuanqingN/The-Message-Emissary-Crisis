package
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Circ;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.CustomEase;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	import com.greensock.easing.FastEase;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Quart;
	import com.greensock.easing.Quint;
	import com.greensock.easing.RoughEase;
	import com.greensock.easing.Strong;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	
	import utils.Rand;

	public class Hero extends Sprite
	{
		//Back.easeIn Circ 有点象弹跳 Quad
		public var img:BitmapData;
		public var isRunning:Boolean=false;
		
		public function Hero()
		{
			var loader:Loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,oncomplete);
			loader.load(new URLRequest("heroframe.png"));
		}
		protected function oncomplete(event:Event):void
		{
			img=event.currentTarget.content.bitmapData;
			this.graphics.beginBitmapFill(img);
			this.graphics.drawRect(0,0,img.width,img.height);
			this.graphics.endFill();
			this.width=100;
			this.height=140;
			standing();
//			run();
		}
		public function standing():void{
			var n:Number=Rand.range(0.8,1.2,false);
			trace(n);
			TweenMax.to(this,n,{y:this.y-10,yoyo:true,repeat:-1,ease:com.greensock.easing.Quad.easeInOut});
		}
		/**
		 * 
		 * @param isRight //方向
		 * 
		 */		
		public var isRight:Boolean=true;
		public function turnOver(isRight:Boolean):void{
			this.isRight=isRight;
			if(!isRunning){
				isRunning=true;
				TweenMax.killTweensOf(this,true);
				TweenMax.to(this,0.5,{transformAroundCenter:{rotationY:isRight?-30:20,rotationX:20},onComplete:run});
			}
		}
		public function run():void{
			if(isRunning){
//				var n:Number=Rand.range(0.5,0.8,false);
//				TweenMax.to(this,n,{y:this.y-20,yoyo:true,repeat:-1,ease:com.greensock.easing.Quad.easeIn});
//				TweenMax.to(this,0.5,{transformAroundCenter:{rotationY:rotationY-20,rotationX:rotationX+10}});
//				TweenMax.to(this,0.5,{y:this.y-100,ease:com.greensock.easing.Quad.easeIn});
//				TweenMax.to(this,0.5,{yoyo:true,repeat:-1,transformAroundCenter:{scaleX:0.5,scaleY:0.5}});
//			TweenMax.to(this,1,{dropShadowFilter:{color:0x000000, alpha:1, blurX:12, blurY:12, angle:90, distance:20},y:this.y+20,transformAroundCenter:{rotationY:rotationY+180},yoyo:true,repeat:-1,ease:com.greensock.easing.Quad.easeInOut});
//				isRunning=true;	
			}
		}
		
		public function stopRun():void{
			if(isRunning){
//				TweenMax.to(this,1,{transformAroundCenter:{rotationY:0,rotationX:0}});
				isRunning=false;
				TweenMax.killTweensOf(this,true);
				TweenMax.to(this,0.5,{transformAroundCenter:{rotationY:0,rotationX:0},onComplete:standing});
			}
		}
	}
}