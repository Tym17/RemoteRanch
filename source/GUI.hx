package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class GUI extends FlxTypedGroup<FlxSprite>
{

	private var _nP:FlxText;
	private var _nR:FlxText;
	private var _score:FlxText;
	
	public function new()
	{
		super();
		_nP = new FlxText(10, FlxG.height - 32, 0, "Player's food: 0", 11);
		_nP.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		add(_nP);
		_nR = new FlxText(10, FlxG.height - 16, 0, "Robot's food: 0", 11);
		_nR.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		add(_nR);
		_score = new FlxText(4, FlxG.height - 56, 0, "Score: 0", 16);
		_score.setBorderStyle(SHADOW, FlxColor.GRAY, 2, 1);
		add(_score);
		
		forEach(function (spr:FlxSprite)
		{
			spr.scrollFactor.set(0, 0);
		});
	}
	
	public function updateGUI(nRobot:Int, nPlayer:Int, score:Int)
	{
		_nR.text = "Robot's food: " + Std.string(nRobot);
		_nP.text = "Player's food: " + Std.string(nPlayer);
		_score.text = "Score: " + Std.string(score);
	}
	
}