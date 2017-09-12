package views
{
	import flash.events.MouseEvent;
	
	import core.mng.Evt;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import events.WEvent;
	
	import game.ui.test.RankUI;
	
	import handlers.RoomHandler;
	
	public class RankView extends RankUI
	{
		private var tempdata:Array;
		public function RankView()
		{
			super();
			Evt.add(RoomHandler.onRank,onRank);
			closebtn.addEventListener(MouseEvent.CLICK,onclosebtnclick);
			tempdata=new Array();
		}
		
		protected function onclosebtnclick(event:MouseEvent):void
		{
			this.close();
		}
		
		private function onRank(evt:WEvent):void
		{
			if(evt.param.ranks){
				GL.rankdata=evt.param.ranks as Array;
				rlist.dataSource=GL.rankdata;
			}
		}
		
		public function showData():void{
			if(!GL.rankdata){
				SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.CheckRank,null);
			}
		}
	}
}