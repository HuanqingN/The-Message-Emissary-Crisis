package  
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.greensock.easing.Quart;
	
	import flash.display.Sprite;
	
	/**
	 * @author John Lindquist
	 */
	[SWF(width="900", height="480", frameRate="31")]
	public class EasingATimeline extends Sprite 
	{
		private var square:Sprite;
		private static const STEP_DURATION:Number = 1;
		
		public function EasingATimeline()
		{
			square = new Sprite();    
			square.graphics.beginFill(0xcc0000);
			square.graphics.drawRect(0, 0, 50, 50);
			square.graphics.endFill();
			
			square.x = 300;
			square.y = 300;
			
			addChild(square);
			
			var step1:TweenMax = TweenMax.to(square, 0.3, {y:square.y-20, ease: Linear.easeNone});
			var step2:TweenMax = TweenMax.to(square, 0.3, {y: square.y+20, ease: Linear.easeNone});
			//set all the eases of your steps to Linear.easeNone
//			var step1:TweenMax = TweenMax.to(square, STEP_DURATION, {x: 700, y: 50, ease: Linear.easeNone});
//			var step2:TweenMax = TweenMax.to(square, STEP_DURATION, {x: 700, y: 350, ease: Linear.easeNone});
//			var step3:TweenMax = TweenMax.to(square, STEP_DURATION, {x: 100, y: 350, ease: Linear.easeNone});
//			var step4:TweenMax = TweenMax.to(square, STEP_DURATION, {x: 100, y: 50, ease: Linear.easeNone});
			
			var timeline:TimelineMax = new TimelineMax();
			timeline.append(step1);
			timeline.append(step2);
//			timeline.append(step3);
//			timeline.append(step4);
			//pause your timeline
			timeline.pause();
			
			//tween your timeline with whatever ease you want
			TweenMax.to(timeline, timeline.totalDuration, {currentTime: timeline.totalDuration,repeat: -1});
		}
	}
}