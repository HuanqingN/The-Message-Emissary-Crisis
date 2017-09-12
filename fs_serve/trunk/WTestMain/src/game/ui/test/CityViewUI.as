/**Created by the Morn,do not modify.*/
package game.ui.test {
	import morn.core.components.*;
	import game.ui.test.CtitleUI;
	public class CityViewUI extends View {
		public var t1:CtitleUI = null;
		public var t7:CtitleUI = null;
		public var t9:CtitleUI = null;
		public var t10:CtitleUI = null;
		public var t3:CtitleUI = null;
		public var t4:CtitleUI = null;
		public var t8:CtitleUI = null;
		public var t5:CtitleUI = null;
		public var t2:CtitleUI = null;
		public var btn5:Button = null;
		public var btn6:Button = null;
		public var btn2:Button = null;
		public var btn7:Button = null;
		public var btn4:Button = null;
		public var btn3:Button = null;
		public var btn8:Button = null;
		public var btn1:Button = null;
		public var t6:CtitleUI = null;
		public var goldtxt:Button = null;
		public var gemtxt:Button = null;
		public var pname:Label = null;
		public var lvtxt:Label = null;
		protected static var uiXML:XML =
			<View width="1000" height="700">
			  <Image skin="jpg.rpg.aaa" x="0" y="0" width="1000" height="700"/>
			  <Ctitle x="409" y="105" var="t1" name="t1" runtime="game.ui.test.CtitleUI"/>
			  <Ctitle x="124" y="101" var="t7" name="t7" runtime="game.ui.test.CtitleUI"/>
			  <Ctitle x="26" y="420" var="t9" name="t9" runtime="game.ui.test.CtitleUI"/>
			  <Ctitle x="225" y="538" var="t10" name="t10" runtime="game.ui.test.CtitleUI"/>
			  <Ctitle x="605" y="481" var="t3" name="t3" runtime="game.ui.test.CtitleUI"/>
			  <Ctitle x="788" y="529" var="t4" name="t4" runtime="game.ui.test.CtitleUI"/>
			  <Ctitle x="193" y="239" var="t8" name="t8" runtime="game.ui.test.CtitleUI"/>
			  <Ctitle x="796" y="79" var="t5" name="t5" runtime="game.ui.test.CtitleUI"/>
			  <Ctitle x="472" y="425" var="t2" name="t2" runtime="game.ui.test.CtitleUI"/>
			  <Button skin="png.rpg.btn_book" x="529" y="605" width="90" height="90" stateNum="1" var="btn5" name="btn5" toolTip="任务"/>
			  <Button skin="png.rpg.btn_deck" x="628" y="604" stateNum="1" width="90" height="90" var="btn6" name="btn6" toolTip="排名"/>
			  <Button skin="png.rpg.btn_friend" x="222" y="606" stateNum="1" width="100" height="90" var="btn2" name="btn2" toolTip="好友"/>
			  <Button skin="png.rpg.btn_gacha" x="727" y="604" stateNum="1" width="90" height="90" var="btn7" name="btn7" toolTip="图鉴"/>
			  <Button skin="png.rpg.btn_inventory" x="430" y="606" stateNum="1" width="90" height="90" var="btn4" name="btn4" toolTip="背包"/>
			  <Button skin="png.rpg.btn_mail" x="331" y="607" stateNum="1" width="90" height="90" var="btn3" name="btn3" toolTip="邮件"/>
			  <Button skin="png.rpg.btn_setting" x="826" y="603" stateNum="1" width="90" height="90" var="btn8" name="btn8" toolTip="设置"/>
			  <Button skin="png.rpg.btn_store" x="123" y="605" stateNum="1" width="90" height="90" var="btn1" name="btn1" toolTip="角色信息"/>
			  <Ctitle x="528" y="40" var="t6" name="t6" runtime="game.ui.test.CtitleUI"/>
			  <Button label="10000" skin="png.rpg.btn_for_gold" x="677" y="4" stateNum="1" labelColors="0xffffff,0xffffff,0xffffff" labelSize="13" var="goldtxt" name="goldtxt"/>
			  <Button label="0" skin="png.rpg.btn_for_gem" x="838" y="4" stateNum="1" labelColors="0xffffff,0xffffff,0xffffff" labelSize="13" var="gemtxt" name="gemtxt"/>
			  <Image skin="png.rpg.rogue" x="1" y="2" width="120" height="120"/>
			  <Label text="你真的蠢得死" x="23" y="93" width="78" height="18" color="0x33ff99" align="center" var="pname" name="pname"/>
			  <Label text="100" x="11" y="12" color="0xcccc00" align="center" var="lvtxt" name="lvtxt" width="25" height="18"/>
			</View>;
		public function CityViewUI(){}
		override protected function createChildren():void {
			viewClassMap["game.ui.test.CtitleUI"] = CtitleUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}