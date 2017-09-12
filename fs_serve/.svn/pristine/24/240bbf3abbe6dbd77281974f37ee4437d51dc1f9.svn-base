/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class DecodeDialogUI extends Dialog {
		public var title:Label = null;
		public var bt1:Button = null;
		public var bt2:Button = null;
		public var bt3:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="jpg.custom.b1" x="0" y="0" sizeGrid="3,3,3,3" width="305" height="201"/>
			  <Label text="请选择你要宣言的颜色" x="48" y="7" color="0xffff00" size="20" var="title" name="title"/>
			  <Button label="蓝色" skin="png.comp.button" x="41" y="49" width="230" height="38" labelColors="0x0000FF" labelSize="30" letterSpacing="10" labelFont="微软雅黑" var="bt1" name="bt1"/>
			  <Button label="红色" skin="png.comp.button" x="41" y="96" width="230" height="38" labelColors="0xFF0000" labelSize="30" letterSpacing="10" var="bt2" name="bt2"/>
			  <Button label="黑色" skin="png.comp.button" x="41" y="143" width="230" height="38" labelSize="30" letterSpacing="10" var="bt3" name="bt3"/>
			</Dialog>;
		public function DecodeDialogUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}