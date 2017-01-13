package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class MenuState extends FlxState
{
	private var playBtn:FlxButton;
	
	override public function create():Void
	{
		playBtn = new FlxButton(FlxG.width - 200, 20, "Play now", function () { FlxG.switchState(new PlayState(AssetPaths.testroom__oel)); });
		
		add(new FlxSprite(0, 0, AssetPaths.menu__png));
		add(playBtn);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
