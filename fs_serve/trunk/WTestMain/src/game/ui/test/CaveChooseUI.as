/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class CaveChooseUI extends View {
		public var img:Image = null;
		public var btn:Button = null;
		public var pbar:Image = null;
		public var num:Clip = null;
		public var dif:Clip = null;
		public var cname:Label = null;
		protected static var uiXML:XML =
			<View>
			  <Image skin="" x="17" y="1" width="340" height="90" var="img" name="img"/>
			  <Image skin="png.rpg.character_info" x="0" y="87"/>
			  <Image skin="png.rpg.character_info_head" x="0" y="0"/>
			  <Button label="选择" skin="png.rpg.btn_redbutton" x="129" y="470" stateNum="1" width="120" height="50" labelColors="0xffff00,0xffff00,0xffff00" labelSize="25" letterSpacing="3" labelStroke="0x333333" labelFont="Microsoft YaHei Bold" var="btn" name="btn"/>
			  <Image skin="png.rpg.cavebar" x="69" y="154" var="pbar" name="pbar"/>
			  <Clip skin="png.rpg.clip_num" x="201" y="120" clipX="10" width="27" height="31" index="1" var="num" name="num"/>
			  <Image skin="png.rpg.spirit_view_icon_level" x="149" y="122"/>
			  <Clip skin="png.rpg.clip_difficult" x="141" y="230" clipX="3" var="dif" name="dif" index="0"/>
			  <Image skin="png.rpg.frame0" x="235" y="318" width="60" height="60"/>
			  <Label text="遗弃的矿坑" x="121" y="37" width="133" height="21" align="center" size="15" stroke="0xcccccc" var="cname" name="cname" font="Microsoft YaHei Bold"/>
			  <Label text="推荐等级：1~3" x="94" y="546" width="187" height="26" color="0xff66" align="center" size="15" font="Microsoft YaHei Bold"/>
			  <Label text="奖励" x="243" y="281" size="20" color="0x0" stroke="0x33cc33" font="Microsoft YaHei Bold"/>
			  <Label text="消耗" x="93" y="281" size="20" color="0x0" stroke="0x33cc33" font="Microsoft YaHei Bold"/>
			  <Image skin="png.rpg.frame0" x="86" y="318" width="60" height="60"/>
			  <Label text="X 1" x="97" y="380" width="39" height="23" align="center" bold="true" size="15"/>
			  <Label text="X 1" x="244" y="380" width="39" height="23" align="center" bold="true" size="15"/>
			</View>;
		public function CaveChooseUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}