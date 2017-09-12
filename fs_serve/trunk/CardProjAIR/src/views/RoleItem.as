package views
{
	import datas.Cons;
	import datas.GL;
	
	import game.ui.test.RoleItemUI;
	
	public class RoleItem extends RoleItemUI
	{
		public function RoleItem()
		{
			super();
		}
		public var index:int=-1;
		private var _isban:Boolean=false;

		public function get isban():Boolean
		{
			return _isban;
		}

		public function set isban(value:Boolean):void
		{
			_isban = value;
			bg.skin=_isban?"png.custom.007jz":"png.custom.006wr";
			trace(bg.skin+"___"+value+"___"+this.name);
		}

		public function setData(obj:Object):void{
			data=obj;
			if(obj){
//				bg.url="jpg.custom.rf";
				this.check.visible=true;
//				this.bg.visible=true;
				roleimg.bitmapData=new Role3();
//				bg.bitmapData=new Role3();
				rname.text=obj.name;
				ready.visible=obj.isReady;
				if(ready.visible)App.audio.play(Cons.audio.Ready);
				owner.visible=obj.isOwner>=0;
				kickbtn.visible=(GL.id==WRoom.tableOwner && obj.id!=GL.id);
				if(obj.begin){
					ready.disabled=false;
				}
//				isban=obj.isban;
//				lv.text="1";
			}else{
				this.check.visible=false;
				bg.skin="png.custom.006wr";
				roleimg.bitmapData=null;
				this.ready.visible=owner.visible=false;
				rname.text="";
				kickbtn.visible=false;
//				this.bg.visible=false;
//				this.lv.text=rname.text="";
			}
		}
	}
}