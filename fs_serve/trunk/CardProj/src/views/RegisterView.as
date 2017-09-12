package views
{
	import com.adobe.utils.StringUtil;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import core.mng.Evt;
	import core.mng.SFS;
	
	import datas.Cons;
	
	import events.WEvent;
	
	import game.ui.test.RegisterViewUI;
	
	import handlers.LoginHandler;

	public class RegisterView extends RegisterViewUI
	{
		public function RegisterView()
		{
			super();
			submit.addEventListener(MouseEvent.CLICK,onClick);
			closebtn.addEventListener(MouseEvent.CLICK,onClick);
			Evt.add(LoginHandler.onRegisterRetrive,onRegisterRetrive);
		}
		
		private function onRegisterRetrive(evt:WEvent):void
		{
			switch(evt.param.type)
			{
				case 1:
						txt5.text="注册成功,";					
					break;
				case 2:
						txt5.text="注册失败，昵称被占用！";					
					break;
				case 3:
						txt5.text="注册失败，用户名被占用！";					
					break;
				case 4:
						txt5.text="注册失败!";					
					break;
			}			
		}
		
		public function onClick(evt:MouseEvent):void{
			switch(evt.currentTarget.name)
			{
				case "closebtn":
					txt1.text=txt2.text=txt3.text=txt4.text="";
					App.dialog.close(this);
					break;
				case "submit":
					if(StringUtil.trim(txt1.text)=="" ||StringUtil.trim(txt2.text)=="" ||StringUtil.trim(txt3.text)=="" ||StringUtil.trim(txt4.text)=="" ){
						txt5.text="请填写完整信息再提交注册！";
						return;
					}
					if(txt3.text !=txt4.text){
						txt5.text="再次密码输入不一致,请重新输入！";
						return;
					}
					var b:ByteArray=new ByteArray();
					b.writeUTFBytes(txt1.text);
					if(txt1.text.length>16 || b.length>24){
						txt5.text="用户名长度只能为16个英文或8个汉字！";
						return;
					}
					b.clear();
					b.writeUTFBytes(txt2.text);
					if(txt2.text.length>16 || b.length>24){
						txt5.text="昵称长度只能为16个英文或8个汉字！";
						return;
					}
					b.clear();
					b.writeUTFBytes(txt3.text);
					if(txt3.text.length>16 || b.length>24){
						txt5.text="密码长度只能为16个英文或8个汉字！";
						return;
					}
					txt5.text="";
					SFS.inst.sfs.login(Cons.ZONE,txt1.text+"ŒЙ"+txt2.text,txt3.text);
//					SFS.inst.sfs.sendXtMessage(Cons.extension.login,Cons.cmd.OnRegister,{ctype:0,uname:txt1.text,nick:txt2.text,pass:txt3.text});
					break;
			}
		}
	}
}