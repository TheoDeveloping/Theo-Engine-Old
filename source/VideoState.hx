package;

import flixel.FlxG;

class VideoState extends MusicBeatState
{
	public static var seenVideo:Bool = false;

	override function create()
	{
		seenVideo = true;
		FlxG.save.data.seenVideo = true;
		FlxG.save.flush();

		if (FlxG.sound.music != null)
		{
			FlxG.sound.music.stop();
		}

                #if (web || android)
		new FlxVideo('kickstarterTrailer').finishCallback = function()
		{
			finishVid();
		};
                #else
		finishVid(); // fallback for other targets
		#end
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
			finishVid();

		super.update(elapsed);
	}

	private function finishVid()
	{
		TitleState.initialized = false;
		FlxG.switchState(new TitleState());
	}
}
