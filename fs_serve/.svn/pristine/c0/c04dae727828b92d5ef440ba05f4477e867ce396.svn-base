package views
{
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	
	import core.mng.Player;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import game.ui.test.ProbeViewUI;
	
	import manage.BM;
	
	import morn.core.components.Label;
	
	import utils.OBJUtil;
	
	public class ProbeView extends ProbeViewUI
	{
		public function ProbeView()
		{
			super();
		}
		
		override public function dispose():void
		{
			super.dispose();
			data=null;
		}
		
		
		private var data:Object;
		public var showType:int=0;    //0试探1破译 2检视
		public var success:Boolean;
		public function setData(obj:Object,p:Player):void{
			img.bg.width=200;
			img.bg.height=279;
			data=obj;
			img.bg.bitmapData=OBJUtil.getInstanceByClassName("Act"+obj.cid+"_"+obj.color) as BitmapData;
			bt1.addEventListener(MouseEvent.CLICK,onMouseClick);
			bt2.addEventListener(MouseEvent.CLICK,onMouseClick);
			
			if(showType==1){
				bt1.label="公开并抽一";
				bt2.label="不公开";
				bt1.disabled=!success;
				bt2.disabled=false;
				return;
			}
			if(showType==2){
				bt1.label="检视完成";
				bt2.label="";
				bt2.visible=false;
				bt1.disabled=false;
				return;
			}
			bt1.label=obj.cid%2==0?"弃一张牌":"抽一张牌";
			bt2.label="我是一个好人";
			if(obj.cid==13 || obj.cid==14){
				bt1.disabled=GL.iden==0?false:true;
				bt2.disabled=GL.iden==0?true:false;
			}
			if(obj.cid==15 || obj.cid==16){
				bt1.disabled=GL.iden==1?false:true;
				bt2.disabled=GL.iden==1?true:false;
			}
			if(obj.cid==17 || obj.cid==18){
				bt1.disabled=GL.iden==2?false:true;
				bt2.disabled=GL.iden==2?true:false;
			}
			if(p && p.rid==1){
				bt1.disabled=bt2.disabled=false;
			}
		}
		public var callfun:Function;
		protected function onMouseClick(event:MouseEvent):void
		{
			if(callfun){
				this.close();
				callfun.call();
				showType=0;
				callfun=null;
				return;
			}
			if(showType==0){
			var stype:int;
				if(event.currentTarget.name=="bt1"){
					stype=data.cid%2==0?1:2;
				}else{
					stype=3;
				}
					var param:Object={ctype:1,type:stype,tid:GL.tableId,oid:BM.inst.oid};
					SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
			}else if(showType==2){
				var param:Object={ctype:1,type:0,tid:GL.tableId,oid:BM.inst.oid};
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,param);
				bt2.visible=true;
				showType=0;
			}else{
				var suc:int=event.currentTarget.name=="bt1"?1:0;
				SFS.sendWith(Cons.extension.roomserv,Cons.cmd.OnChooseRecieve,{type:suc,tid:GL.tableId,ctype:1,oid:BM.inst.oid});
				showType=0;				
			}
				this.close();
		}
		
		override public function close(type:String=null):void
		{
			super.close(type);
			bt1.removeEventListener(MouseEvent.CLICK,onMouseClick);
			bt2.removeEventListener(MouseEvent.CLICK,onMouseClick);
		}
		
		
		
	}
}