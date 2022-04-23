package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import Config;
import ui.FlxVirtualPad;

import flixel.util.FlxSave;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var _pad:FlxVirtualPad;

	var UP_P:Bool;
	var DOWN_P:Bool;
	var BACK:Bool;
	var ACCEPT:Bool;

	private var grpControls:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = ['preferences', 'controls', 'discord', 'credits', 'about', 'exit'];

	var notice:FlxText;

	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
		//controlsStrings = CoolUtil.coolTextFile('assets/data/controls.txt');
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...menuItems.length)
		{ 
			var controlLabel:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			controlLabel.screenCenter();
			controlLabel.y = (100 * i) + 70;
			//controlLabel.isMenuItem = true;
			//controlLabel.targetY = i;
			grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}

		_pad = new FlxVirtualPad(UP_DOWN, A_B);
		_pad.alpha = 0.75;
		this.add(_pad);

		changeSelection();
		
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (controls.ACCEPT)
		{
			var daSelected:String = menuItems[curSelected];

			switch (daSelected)
			{
				case "preferences":
					FlxG.switchState(new options.PreferencesMenu());
				case "controls":
					FlxG.switchState(new options.CustomControlsState());
				case "discord":
					FlxG.openURL('https://discord.gg/eGwJnUvZ9H');
				case "credits":
					FlxG.switchState(new options.CreditsState());
				case "about":
					FlxG.switchState(new options.AboutState());
				case "exit":
					FlxG.switchState(new MainMenuState());
			}
		}


		}

		if (controls.UP_P)
		{
			changeSelection(-1);
		}
		if (controls.DOWN_P)
		{
			changeSelection(1);
		}
			
		#if android
		BACK = _pad.buttonB.justPressed || FlxG.android.justReleased.BACK;
		#else
		BACK = _pad.buttonB.justPressed;
		#end
			
		ACCEPT = _pad.buttonA.justReleased;
	}

	function changeSelection(change:Int = 0)
	{
			UP_P = _pad.buttonUp.justReleased;
			DOWN_P = _pad.buttonDown.justReleased;

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}

	override function closeSubState()
		{
			super.closeSubState();
		}	
}
