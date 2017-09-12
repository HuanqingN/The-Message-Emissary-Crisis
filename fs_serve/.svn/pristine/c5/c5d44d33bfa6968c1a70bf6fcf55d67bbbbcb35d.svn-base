package
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quad;
	import com.greensock.layout.ScaleMode;
	import com.greensock.plugins.Physics2DPlugin;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.text.SplitTextField;
	import com.greensock.transform.TransformManager;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import utils.Rand;
	import utils.effect.EffectsManager;

	[SWF(frameRate="60",width="1000",height="700")]
	public class Test1 extends Sprite
	{
		public function Test1()
		{
			TweenPlugin.activate([TransformAroundCenterPlugin]); 
//			var spr:Sprite=new Sprite();
//			spr.graphics.beginFill(0,1);
//			spr.graphics.drawRect(0,0,200,200);
//			spr.graphics.endFill();
//			addChild(spr);
//			TweenLite.to(spr, 5, {transformAroundCenter:{scaleX:0.5, scaleY:0.5}, ease:Elastic.easeOut});
//			for (var i:int = 0; i < 60; i++) {
//				tweenDot(getNewDot(), getRandom(0, 3));
//			}
//			graphics.beginFill(0,1);
//			graphics.drawCircle(100,100,50);
//			graphics.endFill();
//			stage.scaleMode=StageScaleMode.NO_SCALE;
			var text_tf:TextField=new TextField();
			text_tf.width=text_tf.height=400;
			text_tf.text="出牌阶段1";
			var tf:TextFormat=new TextFormat();
			tf.size=20;
			tf.color=0;
			text_tf.setTextFormat(tf);
//			addChild(text_tf);
			text_tf.x=text_tf.y=200;
			 stf= new SplitTextField(text_tf);
			addChild(stf);
//			EffectsManager.Glow(stf,0xff0000,1);
			stf.addEventListener(MouseEvent.CLICK,aaaaa);
			
//				TweenMax.to(stf.textFields[i], 1, {blurFilter:{blurX:10, blurY:10}, x:Math.random() * 650 - 100, y:Math.random() * 350 - 100, scaleX:Math.random() * 4 - 2, scaleY:Math.random() * 4 - 2, rotation:Math.random() * 360 - 180, autoAlpha:0, delay:Math.random() * 0.5, ease:Quad.easeIn, repeat:1, yoyo:true, repeatDelay:1.2});
			
//			TweenLite.to(mc, 0.5, {x:171, y:126, motionBlur:true, ease:Cubic.easeInOut});
//			var stf:SplitTextField = new SplitTextField(text_tf);
//			for (var i:int = stf.textFields.length - 1; i > -1; i--) {
//				TweenMax.to(stf.textFields[i], 1, {blurFilter:{blurX:10, blurY:10}, x:Math.random() * 300, y:Math.random() * 700, scaleX:Math.random() * 4 - 2, scaleY:Math.random() * 4 - 2, rotation:Math.random() * 360 - 180, autoAlpha:0, delay:Math.random() * 1.5, ease:Quad.easeIn, repeat:1, yoyo:true, repeatDelay:1.2});
		}
		private var stf:SplitTextField
		protected function aaaaa(event:MouseEvent):void
		{
			for (var i:int = stf.textFields.length - 1; i > -1; i--) {
				TweenMax.to(stf.textFields[i],1,{rotationX:Rand.range(-50,50),rotationY:Rand.range(-50,50),blurFilter:{blurX:10, blurY:10},x:Rand.range(-40,40), y:Rand.range(-40,40),scaleX:Math.random() * 4 - 2, scaleY:Math.random() * 4 - 2,autoAlpha:0,delay:Math.random() *0.5,ease:Quad.easeIn,repeat:1, yoyo:true,repeatDelay:1.2});
			}
		}
		private function tweenDot(dot:Shape, delay:Number):void {
			dot.x = 172;
			dot.y = 160;
			TweenLite.to(dot, 3, {physics2D:{velocity:getRandom(80, 380), angle:getRandom(245, 295), gravity:400}, delay:delay, onComplete:tweenDot, onCompleteParams:[dot, 0]});
		}
		
		private function getNewDot():Shape {
			var s:Shape = new Shape();
			var green:uint = 0 | int(getRandom(80, 256)) << 8 | 0;
			s.graphics.beginFill(green, 1);
			s.graphics.drawCircle(0, 0, Math.random() * 8 + 5);
			s.graphics.endFill();
			this.addChild(s);
			return s;
		}
		
		private function getRandom(min:Number, max:Number):Number {
			return min + (Math.random() * (max - min));
		}

	}
}