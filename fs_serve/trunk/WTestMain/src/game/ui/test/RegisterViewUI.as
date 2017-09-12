/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class RegisterViewUI extends Dialog {
		public var txt1:TextInput = null;
		public var txt2:TextInput = null;
		public var txt3:TextInput = null;
		public var txt4:TextInput = null;
		public var txt5:Label = null;
		public var submit:Button = null;
		public var closebtn:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.custom.011zc" x="0" y="0"/>
			  <TextInput x="148" y="92" width="178" height="20" color="0xa4dfda" size="14" var="txt1" name="txt1" letterSpacing="1" font="黑体"/>
			  <TextInput x="148" y="138" width="178" height="20" color="0xa4dfda" size="14" var="txt2" name="txt2" letterSpacing="1" font="黑体"/>
			  <TextInput x="148" y="185" width="178" height="20" color="0xa4dfda" size="14" asPassword="true" var="txt3" name="txt3" font="黑体"/>
			  <TextInput x="148" y="232" width="178" height="20" color="0xa4dfda" size="14" asPassword="true" var="txt4" name="txt4" font="黑体"/>
			  <Label x="72" y="253" width="260" height="20" align="center" color="0x38b338" stroke="0" size="12" var="txt5" name="txt5" font="黑体"/>
			  <Button label="确认提交" skin="png.custom.btn_3a" x="148" y="282" var="submit" name="submit" labelBold="true" labelColors="0x9b9b9b,0xffffff,0x9b9b9b" labelSize="14" labelStroke="0*0" selected="false" letterSpacing="1" labelFont="黑体"/>
			  <Button skin="png.custom.btn_009gb" x="365" y="20" var="closebtn" name="closebtn"/>
			</Dialog>;
		public function RegisterViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}