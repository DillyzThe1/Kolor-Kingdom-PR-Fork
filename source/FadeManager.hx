package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

class FadeManager
{
	public static var nextFadeIn:Bool = false;
	public static var nextFadeDuration:Float = 0.5;
	public static var nextFadeColor:FlxColor = FlxColor.BLACK;

	public static function fadeAndSwitchState(newState:Class<FlxState>, ?color:FlxColor = FlxColor.BLACK, ?duration:Float = 0.5)
	{
		nextFadeIn = true;
		nextFadeDuration = duration;
		nextFadeColor = color;
		FlxG.camera.fade(nextFadeColor, nextFadeDuration, false, function()
		{
			FlxG.switchState(Type.createInstance(newState, []));
		});
	}
}
