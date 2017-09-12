package utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import mx.controls.Image;
	import mx.core.UIComponent;
	
		
	public class HitTester
	{
		public static function realHitTest(object:DisplayObject, point:Point):Boolean {
			if(object is BitmapData) {
				return (object as BitmapData).hitTest(new Point(0,0), 0, object.globalToLocal(point));
			}
			else {
				if(!object.hitTestPoint(point.x, point.y, true)) {
					return false;
				}
				else {
					var bmapData:BitmapData = new BitmapData(object.width, object.height, true, 0x00000000);
					var matrix:Matrix=new Matrix;
//					matrix.tx=object.width;
//					matrix.ty=object.height;
					bmapData.draw(object, matrix);
					var returnVal:Boolean = bmapData.hitTest(new Point(0,0), 0, object.globalToLocal(point));
					bmapData.dispose();
					return returnVal;
				}
			}
		}
		public static function BitMapHitTest(bitmap:Bitmap,point:Point):Boolean{
			return bitmap.bitmapData.hitTest(new Point(0,0), 0, point)
		}
		/*public static function availablyBitMapHitTest(contain:UIComponent):Image{
				var index:int=contain.numChildren
				var temp:Array=[]
				for(var i:int=0;i<index;i++){
					var obj:Object=contain.getChildAt(i)
					if(obj is Image){
						var bitmap:Bitmap=Image(obj).content as Bitmap;
						if(HitTester.BitMapHitTest(bitmap,new Point(bitmap.mouseX,bitmap.mouseY))){
									temp.push({c:obj,i:obj.parent.getChildIndex(obj)})
						}
					}
				}
				
				temp.sortOn("i",Array.NUMERIC|Array.DESCENDING);
				if(temp[0])
				return temp[0].c;
				return null;
		}*/
			
	}
}