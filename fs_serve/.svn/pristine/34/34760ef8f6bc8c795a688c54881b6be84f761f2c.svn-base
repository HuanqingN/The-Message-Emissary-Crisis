package views
{
	import flash.events.MouseEvent;
	
	import core.mng.Evt;
	
	import datas.Cons;
	
	import game.ui.test.BattleEndUI;
	
	import handlers.RoomHandler;
	
	import utils.OBJUtil;
	
	public class BattleEnd extends BattleEndUI
	{
		private var wpos:Array=[
		[{x:205,y:243}],
		[{x:121,y:243},{x:286,y:243}],
		[{x:207,y:157},{x:98,y:373},{x:320,y:373}],
		[{x:116,y:160},{x:294,y:160},{x:116,y:372},{x:294,y:372}],
		[{x:66,y:156},{x:196,y:156},{x:333,y:156},{x:129,y:372},{x:271,y:372}],
		[{x:66,y:156},{x:199,y:156},{x:332,y:156},{x:66,y:372},{x:199,y:372},{x:332,y:372}],
		[{x:35,y:156},{x:149,y:156},{x:263,y:156},{x:377,y:156},{x:77,y:372},{x:199,y:372},{x:321,y:372}],
		];
		private var lpos:Array=[
		[{x:661,y:243}],
		[{x:578,y:243},{x:743,y:243}],
		[{x:667,y:157},{x:558,y:373},{x:780,y:373}],
		[{x:571,y:160},{x:749,y:160},{x:571,y:372},{x:749,y:372}],
		[{x:534,y:156},{x:664,y:156},{x:801,y:156},{x:597,y:372},{x:739,y:372}],
		[{x:530,y:156},{x:663,y:156},{x:796,y:156},{x:530,y:372},{x:663,y:372},{x:796,y:372}],
		[{x:496,y:156},{x:610,y:156},{x:724,y:156},{x:838,y:156},{x:538,y:372},{x:660,y:372},{x:782,y:372}],
		];
		public function BattleEnd()
		{
			super();
			btn.addEventListener(MouseEvent.CLICK,onClose);
		}
		
		protected function onClose(event:MouseEvent):void
		{
			App.timer.clearTimer(doLoop);
			Evt.dipatch(RoomHandler.onEndBattle,null);
		}
		
		public function setData(param:Object):void
		{
			var arr:Array=param.users;
			var win:Array=[];
			var lose:Array=[];
			for(var i:int in arr){
				var ri:RoleFrame=new RoleFrame();
				ri.setData(arr[i]);
				if(arr[i].isWin){
					win.push(ri);
				}else{
					lose.push(ri);
				}
			}
			
//			var centArr:Array=OBJUtil.getCenterPos(1000,210,win.length,120,169);
			var centArr:Array=wpos[win.length-1];
			for(var i:int in win){
				win[i].x=centArr[i].x;
				win[i].y=centArr[i].y;
				addChild(win[i]);
			}
//			centArr=OBJUtil.getCenterPos(1000,210,lose.length,120,169);
			centArr=lpos[lose.length-1];
			for(var i:int in lose){
				lose[i].x=centArr[i].x;
				lose[i].y=centArr[i].y;
				addChild(lose[i]);
			}
			time=15;
			btn.label="关闭["+time+"]";
			App.timer.doLoop(1000,doLoop);
		}
		private var time:int=15;
		private function doLoop():void{
			time--;
			btn.label="关闭["+time+"]";
			if(time==0){
				App.timer.clearTimer(doLoop);
				Evt.dipatch(RoomHandler.onEndBattle,null);
			}
		}
	}
}