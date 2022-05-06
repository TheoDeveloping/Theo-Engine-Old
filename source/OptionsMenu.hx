package;

import flixel.FlxG;

class OptionsMenu extends MusicBeatState
{
	var items:TextMenuList;

	override public function new(showDiscord:Bool)
	{
		super();
		items = new TextMenuList();
		add(items);
		createItem('preferences', function()
		{
			FlxG.switchState(new options.PreferencesMenu ());
		});
		createItem('controls', function()
		{
		    #if desktop
		    FlxG.switchState(new options.ControlsMenu());
		    #end
		    #if android
			FlxG.switchState(new options.CustomControlsState());
			#end
		});
		if (showDiscord)
		{
			createItem('discord', selectDiscord, true);
		}
		// if (NG.core != null && NG.core.loggedIn)
		// {
		// 	createItem('logout', selectLogout);
		// }
		// else
		// {
		// 	createItem('login', selectLogin);
		// }
		createItem('exit', exit);
	}

	public function createItem(label:String, callback:Dynamic, ?fireInstantly:Bool = false)
	{
		var item:TextMenuItem = items.createItem(0, 100 + 100 * items.length, label, Bold, callback);
		item.fireInstantly = fireInstantly;
		item.screenCenter(X);
		return item;
	}

	override function set_enabled(state:Bool)
	{
		items.enabled = state;
		return super.set_enabled(state);
	}

	public function hasMultipleOptions()
	{
		return items.length > 2;
	}

	function selectDiscord()
	{
		#if linux
		Sys.command('/usr/bin/xdg-open', ["https://ninja-muffin24.itch.io/funkin", "&"]);
		#else
		FlxG.openURL('https://ninja-muffin24.itch.io/funkin');
		#end
	}
}
