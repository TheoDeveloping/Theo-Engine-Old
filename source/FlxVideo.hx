package;

#if web
import openfl.net.NetStream;
import openfl.net.NetConnection;
import openfl.media.Video;
#elseif android
import extension.webview.WebView;
#end
import flixel.FlxG;
import flixel.FlxBasic;

using StringTools;

class FlxVideo extends FlxBasic
{
        #if web
	var video:Video;
	var netStream:NetStream;
        #end

	public var finishCallback:Dynamic;

	override public function new(videoasset:String)
	{
		super();

                #if web
		video = new Video();
		video.x = 0;
		video.y = 0;
		FlxG.addChildBelowMouse(video);

		var connection:NetConnection = new NetConnection();
		connection.connect(null);
		netStream = new NetStream(connection);
		netStream.client = {onMetaData: client_onMetaData};
		connection.addEventListener('netStatus', netConnection_onNetStatus);
		netStream.play(Paths.video(videoasset));

	        #elseif android

                WebView.playVideo("file:///android_asset/" + Paths.video(videoasset), true);
                WebView.onComplete = function(){
		        if (finishCallback != null){
			        finishCallback();
		        }
                }

                #end
	}

        #if web
	public function finishVideo()
	{
		netStream.dispose();
		if (FlxG.game.contains(video))
		{
			FlxG.game.removeChild(video);
		}
		if (finishCallback != null)
		{
			finishCallback();
		}
	}

	private function client_onMetaData(e)
	{
		video.attachNetStream(netStream);
		video.width = FlxG.width;
		video.height = FlxG.height;
	}

	private function netConnection_onNetStatus(e)
	{
		if (e.info.code == 'NetStream.Play.Complete')
		{
			finishVideo();
		}
	}
        #end
}
