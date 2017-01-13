package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class DroppedFood extends FlxSprite 
{

	private var timertimer:Float = 0;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.food__png, false, 64, 64);
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		timertimer += elapsed;
		if (timertimer > 8)
			kill();
	}
	
}