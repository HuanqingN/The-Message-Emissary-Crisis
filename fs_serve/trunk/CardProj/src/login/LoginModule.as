package login
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import core.mng.Assign;
	import core.mng.Evt;
	import core.mng.MMNG;
	import core.mng.ModuleBase;
	import core.mng.SFS;
	
	import datas.Cons;
	
	import events.WEvent;
	
	import handlers.LoginHandler;
	
	public class LoginModule extends ModuleBase
	{
		[Embed(source="../moduleswfs/Login1.swf",symbol="bbb")]
		private var SClass:Class;
		public var uc:TextField;
		public var pw:TextField;
		public var bt1:MovieClip;
		public var bt2:MovieClip;
		
		override public function initEvents():void
		{
			super.initEvents();
			Evt.add(LoginHandler.onLoginRetrive,onLoginRetrive);
		}
		
		override public function clearEvents():void
		{
			super.clearEvents();
			Evt.remove(LoginHandler.onLoginRetrive,onLoginRetrive);
		}
		
		override public function dispose():void
		{
			super.dispose();
			Assign.inst.remove(Cons.handler.LoginHandler);
		}
		
		private function onLoginRetrive(evt:WEvent):void
		{
			if(evt.param.success){
				MMNG.inst.removeCurrentModule();
//				MMNG.inst.loadModule(Cons.module.Hall,moduleLoaded);
			}else{
				trace("帐号或密码错误！");
			}
		}
		
		private function moduleLoaded():void
		{
			
		}		
		
		public function LoginModule()
		{
			content=new SClass();
			
			Assign.inst.register(Cons.handler.LoginHandler,new LoginHandler);
			uc=content.uc;
			pw=content.pw;
			bt1=content.bt1;
			bt2=content.bt2;
			Object(bt1).txt.mouseEnabled=false;
			Object(bt2).txt.mouseEnabled=false;
			Object(bt2).txt.text="登陆";
			Object(bt1).txt.text="注册";
			bt1.addEventListener(MouseEvent.CLICK,onBt1Click1);
			bt2.addEventListener(MouseEvent.CLICK,onBt1Click2);
			addChild(content as Sprite);
		}
		
		protected function onBt1Click2(event:MouseEvent):void
		{
			SFS.inst.doLogin(uc.text,pw.text);
		}
		
		protected function onBt1Click1(event:Event):void
		{
			trace(111);			
		}
		
	}
}