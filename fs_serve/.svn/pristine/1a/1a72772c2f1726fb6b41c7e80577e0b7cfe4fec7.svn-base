package manage
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import utils.HashMap;

	public class EffectManager
	{
		private var targets:HashMap=new HashMap();
		public function EffectManager()
		{
		}
		/**
		 * 
		 * @param target 目标
		 * @param dur  时间
		 * @param downEff  按下时的效果对象
		 * @param upEff   弹起时的效果对象
		 * 
		 */		
		public function add(target:Sprite,dur:Number,downEff:Object,upEff):void{
			targets.put(target,[dur,downEff,upEff]);
			target.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			target.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			target.addEventListener(MouseEvent.ROLL_OUT,onMouseUp);
		}
		public function remove(target:Sprite):void{
			target.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			target.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			target.removeEventListener(MouseEvent.ROLL_OUT,onMouseUp);
			targets.remove(target);
		}
		protected function onMouseUp(evt:MouseEvent):void
		{
			var arr:Array=targets.get(evt.currentTarget);
			TweenLite.to(evt.currentTarget,arr[0], arr[2]);
		}
		
		protected function onMouseDown(evt:MouseEvent):void
		{
			var arr:Array=targets.get(evt.currentTarget);
			TweenLite.to(evt.currentTarget,arr[0], arr[1]);
		}
	}
}