/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class PopDialogUI extends Dialog {
		public var title:Label = null;
		public var txt:TextArea = null;
		public var bt1:Button = null;
		public var bt2:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.custom.摧毁底色" x="0" y="0"/>
			  <Label text="提示" x="206" y="29" width="229" height="44" color="0xffff66" size="30" align="center" var="title" name="title"/>
			  <TextArea text="你有正在进行的战斗，要进入吗？" x="37" y="122" width="554" height="112" size="25" align="center" color="0x33ffff" var="txt" name="txt"/>
			  <Button label="算了" skin="png.custom.btn_2" x="177" y="257" labelColors="0xffffff,0xffffff,0xffffff" labelFont="Microsoft YaHei Bold" labelSize="16" labelBold="true" var="bt1" name="bt1"/>
			  <Button label="进入" skin="png.custom.btn_2" x="344" y="257" labelFont="Microsoft YaHei Bold" labelColors="0xffffff,0xffffff,0xffffff" labelSize="16" labelBold="true" var="bt2" name="bt2"/>
			</Dialog>;
		public function PopDialogUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}