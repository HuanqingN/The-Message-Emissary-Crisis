package views
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import datas.GL;
	import datas.Trans;
	
	import game.ui.test.RoleFrameUI;
	
	import util.GUtil;
	
	import utils.OBJUtil;
	
	public class RoleFrame extends RoleFrameUI
	{
		public function RoleFrame()
		{
			super();
		}
		
		public function setData(obj:Object):void{
			rname.text=GL.roleData.get(obj.rid).n;
			nick.text=obj.rname;
			iden.text=Trans.getIdenStr(obj.iden);
			bg.bitmapData=OBJUtil.getInstanceByClassName("Role"+obj.rid) as BitmapData;
			var c:int=obj.coin-obj.orgcoin;
			coin.text=(c>0?"+ ":"- ") +  Math.abs(c);
			var beforelevel:int=int(GUtil.getLevelByExp(obj.orgexp));
			var afterlevel:int=int(GUtil.getLevelByExp(obj.exp));
			if((afterlevel-beforelevel)>0){
				lvtxt.text= beforelevel+" --> "+afterlevel;
				lvbox.visible=true;
			}else{
				lvbox.visible=false;
			}
//			coin.stroke=c>0?"0x00ff00":"0xff0000";
			if(obj.uid==GL.id){
					GL.coin=obj.coin;
			}
		}
	}
}