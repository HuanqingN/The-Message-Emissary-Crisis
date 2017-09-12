/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class LoginViewUI extends View {
		public var txt1:TextInput = null;
		public var txt2:TextInput = null;
		public var txt5:Label = null;
		public var bt1:Button = null;
		public var bt2:Button = null;
		public var bt4:Button = null;
		public var bt3:Button = null;
		public var save:CheckBox = null;
		protected static var uiXML:XML =
			<View width="1000" height="600">
			  <Image skin="jpg.custom.003dljm" x="0" y="0"/>
			  <TextInput x="679" y="400" width="188" height="25" size="14" backgroundColor="0x0" maxChars="15" text="WuhaoLongxiangyu" var="txt1" align="left" color="0xa4dfda" bold="false" font="黑体" letterSpacing="1" stroke="0x0"/>
			  <TextInput x="680" y="440" width="188" height="25" size="20" asPassword="true" maxChars="15" text="qwert" var="txt2" align="left" color="0xa4dfda" stroke="0*0"/>
			  <Label x="646" y="370" width="210" height="20" color="0x82b0b4" align="center" var="txt5" name="txt5" font="黑体" size="12" stroke="0*0"/>
			  <Label text="注意：请务必让浏览器最后的版本号和游戏版本号保持一致，如果不一致请清理缓存。" x="430" y="10" width="560" height="23" color="0x82b0b4" size="14" stroke="0x0" align="center" multiline="false" wordWrap="false" font="黑体"/>
			  <Label text="Version 0.130" x="900" y="668" width="113" height="25" bold="false" size="14" color="0xa4dfda" font="黑体"/>
			  <Button label="注册账号" skin="png.custom.btn_2" x="606" y="508" var="bt1" name="bt1" labelColors="0x82b0b4,0xffffff,0x82b0b4" labelSize="14" labelBold="true" labelStroke="0x0" letterSpacing="1" labelFont="黑体" labelMargin="&#xD;"/>
			  <Button label="进入游戏" skin="png.custom.btn_3a" x="756" y="508" var="bt2" name="bt2" labelSize="14" labelBold="true" labelStroke="0x0" letterSpacing="1" disabled="false" labelColors="0x9b9b9b,0xffffff,0x9b9b9b" labelFont="黑体"/>
			  <Button label="游戏公告" skin="png.custom.btn_2" x="756" y="564" var="bt4" name="bt4" labelBold="true" letterSpacing="1" labelColors="0x82b0b4,0xffffff,0x82b0b4" labelStroke="0*0" labelFont="黑体" labelSize="14" disabled="false" selected="false"/>
			  <Button label="关于我们" skin="png.custom.btn_2" x="606" y="564" var="bt3" name="bt3" labelBold="true" labelSize="14" letterSpacing="1" labelColors="0x82b0b4,0xffffff,0x82b0b4" labelFont="黑体" labelStroke="0*0" disabled="true"/>
			  <CheckBox label="保存账号密码" skin="png.custom.checkbox" x="756" y="480" var="save" name="save" labelColors="0x82b0b4,0xffffff,0x82b0b4" labelSize="12" selected="true" scale="1.1" labelBold="false" labelStroke="0x0"/>
			</View>;
		public function LoginViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}