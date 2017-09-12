/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	import game.ui.test.CaveChooseUI;
	public class SetOutViewUI extends View {
		public var leftbtn:Image = null;
		public var rightbtn:Image = null;
		public var cc1:CaveChooseUI = null;
		public var cc2:CaveChooseUI = null;
		public var closebtn:Image = null;
		protected static var uiXML:XML =
			<View width="1000" height="700">
			  <Image skin="jpg.rpg.background2" x="0" y="0"/>
			  <Button label="出发" skin="png.rpg.btn_redbutton" x="402" y="602" stateNum="1" labelBold="true" labelColors="0xffff00,0xffff00,0xffff00" labelSize="40" letterSpacing="5" labelStroke="0x333333" labelFont="Microsoft YaHei Bold" visible="false"/>
			  <Image skin="png.rpg.go_back_button" x="219" y="297" var="leftbtn" name="leftbtn"/>
			  <Image skin="png.rpg.go_forward_button" x="725" y="298" var="rightbtn" name="rightbtn"/>
			  <CaveChoose x="311" y="34" var="cc1" name="cc1" runtime="game.ui.test.CaveChooseUI"/>
			  <CaveChoose x="1016" y="67" var="cc2" name="cc2" visible="true" alpha="0" runtime="game.ui.test.CaveChooseUI"/>
			  <Image skin="png.rpg.closebtn1" x="929" y="0" var="closebtn" name="closebtn"/>
			</View>;
		public function SetOutViewUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.test.CaveChooseUI"] = CaveChooseUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}