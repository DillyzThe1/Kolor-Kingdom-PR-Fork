package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class MenuState extends FlxState
{
	var logo:FlxSprite;
	var play:MenuButton;
	var options:MenuButton;
	var multiplayer:MenuButton;
	var achievements:MenuButton;
	var quit:MenuButton;

	override public function create()
	{
		FlxG.camera.bgColor = FlxColor.WHITE;

		play = new MenuButton(-60, 0, "start");
		add(play);

		options = new MenuButton(1010, 0, "options");
		add(options);

		multiplayer = new MenuButton(-30, 0, "multiplayer");
		add(multiplayer);

		achievements = new MenuButton(970, 0, "achievements");
		add(achievements);

		quit = new MenuButton(0, 650, "quit");
		quit.screenCenter(X);
		add(quit);

		logo = new FlxSprite(0, 10);
		logo.frames = LazyPathStuff.getXml("logo");
		logo.screenCenter(X);
		logo.animation.addByPrefix("idle", "real logo", 24, true);
		logo.animation.play("idle");
		add(logo);

		play.y = logo.y + 265;
		options.y = play.y + 85;
		multiplayer.y = options.y + 85;
		achievements.y = multiplayer.y + 85;

		trace(FlxNerd.nerd("momazos diego"));

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music == null)
			FlxG.sound.playMusic(LazyPathStuff.songPath("funny game menu.ogg"));

		if (FlxG.mouse.justPressed)
		{
			var buttons = [play, options, multiplayer, achievements, quit];

			for (i in buttons)
			{
				if (i.selected)
				{
					i.clicked();
					tweenButtons(i);
				}
			}
		}
	}

	public function tweenButtons(type:MenuButton)
	{
		trace(FlxNerd.nerd(type.globalType));

		if (type != play)
			FlxTween.tween(play, {x: play.x - 100}, 0.5, {ease: FlxEase.backOut});
		if (type != options)
			FlxTween.tween(options, {x: options.x + 100}, 0.5, {ease: FlxEase.backOut});
		if (type != multiplayer)
			FlxTween.tween(multiplayer, {x: multiplayer.x - 100}, 0.5, {ease: FlxEase.backOut});
		if (type != achievements)
			FlxTween.tween(achievements, {x: achievements.x + 100}, 0.5, {ease: FlxEase.backOut});
		if (type != quit)
			FlxTween.tween(quit, {y: quit.y + 100}, 0.5, {ease: FlxEase.backOut});
	}
}
