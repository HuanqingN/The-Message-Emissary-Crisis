/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class ControlerUI extends Dialog {
		public var closebtn:Button = null;
		public var bt1:Button = null;
		public var tinput:TextInput = null;
		public var bt2:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.custom.kuang" x="0" y="0"/>
			  <Button label="X" skin="jpg.custom.btn_black" x="281" y="6" labelColors="0xff0000" labelBold="true" var="closebtn" name="closebtn" width="20" height="20"/>
			  <Button label="数据入库" skin="jpg.custom.btn_g" x="48" y="31" width="211" height="50" labelSize="25" labelColors="0xff0000" labelBold="true" var="bt1" name="bt1"/>
			  <TextInput skin="png.comp.textinput" x="20" y="274" width="266" height="22" var="tinput" name="tinput"/>
			  <Button label="发送通知" skin="jpg.custom.btn_g" x="42" y="302" width="211" height="27" labelSize="25" labelColors="0xff0000" labelBold="true" var="bt2" name="bt2"/>
			</Dialog>;
		public function ControlerUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}