package utils
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class BMDUtil
	{
		/**
		 *从源图像中截取部分图形并翻转
		 * @param bmdSour   源图像BMD
		 * @param descSize   目标BMD的大小
		 * @param cx				相对源BMD的X轴
		 * @param cy				相对源BMD的Y轴
		 * @param cw				截取图象的宽度
		 * @param ch				截取图象的高度
		 * @param coX			相对目标BMD的X轴偏移
		 * @param coY			相对目标BMD的Y轴偏移
		 * @param angle			翻转的角度
		 * @return 
		 * 
		 */		
		public static function drawRotateImage(bmdSour:BitmapData,descSize:Rectangle,cx:Number,cy:Number,cw:Number,ch:Number,coX:Number,coY:Number,angle:Number,flip:Boolean=false):BitmapData{
			var bmd:BitmapData=new BitmapData(descSize.width,descSize.height,true,0);
			var m:Matrix=new Matrix();
			var rec:Rectangle=new Rectangle(coX,coY,cw,ch);
			if(angle!=0){
				m.rotate(angle*Math.PI/180);
				m.translate(coX-cy,coY+(cx+ch));
			}else{
				m.translate(-(cx-coX),-(cy-coY));
			}
			if(flip){
				m.scale(-1,1);
				rec.x= descSize.width-coX-cw;
				m.translate(coX+cw+rec.x,0);
			}
			bmd.draw(bmdSour,m,null,null,rec);
			return bmd;
		}
		
		public static function drawImage(bmdSour:BitmapData,descSize:Rectangle,cx:Number,cy:Number,cw:Number,ch:Number,coX:Number,coY:Number):BitmapData{
			var bmd:BitmapData=new BitmapData(descSize.width,descSize.height,true,0);
			bmd.copyPixels(bmdSour,new Rectangle(cx,cy,cw,ch),new Point(coX,coY));
			return bmd;
		}
	}
}