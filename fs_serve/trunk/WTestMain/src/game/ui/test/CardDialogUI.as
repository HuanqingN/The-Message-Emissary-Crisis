/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class CardDialogUI extends Dialog {
		public var txt:Label = null;
		public var bg:Box = null;
		public var hand:Button = null;
		public var info:Button = null;
		public var yes:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.custom.bg2" x="0" y="0"/>
			  <Label text="请选择你要烧毁的情报" x="132.5" y="4" width="531" height="29" color="0xffff00" align="center" size="20" stroke="0" var="txt" name="txt"/>
			  <Box x="7" y="36" var="bg" name="bg" width="787" height="122"/>
			  <Button label="加入手牌" skin="jpg.custom.btn_g" x="280" y="162" labelColors="0xffffff,0xffffff,0xffffff" labelSize="20" labelStroke="0" var="hand" name="hand" visible="false"/>
			  <Button label="加入情报" skin="jpg.custom.btn_g" x="436" y="162" labelColors="0xffffff,0xffffff,0xffffff" labelSize="20" labelStroke="0" var="info" name="info" visible="false"/>
			  <Button label="确定" skin="jpg.custom.btn_g" x="344" y="162" labelColors="0xffffff,0xffffff,0xffffff" labelSize="20" labelStroke="0" var="yes" name="yes"/>
			</Dialog>;
		public function CardDialogUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}