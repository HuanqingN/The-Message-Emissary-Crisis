package views
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import core.mng.Evt;
	import core.mng.SFS;
	
	import datas.GL;
	
	import events.WEvent;
	
	import game.ui.test.MsgAreaUI;
	
	import it.gotoandplay.smartfoxserver.data.User;
	
	import utils.StringUtils;
	
	public class MessgeArea extends MsgAreaUI
	{
		public function MessgeArea()
		{
			super();
			msginput.addEventListener(KeyboardEvent.KEY_DOWN,onMsgSend);
			send.addEventListener(MouseEvent.CLICK,onMsgSend);
			btn.addEventListener(MouseEvent.CLICK,onMsgShow);
			Evt.add(WEvent.ON_MESSAGE,ON_MESSAGE);
		}
		private var isShow:Boolean=false;
		protected function onMsgShow(event:MouseEvent):void
		{
			if(isShow){
				isShow=false;
				App.stage.removeEventListener(MouseEvent.CLICK,onStageclick);
				TweenMax.to(this,0.5,{x:940,ease:com.greensock.easing.Elastic.easeOut});
			}else{
				isShow=true;
				TweenMax.to(this,0.5,{x:453,ease:com.greensock.easing.Elastic.easeOut,onComplete:onShowed});
			}
			btn.visible=!isShow;
			btn.mouseChildren=btn.mouseEnabled=!isShow;
		}
		
		private function onShowed():void{
			App.stage.addEventListener(MouseEvent.CLICK,onStageclick);
		}
		
		protected function onStageclick(event:MouseEvent):void
		{
			if(isShow && App.stage.mouseX<(this.x+59)){
				onMsgShow(null);
			}
		}
		private var msgTime:Number=0;
		protected function onMsgSend(event:Event):void
		{
			if(msginput.text=="")return;
			if(event.type==KeyboardEvent.KEY_DOWN){
				if(KeyboardEvent(event).keyCode!=Keyboard.ENTER)return;
			}
			if(getTimer()-msgTime<5000){
				msgarea.appendText(StringUtils.getColorString("别太频繁发消息哦,骚年们;)",0xff0000));
				msginput.text="";
				return;
			}
			SFS.inst.sfs.sendPublicMessage(msginput.text,GL.roomId);	
			msginput.text="";
			msgTime=getTimer();
		}
		private function ON_MESSAGE(evt:WEvent):void
		{
			var us:User=evt.param.sender;
			msgarea.appendText("["+StringUtils.getColorString(us.getVariable("nick"),0x99cc00)+"] : "+evt.param.message);
			msgarea.scrollTo(msgarea.maxScrollV);
		}
	}
}