package handlers
{
	import core.mng.Evt;

	public class LoginHandler extends HandlerBase
	{
		public static const onLoginRetrive:String="ONLOGINRETRIVE";
		public static const onRegisterRetrive:String="ONREGISTERRETRIVE";
		override protected function initFunArr():void
		{
			funcArr=[
				onLogin,
				RegisterRetrive
			];
		}
		public function onLogin(obj:Object):void{
			Evt.dipatch(onLoginRetrive,obj);
		}
		public function RegisterRetrive(obj:Object):void{
			Evt.dipatch(onRegisterRetrive,obj);
		}
	}
}