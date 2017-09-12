/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class RoleFrameUI extends View {
		public var bg:Image = null;
		public var rname:Label = null;
		public var nick:Label = null;
		public var iden:Label = null;
		public var coin:Label = null;
		public var lvbox:Box = null;
		public var lvtxt:Label = null;
		protected static var uiXML:XML =
			<View width="112" height="201">
			  <Image skin="jpg.comp.老兵" x="0" y="1" width="105" height="129" var="bg" name="bg"/>
			  <Image skin="png.custom.018zbk" x="0" y="0" width="112" height="201"/>
			  <Label text="礼服蒙面人" x="3" y="4" width="24" height="98" wordWrap="true" multiline="true" color="0xff33" stroke="0" align="center" var="rname" name="rname" size="15"/>
			  <Label text="一二三四五六七八" x="0" y="126" width="107" height="18" color="0xffffff" stroke="0xcccc" align="center" var="nick" name="nick"/>
			  <Label text="军情" x="62" y="1" color="0xffff00" size="20." rotation="0" width="46" height="27" stroke="0x0" var="iden" name="iden"/>
			  <Image skin="png.comp.coin" x="6" y="164"/>
			  <Label x="32" y="164" width="63" height="18" color="0xffffff" stroke="0xff00" var="coin" name="coin"/>
			  <Box x="8" y="77" var="lvbox" visible="false">
			    <Label text="等级提升" color="0xffff00" size="20" rotation="0" width="96" height="28" stroke="0x0" align="center"/>
			    <Label x="9" y="24" color="0xffff00" size="15" rotation="0" width="77" height="20" stroke="0x0" var="lvtxt" name="lvtxt" align="center"/>
			  </Box>
			</View>;
		public function RoleFrameUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}