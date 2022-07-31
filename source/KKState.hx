import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxColor;

class KKState extends FlxState
{
	override public function create()
	{
		super.create();
		if (FadeManager.nextFadeIn)
			FlxG.camera.fade(FlxColor.BLACK, FadeManager.nextFadeDuration, true);
		FadeManager.nextFadeIn = false;
	}
}
