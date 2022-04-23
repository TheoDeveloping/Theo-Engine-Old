package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import ui.FlxVirtualPad;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];

	private static var creditsStuff:Array<Dynamic> = [ //Name - Icon name - Description - Link - BG Color
		['FnF Android Team'],
		['LuckyDog', 'luckydog', 'Original FnF Android Creator', 'https://twitter.com/Shadow_Mario_', 0xFFFFDD33],
		['ZacksGamerz', 'zack', 'v.0.2.8 Coder', 'https://twitter.com/Shadow_Mario_', 0xFFFFDD33],
		['Theo Engine Team'],
		['ThesPorts', 'theo', 'Programmer Of Theo Engine',	 'https://twitter.com/river_oaken',	0xFFC30085],
		['EstoyAburridow', 'aburridow', 'Code Helper', 'https://twitter.com/river_oaken', 0xFFC30085],
		['ElArabe98', 'arabe', 'Logo Bumpin Creator', 'https://twitter.com/river_oaken', 0xFFC30085],
		["Funkin Crew"],
		['NinjaMuffin99', 'muffin', "Programmer Of Friday Night Funkin'", 'https://twitter.com/ninja_muffin99',	0xFFF73838],
		['PhantomArcade', 'phantom', "Animator Of Friday Night Funkin'", 'https://twitter.com/PhantomArcade3K',	0xFFFFBB1B],
		['EvilSk8r', 'evil', "Artist Of Friday Night Funkin'", 'https://twitter.com/evilsk8r', 0xFF53E52C],
		['KawaiSprite', 'kawaii', "Composer Of Friday Night Funkin'", 'https://twitter.com/kawaisprite', 0xFF6475F3]
	];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;

	var _pad:FlxVirtualPad;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.x = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		bg.color = creditsStuff[curSelected][4];
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	override function update(elapsed:Float)
	{
		FlxG.sound.playMusic(Paths.music('creditSong'), 0);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (controls.UP_P)
			changeSelection(-1);
		if (controls.DOWN_P)
			changeSelection(1);

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.switchState(new MainMenuState());
		}
		if (controls.ACCEPT) {
			CoolUtil.browserLoad(creditsStuff[curSelected][3]);
		}
			#if mobileC
			addVirtualPad(UP_DOWN, A_B);
			#end

			_pad = new FlxVirtualPad(UP_DOWN, A_B);
			_pad.alpha = 0.75;
			this.add(_pad);

		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int = creditsStuff[curSelected][4];
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});

			var UP_P = _pad.buttonUp.justPressed;
			var DOWN_P = _pad.buttonDown.justPressed;
	
			var ACCEPT = _pad.buttonA.justPressed;
			var BACK = _pad.buttonB.justPressed;
	
			#if android
				var BACK = _pad.buttonB.justPressed || FlxG.android.justReleased.BACK;
			#end
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}
		descText.text = creditsStuff[curSelected][2];
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
