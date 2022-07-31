package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends KKState
{
	var player:Player;

	override public function create()
	{
		super.create();
		player = new Player(0, 0);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE)
			FadeManager.fadeAndSwitchState(MenuState);
	}
}
