package utils.effect
{
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	
	public class IMGManager{	
		public static function overToBright(event:MouseEvent):void{
			setBrightness(event.currentTarget as DisplayObject,50)
		}
		public static function outToBright(event:MouseEvent):void{
			setBrightness(event.currentTarget as DisplayObject,0)
		}
		
		public static function drawFrame(obj:Object,py:int=0):void{
				obj.graphics.clear();
				obj.graphics.beginFill(0x291200,1);
				obj.graphics.drawRect(0,0+py,obj.width,obj.height-py)
				obj.graphics.endFill()
				obj.graphics.lineStyle(1,0xA5825E,1)
				obj.graphics.moveTo(0,0+py)
				obj.graphics.lineTo(obj.width,0+py)
				obj.graphics.lineTo(obj.width,obj.height)
				obj.graphics.moveTo(0,0+py)
				obj.graphics.lineTo(0,obj.height);
				obj.graphics.lineStyle(1,0x713A00,1)
				obj.graphics.moveTo(1,1+py)
				obj.graphics.lineTo(obj.width-1,1+py)
				obj.graphics.lineTo(obj.width-1,obj.height-1)
				obj.graphics.moveTo(1,1+py)
				obj.graphics.lineTo(1,obj.height-1);
				obj.graphics.lineStyle(1,0x3F1F00,1)
				obj.graphics.moveTo(2,2+py)
				obj.graphics.lineTo(obj.width-2,2+py)
				obj.graphics.lineTo(obj.width-2,obj.height-2)
				obj.graphics.moveTo(2,2+py)
				obj.graphics.lineTo(2,obj.height-2);
		}
		
		/**
		 * 重设显示对象为初始状态
		 * @param img 一个显示对象
		 * */		
		public static function onReset(img:DisplayObject):void{
			var cm:ColorMatrix = new ColorMatrix();
			cm.adjustColor(0, 0, 0, 0);
			img.filters = [new ColorMatrixFilter(cm)];
		}

		/**
		 * 设置显示对象的亮度
		 * @param img 一个显示对象
		 * @param value 改变的亮度值,范围从-100到100
		 * */
		public static function setBrightness(img:DisplayObject,value:int):void{
			var cm:ColorMatrix = new ColorMatrix();
			cm.adjustColor(value, 0, 0, 0);
			img.filters = [new ColorMatrixFilter(cm)];
		}
		
		/**
		 * 设置显示对象的对比度
		 * @param img 一个显示对象
		 * @param value 改变的对比度值,范围从-100到100
		 * */
		public static function setContrast(img:DisplayObject,value:int):void{
			var cm:ColorMatrix = new ColorMatrix();
			cm.adjustColor(0, value, 0, 0);
			img.filters = [new ColorMatrixFilter(cm)];
		}
		
		/**
		 * 设置显示对象的饱和度
		 * @param img 一个显示对象
		 * @param value 改变的饱和度值,范围从-100到100
		 * */
		public static function setSaturation(img:DisplayObject,value:int):Array{
			var cm:ColorMatrix = new ColorMatrix();
			cm.adjustColor(0, 0, value, 0);
			var filte:Array=[new ColorMatrixFilter(cm)]
			if(img)
			img.filters =filte ;
			
			return filte
		}	
		
		/**
		 * 设置显示对象的色调
		 * @param img 一个显示对象
		 * @param value 改变的色调值,范围从-100到100
		 * */
		 
		public static function setHue(img:DisplayObject,value:int):void{
			var cm:ColorMatrix = new ColorMatrix();
			cm.adjustColor(0, 0,0,value);
			img.filters = [new ColorMatrixFilter(cm)];
		}							
	}
}