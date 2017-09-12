package views
{
	import com.adobe.utils.StringUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NativeDragEvent;
	
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import game.ui.test.CreateRoomUI;
	
	import it.gotoandplay.smartfoxserver.SmartFoxClient;
	
	import morn.core.components.HSlider;
	import morn.core.handlers.Handler;
	
	import util.GUtil;
	
	public class CreateRoom extends CreateRoomUI
	{
		public function CreateRoom()
		{
			super();
			hs1.changeHandler=new Handler(onChange,[hs1]);
			hs2.changeHandler=new Handler(onChange,[hs2]);
			hs3.changeHandler=new Handler(onChange,[hs3]);
			bt1.addEventListener(MouseEvent.CLICK,onclick);
			closebtn.addEventListener(MouseEvent.CLICK,onclose);
			cb1.addEventListener(Event.CHANGE,oncheckboxchange);
		}
		
		protected function oncheckboxchange(event:Event):void
		{
			if(cb1.selected==true){
				hs1.disabled=true;
				hs1.value=0;
				lb1.text="0";
			}else{
				hs1.disabled=false;
				hs1.value=100;
				lb1.text="100";
			}
		}
		
		protected function onclose(event:MouseEvent):void
		{
			this.close();
		}
		
		protected function onclick(event:MouseEvent):void
		{
			if(StringUtil.trim(ti1.text)=="")ti1.text="";
			SFS.inst.sfs.sendXtMessage(Cons.extension.roomserv,Cons.cmd.CreateRoom,{maxU:8,ctype:0,ante:hs1.value,level:hs2.value,rate:hs3.value,sameip:cb1.selected,pass:ti1.text},SmartFoxClient.XTMSG_TYPE_XML);
			this.close();
		}
		
		public function onChange(hs:HSlider,value:int):void{
			switch(hs)
			{
				case hs1:
					 lb1.text=value.toString();
					break;
				case hs2:
					lb2.text="不低于"+value+"级";
					break;
				case hs3:
					lb3.text="不低于"+value+"%";
					break;
			}
		}
		public function refresh(param:Object):void
		{
			if(param){
				
			}else{
				hs1.max=int(GUtil.getLevelByExp(GL.exp))*100;
				hs1.value=100;hs2.value=1;hs3.value=0;ti1.text="";
			}
		}
	}
}