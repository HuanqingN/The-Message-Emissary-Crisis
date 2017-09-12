package
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.plugins.Physics2DPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.text.SplitTextField;
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	import flash.text.TextField;

	public class Test2 extends Sprite
	{
		public function Test2()
		{
			stage.scaleMode=StageScaleMode.NO_SCALE;
			var myTextField1:TextField=new TextField();
			myTextField1.text="myTextField1";
			addChild(myTextField1);
			myTextField1.x=myTextField1.y=200;
			var myTextField2:TextField=new TextField();
			myTextField2.text="myTextField2";
			addChild(myTextField2);
			myTextField2.x=myTextField1.y=300;
			var myTextField3:TextField=new TextField();
			myTextField3.text="myTextField3";
			addChild(myTextField3);
			myTextField3.x=myTextField3.y=400;
			
			
			var stf1:SplitTextField = new SplitTextField(myTextField1);
			
			//tween each character down from 100 pixels above while fading in, and offset the start times by 0.05 seconds
			TweenMax.allFrom(stf1.textFields, 1, {y:"-=100", autoAlpha:0, ease:Elastic.easeOut}, 0.05);
			
			//split myTextField2 by words
			var stf2:SplitTextField = new SplitTextField(myTextField2, SplitTextField.TYPE_WORDS);
			
			//explode the words outward using the physics2D feature of TweenLite/Max
			TweenPlugin.activate([Physics2DPlugin]);
			var i:int = stf2.textFields.length;
			var explodeOrigin:Point = new Point(stf2.width * 0.4, stf2.height + 100);
			while (i--) {
				var angle:Number = Math.atan2(stf2.textFields[i].y - explodeOrigin.y, stf2.textFields[i].x - explodeOrigin.x) * 180 / Math.PI;
				TweenMax.to(stf2.textFields[i], 2, {physics2D:{angle:angle, velocity:Math.random() * 200 + 150, gravity:400}, scaleX:Math.random() * 4 - 2, scaleY:Math.random() * 4 - 2, rotation:Math.random() * 100 - 50, autoAlpha:0, delay:1 + Math.random()});
			}
			
			//split myTextField3 by lines
			var stf3:SplitTextField = new SplitTextField(myTextField3, SplitTextField.TYPE_LINES);
			
			//slide each line in from the right, fading it in over 1 second and staggering the start times by 0.5 seconds. Then swap the original TextField back in.
			TweenMax.allFrom(stf3.textFields, 1, {x:200, autoAlpha:0, onComplete:stf3.deactivate}, 0.5);
		}
	}
}