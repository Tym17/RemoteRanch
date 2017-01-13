package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class Trigger extends FlxSprite 
{

	public var triggered:Bool = false;
	
	private var Actimer:Float;
	
	public function new(mage:Dynamic) 
	{
		super(0, 0);
		loadGraphic(mage, true, 64, 64);
		animation.add("n", [0]);
		animation.add("y", [1]);
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (Actimer < 0.1)
		{
			Actimer += elapsed;
			active = true;
			animation.play("y");
		}
		else
		{
			triggered = false;
			animation.play("n");
		}
	}
	
	public function trigger():Void
	{
		Actimer = 0;
		triggered = true;
	}
	
}