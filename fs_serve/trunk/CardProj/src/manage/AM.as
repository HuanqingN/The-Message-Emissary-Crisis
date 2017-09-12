package manage
{
	import actions.Action;
	import actions.Action0;
	
	import utils.HashMap;
	
	import views.BattleView;

	public class AM
	{
		private static var am:AM=new AM();
		public static function get inst():AM{
			return am;
		}
		public var action:Action
		public function initAction(index:int,hash:HashMap,bf:BattleView):void{
			switch(index)
			{
				case 0:
					action= new  Action0;
					break;
			}
			action.phash=hash;
			action.bv=bf;
		}
		
		public function excute(index:int,vid:int):void{
			action.excute(index,vid);
		}
		
		public function clearState():void
		{
			action.clearState();
		}
	}
}