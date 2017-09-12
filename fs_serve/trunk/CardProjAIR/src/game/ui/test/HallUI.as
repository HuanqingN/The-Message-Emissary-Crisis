/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	import game.ui.test.HallItemUI;
	public class HallUI extends View {
		public var bt4:HallItemUI = null;
		public var bt5:HallItemUI = null;
		public var bt1:HallItemUI = null;
		public var bt2:HallItemUI = null;
		public var bt3:HallItemUI = null;
		public var enter:Button = null;
		public var leftbtn:Button = null;
		public var rightbtn:Button = null;
		protected static var uiXML:XML =
			<View width="1000" height="700">
			  <HallItem x="580" y="331" scaleX="0.5" scaleY="0.5" var="bt4" name="bt4" runtime="game.ui.test.HallItemUI"/>
			  <HallItem x="323" y="331" scaleX="0.5" scaleY="0.5" var="bt5" name="bt5" runtime="game.ui.test.HallItemUI"/>
			  <HallItem x="141" y="143" var="bt1" name="bt1" scaleX="0.8" scaleY="0.8" runtime="game.ui.test.HallItemUI"/>
			  <HallItem x="378" y="66" var="bt2" name="bt2" runtime="game.ui.test.HallItemUI"/>
			  <HallItem x="671" y="144" var="bt3" name="bt3" scaleX="0.8" scaleY="0.8" runtime="game.ui.test.HallItemUI"/>
			  <Button label="进入" skin="png.custom.btn_room" x="402" y="595" width="215" height="75" labelSize="40" labelColors="0xffffff,0xffffff,0xffffff" labelStroke="0x0" var="enter" name="enter" letterSpacing="5"/>
			  <Button label="&lt;&lt;" skin="png.custom.btn_room" x="24" y="252" width="73" height="90" labelSize="40" labelColors="0xffffff,0xffffff,0xffffff" var="leftbtn" name="leftbtn"/>
			  <Button label=">>" skin="png.custom.btn_room" x="906" y="252" width="73" height="90" labelSize="40" labelColors="0xffffff,0xffffff,0xffffff" var="rightbtn" name="rightbtn"/>
			  <Label text="模式选择" x="420.5" y="7" width="159" height="44" size="40" align="center" stroke="0x333333"/>
			</View>;
		public function HallUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.test.HallItemUI"] = HallItemUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}