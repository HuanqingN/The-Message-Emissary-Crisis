/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class PassInputUI extends Dialog {
		public var ti1:TextInput = null;
		public var bt1:Button = null;
		public var closebtn:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.custom.kuang" x="0" y="0" width="311" height="166" sizeGrid="50,50,50,50"/>
			  <Label text="输入房间密码" x="46" y="23" width="206" height="33" size="25" align="center" bold="true" color="0xff9900" stroke="0x0"/>
			  <Image skin="jpg.custom.b1" x="35" y="74" width="237" height="22" sizeGrid="3,3,3,3"/>
			  <TextInput x="40" y="73" width="228" height="22" color="0xff9900" stroke="0x0" size="15" align="center" var="ti1" name="ti1"/>
			  <Button label="加入房间" skin="jpg.custom.btn_y" x="100" y="110" labelSize="20" labelBold="true" labelColors="0xff9900,0xff9900,0xff9900" labelStroke="0x0" var="bt1" name="bt1"/>
			  <Button label="X" skin="jpg.custom.btn_black" x="281" y="8" labelColors="0xff0000" labelBold="true" var="closebtn" name="closebtn" width="20" height="20"/>
			</Dialog>;
		public function PassInputUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}