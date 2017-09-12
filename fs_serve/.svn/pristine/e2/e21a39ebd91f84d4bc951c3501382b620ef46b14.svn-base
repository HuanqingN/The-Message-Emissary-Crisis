/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class CollectonViewUI extends Dialog {
		public var title:Label = null;
		public var closebtn:Image = null;
		public var btn:Button = null;
		public var rg1:RadioGroup = null;
		public var rg2:RadioGroup = null;
		public var leftbtn:Button = null;
		public var rightbtn:Button = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="jpg.rpg.background3" x="0" y="0"/>
			  <Label text="图鉴" x="392" y="62" width="214" height="39" color="0xffff33" size="30" align="center" letterSpacing="10" stroke="0xcccccc" var="title" name="title"/>
			  <Image skin="png.rpg.closebtn1" x="927" y="3" var="closebtn" name="closebtn"/>
			  <Button skin="png.rpg.button_normal" x="396" y="566" stateNum="1" width="207" height="82" label="关闭" labelColors="0xffffff,0xfffff,0xffffff" labelStroke="0x0" labelSize="30" var="btn" name="btn"/>
			  <RadioGroup labels="全部,公开,潜伏" skin="png.rpg.radiogroup" x="98" y="563" labelColors="0xffffff,0xffffff,0xffffff" labelSize="20" labelStroke="0xcccc" selectedValue="全部" var="rg1" name="rg1"/>
			  <RadioGroup labels="全部,男,女" skin="png.rpg.radiogroup" x="666" y="563" labelColors="0xffffff,0xffffff,0xffffff" labelSize="20" labelStroke="0xcccc" selectedValue="全部" var="rg2" name="rg2"/>
			  <Button skin="png.rpg.button_arrow_left" x="75" y="296" stateNum="1" width="52" height="95" var="leftbtn" name="leftbtn"/>
			  <Button skin="png.rpg.button_arrow_right" x="866" y="296" stateNum="1" width="52" height="95" var="rightbtn" name="rightbtn"/>
			</Dialog>;
		public function CollectonViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}