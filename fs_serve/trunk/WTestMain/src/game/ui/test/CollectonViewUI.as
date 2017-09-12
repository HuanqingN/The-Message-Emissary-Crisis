/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class CollectonViewUI extends Dialog {
		public var closebtn:Button = null;
		public var leftbtn:Button = null;
		public var rightbtn:Button = null;
		public var bt1:Button = null;
		public var bt2:Button = null;
		public var bt3:Button = null;
		public var cbx1:CheckBox = null;
		public var cbx2:CheckBox = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.custom.摧毁底色" x="0" y="0" width="922" height="700" sizeGrid="130,100,130,100"/>
			  <Button skin="png.custom.btn_009gb" x="890" y="15" var="closebtn" name="closebtn"/>
			  <Button label="&lt;&lt;" skin="png.custom.btn_013ls" x="43" y="304" width="33" height="124" var="leftbtn" name="leftbtn"/>
			  <Button label=">>" skin="png.custom.btn_013ls" x="851" y="304" width="33" height="124" var="rightbtn" name="rightbtn"/>
			  <Button label="全部" skin="png.custom.btn_left" x="40" y="59" selected="true" labelColors="0x6fd0d9,0x000808" labelSize="15" letterSpacing="5" var="bt1" name="bt1" stateNum="2" width="80" height="25"/>
			  <Button label="公开" skin="png.custom.btn_middle" x="101" y="59" selected="false" labelColors="0x6fd0d9,0x000808" labelSize="15" letterSpacing="5" var="bt2" name="bt2" stateNum="2" height="25"/>
			  <Button label="潜伏" skin="png.custom.btn_middle" x="170" y="59" selected="false" labelColors="0x6fd0d9,0x000808" labelSize="15" letterSpacing="5" var="bt3" name="bt3" stateNum="2" height="25"/>
			  <CheckBox label="男" skin="png.custom.checkbox" x="257" y="64" labelColors="0x6fd0d9,0x6fd0d9,0x6fd0d9" labelSize="14" selected="true" var="cbx1" name="cbx1"/>
			  <CheckBox label="女" skin="png.custom.checkbox" x="293" y="64" labelColors="0x6fd0d9,0x6fd0d9,0x6fd0d9" labelSize="14" selected="true" var="cbx2" name="cbx2"/>
			  <Label text="图鉴" x="399" y="29" width="146" height="39" color="0xffff33" size="30" align="center" letterSpacing="10" stroke="0xcccccc"/>
			</Dialog>;
		public function CollectonViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}