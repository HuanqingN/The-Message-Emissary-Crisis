/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	public class HeroFrameUI extends View {
		protected static var uiXML:XML =
			<View>
			  <Image skin="png.rpg.heroframe" x="0" y="0"/>
			</View>;
		public function HeroFrameUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}