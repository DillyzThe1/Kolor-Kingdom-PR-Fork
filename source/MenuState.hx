package;

import KKSprite;
import MenuButton.ButtonSide;
import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class MenuState extends KKState
{
	var logo:KKSprite;
	var play:MenuButton;
	var options:MenuButton;
	var multiplayer:MenuButton;
	var achievements:MenuButton;
	#if (desktop && cpp)
	var quit:MenuButton;
	#end

	var buttons:Array<MenuButton>;

	override public function create()
	{
		super.create();

		FlxG.camera.bgColor = FlxColor.WHITE;

		play = new MenuButton(-100, 0, "start", ButtonSide.LEFT);
		add(play);

		options = new MenuButton(980, 0, "options", ButtonSide.RIGHT, false);
		add(options);

		multiplayer = new MenuButton(-100, 0, "multiplayer", ButtonSide.LEFT, false);
		add(multiplayer);

		achievements = new MenuButton(920, 0, "achievements", ButtonSide.RIGHT, false);
		add(achievements);

		#if (desktop && cpp)
		quit = new MenuButton(0, 620, "quit", ButtonSide.DOWN);
		quit.screenCenter(X);
		quit.x += 70;
		add(quit);
		#end

		logo = new KKSprite(0, 10, "logo", true);
		logo.screenCenter(X);
		logo.addAnim("idle", "real logo", new FlxPoint(0, 0), 24, true);
		logo.playAnim("idle");
		add(logo);

		play.y = logo.y + 265;
		options.y = play.y + 85;
		multiplayer.y = options.y + 85;
		achievements.y = multiplayer.y + 85;

		buttons = [play, options, multiplayer, achievements, #if (desktop && cpp) quit #end];

		trace(FlxNerd.nerd("momazos diego"));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music == null)
			FlxG.sound.playMusic(LazyPathStuff.songPath("funny game menu.ogg"));

		if (FlxG.mouse.justPressed)
			for (i in buttons)
				if (i.selected && !i.confirmed && i.clicked())
					tweenButtons(i);

		#if debug
		if (FlxG.keys.justPressed.NINE)
			FadeManager.fadeAndSwitchState(OffsetState);
		// FlxG.switchState(new OffsetState());
		#end
	}

	public function tweenButtons(type:MenuButton)
	{
		trace(FlxNerd.nerd(type.globalType));

		if (!type.confirmed)
			type.tweening = true;

		if (type != play)
			FlxTween.tween(play, {x: play.x - 500}, 0.5, {ease: FlxEase.backIn});
		if (type != options)
			FlxTween.tween(options, {x: options.x + 500}, 0.5, {ease: FlxEase.backIn});
		if (type != multiplayer)
			FlxTween.tween(multiplayer, {x: multiplayer.x - 500}, 0.5, {ease: FlxEase.backIn});
		if (type != achievements)
			FlxTween.tween(achievements, {x: achievements.x + 500}, 0.5, {ease: FlxEase.backIn});
		#if (desktop && cpp)
		if (type != quit)
			FlxTween.tween(quit, {y: quit.y + 500}, 0.5, {ease: FlxEase.backIn});
		#end
	}
}
