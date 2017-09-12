/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class PassDialogUI extends Dialog {
		public var txt:Label = null;
		public var nobtn:Button = null;
		public var yesbtn:Button = null;
		protected static var uiXML:XML =
			<Dialog width="600" height="400">
			  <Image skin="jpg.custom.b1" x="0" y="0" width="588" height="39" sizeGrid="3,3,3,3"/>
			  <Label text="是否接收该情报？" x="12" y="3" width="408" height="33" size="20" color="0xcccccc" align="center" var="txt"/>
			  <Button label="不接收" skin="jpg.custom.btn_r" x="377" y="4" labelColors="0xdddddd,0xffffff,0xdddddd" labelSize="20" labelStroke="0" labelFont="微软雅黑" var="nobtn" name="nobtn"/>
			  <Button label="确定" skin="jpg.custom.btn_g" x="484" y="4" labelColors="0xdddddd,0xffffff,0xdddddd" labelSize="20" labelStroke="00" labelFont="微软雅黑" var="yesbtn" name="yesbtn"/>
			</Dialog>;
		public function PassDialogUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}