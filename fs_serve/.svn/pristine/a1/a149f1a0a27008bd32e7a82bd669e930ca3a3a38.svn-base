/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class SettingViewUI extends Dialog {
		public var musicbar:Button = null;
		public var voicebar:Button = null;
		public var btn:Button = null;
		public var closebtn:Image = null;
		protected static var uiXML:XML =
			<Dialog>
			  <Image skin="png.rpg.settingback" x="0" y="0"/>
			  <Button skin="png.rpg.btn_hsliderbar" x="489" y="161" var="musicbar" name="musicbar"/>
			  <Button skin="png.rpg.btn_hsliderbar" x="489" y="237" var="voicebar" name="voicebar"/>
			  <Button label="确定" skin="png.rpg.btn_redbutton" x="244" y="388" stateNum="1" width="205" height="56" labelSize="25" labelColors="0xffffff,0xffffff,0xffffff" letterSpacing="3" var="btn" name="btn"/>
			  <Image skin="png.rpg.closebtn" x="648" y="28" var="closebtn" name="closebtn"/>
			</Dialog>;
		public function SettingViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}