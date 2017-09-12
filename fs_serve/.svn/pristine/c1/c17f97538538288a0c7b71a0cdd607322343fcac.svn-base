package actions
{
	import events.WEvent;
	
	import manage.BM;
	
	import utils.HashMap;
	
	import views.BattleView;

	public class Action
	{
		public var bv:BattleView;
		public var bm:BM;
		public var phash:HashMap;
		public var nowAid:int;  //动作ID
		public var nowVid:int;  //使用牌的VID
		public function Action():void{
			bm=BM.inst;
		}
		public function excute(index:int,vid:int):void
		{
			nowAid=index;
			nowVid=vid;
			this["doAction"+index]();
		}
		
		public function play(obj:Object):void
		{
				this["play"+obj.cid](obj);			
		}
		
		public function clearState():void
		{
		}
	}
}