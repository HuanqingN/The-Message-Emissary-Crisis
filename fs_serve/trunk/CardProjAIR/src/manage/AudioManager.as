package manage
{
	import net.singuerinc.media.audio.Audio;

	public class AudioManager
	{
		private var _audio:Audio;
		public function AudioManager()
		{
			
		}
		private var _musicOn:Boolean=true;
		public var voiceOn:Boolean=true;
		private var _musicVolume:Number=1;
		private var _voiceVolume:Number=1;

		public function get voiceVolume():Number
		{
			return _voiceVolume;
		}

		public function set voiceVolume(value:Number):void
		{
			_voiceVolume = value;
		}

		public function get musicVolume():Number
		{
			return _musicVolume;
		}

		public function set musicVolume(value:Number):void
		{
			_musicVolume = value;
			if(_audio)
			_audio.volume=_musicVolume;
		}

		public function get musicOn():Boolean
		{
			return _musicOn;
		}

		public function set musicOn(value:Boolean):void
		{
			_musicOn = value;
			if(!value)_audio.pause()
			else _audio.resume();
		}

		public function play(url:String):void{
			if(!voiceOn)return;
			var a:Audio=new Audio("id",url);
			a.volume=_voiceVolume;
			a.play();
		}
		public function backPlay(url:String):void{
			if(!musicOn)return;
			if(_audio && _audio.isPlaying())_audio.destroy();
			_audio = new Audio('id',  'assets/sounds/'+url+'.mp3');
			_audio.volume=_musicVolume;
			_audio.loops=10000;
			_audio.play();
		}
	}
}