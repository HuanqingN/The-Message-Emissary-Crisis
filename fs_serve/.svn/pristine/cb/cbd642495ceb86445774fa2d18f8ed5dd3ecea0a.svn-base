package views
{
	import flash.events.MouseEvent;
	
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import game.ui.test.DecodeDialogUI;
	
	import manage.BM;
	
	public class DecodeDialog extends DecodeDialogUI
	{
		override public function closeFun():void
		{
			callFun=null;
			title.text="请选择你要宣言的颜色";
		}
		public function DecodeDialog()
		{
			super();
			bt1.addEventListener(MouseEvent.CLICK,onClick);
			bt2.addEventListener(MouseEvent.CLICK,onClick);
			bt3.addEventListener(MouseEvent.CLICK,onClick);
		}
		
		override public function dispose():void
		{
			super.dispose();
			bt1.removeEventListener(MouseEvent.CLICK,onClick);
			bt2.removeEventListener(MouseEvent.CLICK,onClick);
			bt3.removeEventListener(MouseEvent.CLICK,onClick);
		}
		
		public var callFun:Function;
		public function onClick(evt:MouseEvent):void{
			var i:int=int(evt.currentTarget.name.charAt(2));
			this.close();
			if(callFun){
				callFun.call(null,i);			
			}else{
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,{type:i,tid:GL.tableId,ctype:1,oid:BM.inst.oid});
			}
//			this.close();
		}
	}
}