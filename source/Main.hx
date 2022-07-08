package;

import flixel.FlxGame;
import flixel.FlxState;
import flixel.util.FlxColor;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	// taken from dillyz's game :thubm_ip:
	public static var initialState:Class<FlxState> = #if debug MenuState #else PlayState #end;
	public static var frameRate:Int = #if desktop 120 #else 60 #end;

	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, initialState, 1, frameRate, frameRate, true, false));
		addChild(new FPS(0, 0, FlxColor.BLACK));
	}
}
