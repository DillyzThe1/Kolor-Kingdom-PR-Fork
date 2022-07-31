package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

enum ButtonSide
{
	LEFT;
	RIGHT;
	UP;
	DOWN;
}

class MenuButton extends KKSprite
{
	var buttonSide:ButtonSide;

	public var selected:Bool = false;
	public var confirmed:Bool = false;
	public var tweening:Bool = false;

	var tween:FlxTween;
	var ogX:Float;
	var ogY:Float;

	public var globalType:String;

	var buttonEnabled:Bool;

	override public function new(x:Float, y:Float, type:String, ?buttonSide:ButtonSide = ButtonSide.LEFT, ?buttonEnabled:Bool = true)
	{
		super(x, y, 'buttons', true);

		ogX = this.x;
		ogY = this.y;
		globalType = type;
		this.buttonEnabled = buttonEnabled;
		alpha = buttonEnabled ? 1 : 0.7;
		this.buttonSide = buttonSide;

		this.addAnim("start", "start idle", new FlxPoint(0, 0), 24, true);
		this.addAnim("startConfirm", "start confirm", new FlxPoint(0, 8));
		this.addAnim("options", "options idle", new FlxPoint(0, 0), 24, true);
		this.addAnim("multiplayer", "multiplayer idle", new FlxPoint(0, 0), 24, true);
		this.addAnim("achievements", "achievements idle", new FlxPoint(0, 0), 24, true);
		this.addAnim("quit", "quit idle", new FlxPoint(0, 0), 24, true);
		this.addAnim("quitConfirm", "quit confirm", new FlxPoint(10, 40));

		this.playAnim(type, true);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if ((!confirmed || !tweening) && buttonEnabled)
		{
			if (FlxG.mouse.overlaps(this) && !selected)
			{
				FlxG.sound.play(LazyPathStuff.soundPath("buttonHover.ogg"));

				selected = true;
				if (tween != null)
					tween.cancel();

				switch (buttonSide)
				{
					case ButtonSide.LEFT:
						tween = FlxTween.tween(this, {x: ogX + 20}, 0.2, {ease: FlxEase.cubeInOut});
					case ButtonSide.RIGHT:
						tween = FlxTween.tween(this, {x: ogX - 20}, 0.2, {ease: FlxEase.cubeInOut});
					case ButtonSide.DOWN:
						tween = FlxTween.tween(this, {y: ogY - 20}, 0.2, {ease: FlxEase.cubeInOut});
					case ButtonSide.UP:
						tween = FlxTween.tween(this, {y: ogY + 20}, 0.2, {ease: FlxEase.cubeInOut});
				}
			}
			else if (!FlxG.mouse.overlaps(this) && selected)
			{
				FlxG.sound.play(LazyPathStuff.soundPath("buttonDeselect.ogg"));

				selected = false;
				if (tween != null)
					tween.cancel();

				switch (buttonSide)
				{
					case ButtonSide.LEFT | ButtonSide.RIGHT:
						tween = FlxTween.tween(this, {x: ogX}, 0.2, {ease: FlxEase.cubeInOut});
					case ButtonSide.DOWN | ButtonSide.UP:
						tween = FlxTween.tween(this, {y: ogY}, 0.2, {ease: FlxEase.cubeInOut});
				}
			}
		}
	}

	public function clicked()
	{
		if (buttonEnabled)
		{
			confirmed = true;
			this.animation.play('${globalType}Confirm');

			FlxG.sound.play(LazyPathStuff.soundPath("buttonConfirm.ogg"));
			var clickedTimer:FlxTimer = new FlxTimer();
			clickedTimer.start(1, function(time:FlxTimer)
			{
				switch (globalType.toLowerCase())
				{
					#if (desktop && cpp)
					case 'quit':
						Sys.exit(0);
					#end
					case 'start':
						FadeManager.fadeAndSwitchState(PlayState);
					default:
						trace('WARNING: You need to add a switch case in MenuButton.hx for ${globalType.toLowerCase()}!');
				}
			}, 0);
			return true;
		}
		return false;
	}
}
