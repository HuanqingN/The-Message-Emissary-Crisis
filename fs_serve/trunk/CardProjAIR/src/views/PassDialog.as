package views
{
	import flash.events.MouseEvent;
	
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import game.ui.test.PassDialogUI;
	
	import manage.BM;
	
	public class PassDialog extends PassDialogUI
	{
				public function PassDialog()
				{
					super();
					yesbtn.addEventListener(MouseEvent.CLICK,onPassClick);
					nobtn.addEventListener(MouseEvent.CLICK,onPassClick);
				}
				
				override public function dispose():void
				{
					super.dispose();
					yesbtn.removeEventListener(MouseEvent.CLICK,onPassClick);
					nobtn.removeEventListener(MouseEvent.CLICK,onPassClick);
					callfun=null;
				}
				
				
				/**
				 * 
				 * @param info   
				 * @param btype  按钮类型0为0个 1为1个2为2个
				 * @param passtype  PASS类型 0为跳过回合，1为接收情报
				 * 
				 */		
				private var passType:int;
				private var callfun:Function;
				public var oid:int=0;
				public function setInfo(info:String, btype:int=1, passtype:int=0,lab1:String="",lab2:String="",callfun1:Function=null):void
				{
					callfun=callfun1;
					nobtn.label=lab1;
					yesbtn.label=lab2;
					passType=passtype;
					this.txt.text=info;
					nobtn.visible=btype==2;
				}
				
				protected function onPassClick(event:MouseEvent):void
				{
					App.dialog.close(this);
					if(callfun){
						callfun.call(null,event);
						return;
					}
					if(event.currentTarget.name=="yesbtn"){
						if(passType==0){
							SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.OnPass,{uid:GL.id,tid:GL.tableId,ctype:1},"xml");
						}else{
							passType=0;
							SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,{type:1,tid:GL.tableId,ctype:1,oid:BM.inst.oid});
						}
					}else{
						if(passType==0){
							
						}else{
							passType=0;
							SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,{type:0,tid:GL.tableId,ctype:1,oid:BM.inst.oid});
						}
					}
				}
	}
}