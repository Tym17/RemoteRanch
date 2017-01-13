package;

import Player;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.editors.tiled.TiledMap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var pl:Player;
	private var rb:Robot;
	
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	private var _deco1:FlxTilemap;
	private var _deco2:FlxTilemap;
	private var _camBot:FlxCamera;
	private var _ui:GUI;
	private var cooldown:Float = 0;
	
	private var _ar_up:Trigger;
	private var _ar_down:Trigger;
	private var _ar_right:Trigger;
	private var _ar_left:Trigger;
	private var throwit:Trigger;
	private var throwin:Trigger;
	private var _triggerGroup:FlxTypedGroup<Trigger>;
	private var _seeds:FlxTypedGroup<Soil>;
	private var _dropped:FlxTypedGroup<DroppedFood>;
	private var _blob:Blob;
	
	private static var spawnX:Int = 0;
	private static var spawnY:Int = 0;
	
	private static var _playerFood:Int = 0;

	private static var _robotFood:Int = 0;
	
	private static var _score:Int = 0;

	public function new(levelData:Dynamic)
	{
		super();
		_map = new FlxOgmoLoader(levelData);
	}
	
	override public function create():Void
	{
		_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 16, 16, "walls");
		_deco1 = _map.loadTilemap(AssetPaths.tilesheet_complete__png, 64, 64, "deco1");
		add(_deco1);
		_deco2 = _map.loadTilemap(AssetPaths.tilesheet_complete__png, 64, 64, "deco2");
		add(_deco2);
		//add(_mWalls);
		_mWalls.follow();
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.ANY);
		_triggerGroup = new FlxTypedGroup<Trigger>();
		_dropped = new FlxTypedGroup<DroppedFood>();
		_seeds = new FlxTypedGroup<Soil>();
		add(_seeds);
		_blob = new Blob(0, 0);
		
		pl = new Player(0, 0);
		rb = new Robot(0, 0);
		add(pl);
		add(rb);
		FlxG.camera.follow(pl , TOPDOWN, 1);
		_camBot = new FlxCamera(FlxG.width - 200, FlxG.height - 160, 200, 160);
		_camBot.follow(rb);
		_ui = new GUI();
		_camBot.color = FlxColor.GREEN;
		FlxG.cameras.add(_camBot);
		add(_blob);
		add(_ui);
		
		_ar_up = new Trigger(AssetPaths.ar_up__png);
		add(_ar_up);
		_triggerGroup.add(_ar_up);
		_ar_down = new Trigger(AssetPaths.ar_down__png);
		add(_ar_down);
		_triggerGroup.add(_ar_down);
		_ar_left = new Trigger(AssetPaths.ar_left__png);
		add(_ar_left);
		_triggerGroup.add(_ar_left);
		_ar_right = new Trigger(AssetPaths.ar_right__png);
		add(_ar_right);
		_triggerGroup.add(_ar_right);
		throwit = new Trigger(AssetPaths.eject__png);
		add(throwit);
		_triggerGroup.add(throwit);
		throwin = new Trigger(AssetPaths.inject__png);
		add(throwin);
		_triggerGroup.add(throwin);
		add(_dropped);
		
		rb.up = _ar_up;
		rb.down = _ar_down;
		rb.left = _ar_left;
		rb.right = _ar_right;
		
		_map.loadEntities(entityLoading, "entities");
		super.create();
	}
	
	private function entityLoading(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player")
		{
			pl.x = x;
			pl.y = y;
		}
		if (entityName == "robot")
		{
			rb.x = x;
			rb.y = y;
		}
		if (entityName == "ar_up")
		{
			_ar_up.x = x;
			_ar_up.y = y;
		}
		if (entityName == "ar_down")
		{
			_ar_down.x = x;
			_ar_down.y = y;
		}
		if (entityName == "ar_left")
		{
			_ar_left.x = x;
			_ar_left.y = y;
		}
		if (entityName == "ar_right")
		{
			_ar_right.x = x;
			_ar_right.y = y;
		}
		if (entityName == "throw")
		{
			throwit.x = x;
			throwit.y = y;
		}
		if (entityName == "soil")
		{
			_seeds.add(new Soil(x, y));
		}
		if (entityName == "holeOut")
		{
			spawnX = x;
			spawnY = y;
		}
		if (entityName == "holeIn")
		{
			throwin.x = x;
			throwin.y = y;
		}
		if (entityName == "animalSpawn")
		{
			_blob.x = x;
			_blob.y = y;
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		FlxG.collide(pl, _mWalls);
		FlxG.collide(_blob, _mWalls);
		FlxG.collide(rb, _mWalls);
		FlxG.overlap(pl, _triggerGroup, function (P:Player, T:Trigger) {
			if (P.exists && P.isInteracting)
			{
				T.trigger();
			}
		});
		FlxG.overlap(_blob, _dropped, function (B:Blob, D:DroppedFood) {
			if (D.alive && D.exists)
			{
				D.kill();
				PlayState._score += 20;
			}
		});
		FlxG.overlap(pl, _seeds, function (P:Player, F:Soil) {
			if (P.isInteracting && F.grown)
			{
				F.cut();
				PlayState._score += 1;
				PlayState._playerFood += 1;
			}
		});
		FlxG.overlap(rb, _dropped, function (R:Robot, D:DroppedFood) {
			if (D.alive)
			{
				PlayState._robotFood += 1;
				D.kill();
			}
		});
		cooldown += elapsed;

		if (throwin.triggered)
		{
			if (_playerFood > 0 && cooldown > 0.5)
			{
				_playerFood -= 1;
				cooldown = 0;
				_dropped.add(new DroppedFood(spawnX, spawnY));
			}
			
		}
		else if (throwit.triggered)
		{
			if (cooldown > 0.5 && _robotFood > 0)
			{
				_dropped.add(new DroppedFood(rb.x + 50, rb.y));
				_robotFood -= 1;
				cooldown = 0;
			}
		}
		else 
			cooldown = 0;
		_ui.updateGUI(_robotFood, _playerFood, _score);
	}
}
