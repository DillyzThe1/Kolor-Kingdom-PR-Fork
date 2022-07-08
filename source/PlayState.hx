package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:Player;

	override public function create()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.5, true);

		player = new Player(0, 0);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
