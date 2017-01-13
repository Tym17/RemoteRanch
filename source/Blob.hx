package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class Blob extends FlxSprite 
{
	private var _idleTmr:Float = 4;

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.blob__png, true, 32, 32);
		animation.add("all", [0, 1, 2, 3]);
		drag.x = drag.y = 5;
	}
	
	override public function update(elapsed:Float)
	{
		animation.play("all");
		super.update(elapsed);
		var _moveDir:Int;
		if (_idleTmr <= 0)
		{
			if (FlxG.random.bool(1))
			{
				_moveDir = -1;
				velocity.x = velocity.y = 0;
			}
			else
			{
				_moveDir = FlxG.random.int(0, 8) * 45;
	
				velocity.set(200 * 0.5, 0);
				velocity.rotate(FlxPoint.weak(), _moveDir);
	
			}
			_idleTmr = FlxG.random.int(1, 4);            
		}
		else
			_idleTmr -= elapsed;
	}
}