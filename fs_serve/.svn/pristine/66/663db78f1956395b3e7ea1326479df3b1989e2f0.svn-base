package views
{
	import com.greensock.plugins.OnChangeRatioPlugin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	
	import core.mng.Assign;
	import core.mng.Evt;
	import core.mng.MMNG;
	import core.mng.SFS;
	
	import datas.Cons;
	import datas.GL;
	
	import events.WEvent;
	
	import game.ui.test.LoginViewUI;
	
	import handlers.LoginHandler;
	
	import it.gotoandplay.smartfoxserver.SFSEvent;
	
	import utils.HashMap;
	
	
	public class LoginView extends LoginViewUI
	{
		public var myLocalData:SharedObject;
		public function LoginView()
		{
			myLocalData = SharedObject.getLocal("mygamedata");
			save.selected=Boolean(myLocalData.data.save);
			txt1.text=myLocalData.data.username;
			txt2.text=myLocalData.data.userpass;
			Assign.inst.register(Cons.handler.LoginHandler,new LoginHandler);
			bt1.addEventListener(MouseEvent.CLICK,onBtnClick);
			bt2.addEventListener(MouseEvent.CLICK,onBtnClick);
			bt4.addEventListener(MouseEvent.CLICK,onBtnClick);
			save.addEventListener(MouseEvent.CLICK, onCheckClick);
			txt1.addEventListener(Event.CHANGE,OnChange1);
			txt2.addEventListener(Event.CHANGE,OnChange2);
//			txt9.embedFonts=true;
		}
		protected function OnChange2(event:Event):void
		{
			if(save.selected){
				myLocalData.data.userpass=txt2.text;
				myLocalData.flush(500);
			}
		}
		
		protected function OnChange1(event:Event):void
		{
				if(save.selected){
					myLocalData.data.username=txt1.text;
					myLocalData.flush(500);
				}
		}
		
		protected function onCheckClick(event:MouseEvent):void
		{
			
			if(save.selected){
				myLocalData.data.username=txt1.text;
				myLocalData.data.userpass=txt2.text;
				myLocalData.data.save=1;
				myLocalData.flush(500);
			}else{
				myLocalData.data.username="";
				myLocalData.data.userpass="";
				myLocalData.data.save=0;
				myLocalData.flush(500);
			}
		}
		private var reg:RegisterView;
		private var notic:Notic;
		protected function onBtnClick(event:MouseEvent):void
		{
			 switch(event.currentTarget.name){			
				 case "bt1":
					 if(!reg)reg=new RegisterView;
					 App.dialog.popup(reg);
					 break;
				 case "bt2":
					 Evt.add(LoginHandler.onLoginRetrive,onLoginRetrive);
					 SFS.inst.doLogin(txt1.text,txt2.text);
					 break;
				 case "bt4":
					 if(!notic)notic=new Notic;
					 notic.text1.text="版本更新公告（version=0.129）" +"\n"+
						"请大家清除缓存后重新打开网页（不要直接刷新）" +"\n"+
						"***更新内容：" +"\n"+
						"1.修复了公开角色显示“隐藏2”的bug。" +"\n"+
						"2.修复了【亮剑】、【迷雾重重】技能数字指示不消失的bug。" +"\n"+
						"3.再次修复了【倍受宠爱】、【激素】无法抽牌的bug。" +"\n"+
						"4.修复了一个全部退出战斗时，服务端报错（并可能引发服务器主机CPU占用率不断提高）的问题。";
					 App.dialog.popup(notic);
					 break;
			 }
		}
		private function onLoginRetrive(evt:WEvent):void
		{
			if(evt.param.success){
				Evt.remove(LoginHandler.onLoginRetrive,onLoginRetrive);
				GL.name=evt.param.name;				
				GL.nick=evt.param.nick;				
				GL.id=evt.param.id;
				GL.coin=Number(evt.param.coin);
				GL.exp=Number(evt.param.exp);
				GL.favor=evt.param.favor;
				GL.hate=evt.param.hate;
				initBag(evt.param.bag);
				SFS.inst.joinRoom(Cons.room.Normal,onJoinSuccess);
//				MMNG.inst.removeCurrentModule();
//				MMNG.inst.loadModule(new RoomView);
//				MMNG.inst.loadModule(new HallView);
			}else{
				txt5.text="帐号或密码错误！";
			}
		}
		private function initBag(d:String):void{
			GL.bag=new HashMap();
			if(d){
				var arr:Array=d.split(",");
				for each(var str:String in arr){
					var temp:Array=str.split("_");
					GL.bag.put(int(temp[0]),int(temp[1]));
				}
			}
		}
		private function onJoinSuccess(evt:SFSEvent):void
		{
			MMNG.inst.removeCurrentModule();
			MMNG.inst.loadModule(new CityView);
//			MMNG.inst.loadModule(new RoomView);
		}
		override public function dispose():void
		{
			Assign.inst.remove(Cons.handler.LoginHandler);
			bt1.removeEventListener(MouseEvent.CLICK,onBtnClick);
			bt2.removeEventListener(MouseEvent.CLICK,onBtnClick);
			bt4.removeEventListener(MouseEvent.CLICK,onBtnClick);
		}
		
	}
}