package views
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	
	import flash.display.Sprite;
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
		private var items:Array=[];
		public function CollectionView()
		{
			super();
			leftbtn.addEventListener(MouseEvent.CLICK,onTurnPage);
			rightbtn.addEventListener(MouseEvent.CLICK,onTurnPage);
			addMouseEvt(leftbtn);
			addMouseEvt(rightbtn);
			closebtn.addEventListener(MouseEvent.CLICK,onCLose);
			btn.addEventListener(MouseEvent.CLICK,onCLose);
			rg1.addEventListener(MouseEvent.CLICK,onToggle);
			rg2.addEventListener(Event.CHANGE,onChange);
			var cx:int=135;
			var cy:int=140;
			var j:int=0;
			for (var i:int = 0; i < 10; i++) 
			{
				var citem:CollectionItem=new CollectionItem();
				items.push(citem);
				citem.name="item"+i;
				citem.x= cx+145*j;
				citem.y=cy;
				addChild(citem);
				j++;
				if(i==4){
					j=0;
					cy=350;
				}
			}
		}
		private function addMouseEvt(btn:Sprite):void{
			App.effect.add(btn,0.1, {transformAroundCenter:{scaleX:0.8, scaleY:0.8}, ease:Linear.easeNone},{transformAroundCenter:{scaleX:1, scaleY:1}, ease:Elastic.easeOut});
		}
		protected function onChange(event:Event):void
		{
			filterData();
		}
		private function filterData():void{
			rg2.selectedIndex
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
				if(rg2.selectedIndex==0){
					if(bool)	temp.push(obj);
				}else{
					if(bool && ((rg2.selectedIndex==1?obj.sex==1:false) || (rg2.selectedIndex==2?obj.sex==0:false))) temp.push(obj);
				}
			}
			roleDatas=temp;
			maxPage=Math.ceil(roleDatas.length/pagecount)-1;
			nowPage=0;
			refreshData();
		}
		private var selectedType:int=0;
		protected function onToggle(event:MouseEvent):void
		{
			selectedType=rg1.selectedIndex;
			filterData();
		}
		
		protected function onCLose(event:MouseEvent):void
		{
			TweenLite.to(this,0.5,{y:-700,alpha:0,ease:com.greensock.easing.Linear.easeOut,onComplete:tweenEnd});
		}
		private function tweenEnd():void{
			this.close();
		}
		protected function onTurnPage(event:MouseEvent):void
		{
			if(tweenning)return;
			if(event.currentTarget.name=="leftbtn"){
				if(nowPage>0)nowPage--;
			}else{
				if(nowPage<maxPage)nowPage++;
			}
			refreshData();
		}
		private var tweens:Array;
		private var tweenning:Boolean=false;
		private function refreshData(first:Boolean=false):void
		{
			tweens=[];
			leftbtn.disabled=nowPage==0;
			rightbtn.disabled=nowPage==maxPage;			
			var temp:Array=roleDatas.slice(nowPage*pagecount,nowPage*pagecount+pagecount);
			if(first){
				for (var i:int = 0; i < 10; i++) 
				{
					items[i].setData(temp[i]);
				}
			}else{
				tweenning=true;
				rg1.disabled=rg2.disabled=true;
				for (var i:int = 0; i < 10; i++) 
				{
					tweens[i]=TweenMax.to(items[i],0.5,{transformAroundCenter:{scaleX:1.3,scaleY:1.3},dropShadowFilter:{color:0x000000, alpha:1, blurX:16, blurY:16, angle:90, distance:20},delay:i*0.06,y:items[i].y-100,alpha:0,onComplete:tweenend,onCompleteParams:[i,items[i],temp[i]]});
				}
			}
		}
		private function tweenend(index:int,item:Object,d:Object):void{
			item.setData(d);
			tweens[index].reverse();
			if(index==9){
				tweenning=false;
				rg1.disabled=rg2.disabled=false;
			}
		}
		private var nowPage:int=0;
		private var pagecount:int=10;
		private var	maxPage:int=1;
		private var roleDatas:Array;
		private var selectedRoleID:int=-1;
		public function showData(type:int=0):void
		{
			title.text=type==0?"图鉴":"选人卡";
			btn.label=type==0?"退出":"选择";
			btn.disabled=type==0?false:selectedRoleID<0;
			rg1.selectedIndex=0;
			var hash:HashMap=GL.roleData;
			roleDatas=hash.values();
			maxPage=Math.ceil(roleDatas.length/pagecount)-1;
			refreshData(true);
		}
	}
}