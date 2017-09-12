/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class MsgAreaUI extends View {
		public var btn:Button = null;
		public var msgarea:TextArea = null;
		public var msginput:TextInput = null;
		public var send:Button = null;
		protected static var uiXML:XML =
			<View>
			  <Button skin="png.rpg.btn_msg" x="0" y="323" stateNum="2" var="btn" name="btn"/>
			  <Image skin="png.rpg.msgback" x="54" y="0"/>
			  <TextArea x="73" y="17" width="462" height="629" size="14" var="msgarea" name="msgarea" vScrollBarSkin="png.comp.vscroll1" color="0xa4dfda" stroke="0x0" margin="3,3,20,3" isHtml="true" editable="false" selectable="false" font="黑体" align="left"/>
			  <Image skin="png.rpg.gage_back" x="72" y="648" width="417" height="37"/>
			  <TextInput x="83" y="655" width="398" height="27" size="14" align="left" var="msginput" name="msginput" color="0xa4dfda" maxChars="50" stroke="0x0" multiline="true" wordWrap="true" font="黑体"/>
			  <Button skin="png.rpg.button_ok" x="488" y="649" stateNum="1" width="50" height="35" sizeGrid="30,30,30,30" var="send" name="send"/>
			</View>;
		public function MsgAreaUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}