package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author 
 */
class Player extends FlxSprite 
{
	private var _speed:Float = 300;
	private var _rotTimer:Float;
	private var _maxTimer:Float = 0.1;
	public var isInteracting:Bool = false;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.pl__png, true, 37, 43);
		animation.add("n", [1]);
		animation.add("h", [0]);
		drag.x = drag.y = 1000;
		_rotTimer = _maxTimer;
	}
	
	override public function update(elapsed:Float):Void
	{
		checkMoves(elapsed);
		makeRotation(elapsed);
		super.update(elapsed);
	}
	
	private function makeRotation(elapsed:Float):Void
	{
		
		
		angle = Std.int(Math.atan2(FlxG.mouse.getWorldPosition().y - y, FlxG.mouse.getWorldPosition().x - x) * 180 / Math.PI);
		if (FlxG.keys.anyPressed([SPACE, E]) || FlxG.mouse.pressed)
		{
			animation.play("h");
			_rotTimer = 0;
			isInteracting = true;
		}
		else if (_rotTimer < _maxTimer)
		{
			animation.play("h");
			_rotTimer += elapsed;
			isInteracting = true;
		}
		else
		{
			animation.play("n");
			isInteracting = false;
		}
	}
	
	private function checkMoves(elapsed:Float):Void
	{
		var _up:Bool = FlxG.keys.anyPressed([Z, UP, W]);
		var _down:Bool = FlxG.keys.anyPressed([S, DOWN]);
		var _right:Bool = FlxG.keys.anyPressed([RIGHT, D]);
		var _left:Bool = FlxG.keys.anyPressed([Q, A, LEFT]);
		
		var _angle:Float = 0;
		if (_up || _down || _right || _left)
		{
			if (_up)
			{
				_angle = -90;
				if (_left)
					_angle -= 45;	
				else if (_right)
					_angle += 45;
			}
			else if (_down)
			{
				_angle = 90;
				if (_left)
					_angle += 45;	
				else if (_right)
					_angle -= 45;
			}
			else if (_left)
				_angle = 180;
			else if (_right)
				_angle = 0;
			velocity.set(_speed, 0);
			velocity.rotate(FlxPoint.weak(0, 0), _angle);
		}
		
	}
	
}