package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author 
 */
class Robot extends FlxSprite 
{

	private var _speed:Float = 175;
	private var _rotTimer:Float;
	private var _maxTimer:Float = 0.1;
	public var isInteracting:Bool = false;
	
	public var down:Trigger;
	public var up:Trigger;
	public var left:Trigger;
	public var right:Trigger;
	public var throwit:Trigger;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.robot__png, true, 37, 43);
		animation.add("n", [1]);
		animation.add("h", [0]);
		drag.x = drag.y = 3000;
		_rotTimer = _maxTimer;
	}
	
	override public function update(elapsed:Float):Void
	{
		animation.play("n");
		super.update(elapsed);
		if (down.triggered || up.triggered || left.triggered ||	right.triggered)
		{
			var _angle:Int = 0;
			if (down.triggered)
				_angle = 90;
			else if (up.triggered)
				_angle = -90;
			else if (left.triggered)
				_angle = 180;
			velocity.set(_speed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), _angle);
			angle = _angle;
		}
	}
	
}