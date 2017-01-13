package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class Soil extends FlxSprite 
{

	private var growth:Float = 0;
	public var grown:Bool = true;
	private var timetoG:Float = 3;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.soil__png, true, 64, 64);
		animation.add("g", [0]);
		animation.add("s", [1]);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (grown)
		{
			animation.play("g");
		}
		else
		{
			animation.play("s");
			if (growth < timetoG)
			{
				growth += elapsed;
			}
			else
			{
				grown = true;
			}
		}
	}
	
	
	public function cut():Void
	{
		grown = false;
		growth = 0;
		timetoG = 10 + Math.random() * 22;
	}
}