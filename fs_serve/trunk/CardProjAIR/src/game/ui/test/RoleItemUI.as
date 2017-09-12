/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class RoleItemUI extends View {
		public var bg:Image = null;
		public var roleimg:Image = null;
		public var check:Button = null;
		public var owner:Image = null;
		public var rname:Label = null;
		public var ready:Image = null;
		public var kickbtn:Button = null;
		protected static var uiXML:XML =
			<View>
			  <Image x="0" y="0" name="bg" var="bg" width="140" height="196" skin="png.custom.006wr"/>
			  <Image x="0" y="0" var="roleimg" name="roleimg"/>
			  <Image skin="png.custom.005tukuang" x="0" y="0"/>
			  <Button skin="png.custom.btn_check" x="79" y="6" width="32" height="18" var="check" name="check" visible="false" toolTip="角色信息"/>
			  <Image skin="png.custom.008fz" x="-4" y="-4" var="owner" name="owner" visible="false"/>
			  <Label x="9" y="173" width="120" height="18" color="0xe6e6" align="center" var="rname" name="rname" selectable="false" size="12" stroke="0*0"/>
			  <Image skin="png.custom.010zb" x="26" y="134" var="ready" name="ready" visible="false"/>
			  <Button skin="png.custom.btn_009gb" x="116" y="6" var="kickbtn" name="kickbtn" visible="false"/>
			</View>;
		public function RoleItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}