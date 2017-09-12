/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class GambleStoneViewUI extends View {
		public var devbtn:Image = null;
		public var closebtn:Image = null;
		public var dev:Box = null;
		protected static var uiXML:XML =
			<View width="1000" height="700">
			  <Image skin="jpg.rpg.background1" x="0" y="0"/>
			  <Image skin="png.rpg.addicon" x="17" y="24" var="devbtn" name="devbtn"/>
			  <Image skin="png.rpg.closebtn" x="940" y="14" var="closebtn" name="closebtn"/>
			  <Box x="64" y="47" var="dev" name="dev" width="877" height="576">
			    <Image skin="png.rpg.background2" x="0" y="0" width="877" height="603"/>
			    <Image skin="png.rpg.frame0" x="78" y="128"/>
			    <Image skin="png.rpg.frame0" x="78" y="333"/>
			    <Image skin="png.rpg.frame2" x="205" y="128"/>
			    <Image skin="png.rpg.frame2" x="205" y="332"/>
			    <Image skin="png.rpg.frame1" x="329" y="128"/>
			    <Image skin="png.rpg.frame1" x="453" y="128"/>
			    <Image skin="png.rpg.frame1" x="577" y="128"/>
			    <Image skin="png.rpg.frame1" x="701" y="128"/>
			    <Image skin="png.rpg.frame1" x="329" y="332"/>
			    <Image skin="png.rpg.frame1" x="453" y="332"/>
			    <Image skin="png.rpg.frame1" x="577" y="332"/>
			    <Image skin="png.rpg.frame1" x="701" y="332"/>
			  </Box>
			</View>;
		public function GambleStoneViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}