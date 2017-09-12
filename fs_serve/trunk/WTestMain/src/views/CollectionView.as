package views
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	import datas.GL;
	import datas.Trans;
	
	import game.ui.test.CollectonViewUI;
	
	import morn.core.components.Button;
	import morn.core.components.Image;
	
	import utils.HashMap;
	import utils.StringUtils;
	
	public class CollectionView extends CollectonViewUI
	{
		//x:89,y:112,y:379,x:242
		private var items:Array=[];
		public function CollectionView()
		{
			super();
			leftbtn.addEventListener(MouseEvent.CLICK,onTurnPage);
			rightbtn.addEventListener(MouseEvent.CLICK,onTurnPage);
			closebtn.addEventListener(MouseEvent.CLICK,onCLose);
			bt1.addEventListener(MouseEvent.CLICK,onToggle);
			bt2.addEventListener(MouseEvent.CLICK,onToggle);
			bt3.addEventListener(MouseEvent.CLICK,onToggle);
			cbx1.addEventListener(Event.CHANGE,onChange);
			cbx2.addEventListener(Event.CHANGE,onChange);
			var cx:int=89;
			var cy:int=112;
			var j:int=0;
			for (var i:int = 0; i < 10; i++) 
			{
				var citem:CollectionItem=new CollectionItem();
				items.push(citem);
				citem.name="item"+i;
				citem.x= cx+153*j;
				citem.y=cy;
				addChild(citem);
				j++;
				if(i==4){
					j=0;
					cy=379;
				}
			}
		}
		
		protected function onChange(event:Event):void
		{
			filterData();
		}
		private function filterData():void{
			var hash:HashMap=GL.roleData;
			roleDatas=hash.values();
			var temp:Array=[];
			var bool:Boolean=false;
			for each(var obj:Object in roleDatas){
				if(selectedType==0){
					bool=true;
				}else{
					bool=(selectedType==1?obj.h==0:false) || (selectedType==2?obj.h==1:false)
				}
				if(bool && ((cbx1.selected?obj.sex==1:false) || (cbx2.selected?obj.sex==0:false))) temp.push(obj);
			}
			roleDatas=temp;
			maxPage=Math.ceil(roleDatas.length/pagecount)-1;
			nowPage=0;
			refreshData();
		}
		private var selectedType:int=0;
		private var selectedBtn:Button;
		protected function onToggle(event:MouseEvent):void
		{
			if(event.currentTarget!=selectedBtn){
				selectedBtn.selected=false;
				selectedBtn=event.currentTarget as Button;
				selectedBtn.selected=true;
			}
			switch(event.currentTarget.name)
			{
				case "bt1":
					selectedType=0;
					break;
				case "bt2":
					selectedType=1;
					break;
				case "bt3":
					selectedType=2;
					break;
			}
			filterData();
		}
		
		protected function onCLose(event:MouseEvent):void
		{
			this.close();			
		}
		
		protected function onTurnPage(event:MouseEvent):void
		{
			if(event.currentTarget.name=="leftbtn"){
				if(nowPage>0)nowPage--;
			}else{
				if(nowPage<maxPage)nowPage++;
			}
			
			refreshData();
		}
		
		private function refreshData():void
		{
			leftbtn.disabled=nowPage==0;
			rightbtn.disabled=nowPage==maxPage;			
			var temp:Array=roleDatas.slice(nowPage*pagecount,nowPage*pagecount+pagecount);
			for (var i:int = 0; i < 10; i++) 
			{
				items[i].setData(temp[i]);
			}
		}
		private var nowPage:int=0;
		private var pagecount:int=10;
		private var	maxPage:int=1;
		private var roleDatas:Array;
		public function showData():void
		{
			selectedBtn=bt1;
			var hash:HashMap=GL.roleData;
			roleDatas=hash.values();
			maxPage=Math.ceil(roleDatas.length/pagecount)-1;
			refreshData();
		}
	}
}