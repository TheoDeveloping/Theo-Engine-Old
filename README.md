# Friday Night Funkin' Theo Engine
This Engine Promises Better Gameplay And Customization For A Better Gaming Experience, Adding Downscroll, Ghost Tapping (Coming Soon), And More!, This Engine Is Inspired By [Kade Engine](https://github.com/KadeDev/Kade-Engine) And [Psych Engine](https://github.com/ShadowMario/FNF-PsychEngine).
![alt text](https://github.com/TheoPortz/Theo-Engine/blob/master/theoEngineLogo.png?raw=true)

# Modding Instructions
If You Want To Mod Friday Night Funkin', Here Are The Instructions :
First you need to install Haxe and HaxeFlixel. I'm too lazy to write and keep updated with that setup (which is pretty simple)

1. [Install Haxe 4.1.5](https://haxe.org/download/version/4.1.5/) (Download 4.1.5 instead of 4.2.0 because 4.2.0 is broken and is not working with gits properly...)

2. [Install HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/) after downloading Haxe

Other installations you'd need is the additional libraries, a fully updated list will be in `Project.xml` in the project root. Currently, these are all of the things you need to install:
```
flixel
flixel-addons
flixel-ui
hscript
```

So for each of those type `haxelib install [library]` so shit like `haxelib install flixel`

You'll also need to install a couple things that involve Gits. To do this, you need to do a few things first.

1. Download [git-scm](https://git-scm.com/downloads). Works for Windows, Mac, and Linux, just select your build.

2. Follow instructions to install the application properly.

3. Run `haxelib git polymod https://github.com/larsiusprime/polymod.git` to install Polymod.

4. Run `haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc` to install Discord RPC.

At the moment, you can optionally fix some bugs regarding the engine:

1. A transition bug in songs with zoomed out cameras

- Run `haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons` in the terminal/command-prompt.

2. A text rendering bug (mainly noticeable in the story menu under tracks)

- Run `haxelib git openfl https://github.com/openfl/openfl` in the terminal/command-prompt.

- Read More Of Building Game In [Friday Night Funkin' Official Source Code](https://github.com/ninjamuffin99/Funkin)

- Read More Of Android Building Game In [Friday Night Funkin' Android Source Code](https://github.com/luckydog7/Funkin-android)

## Credits

- [NinjaMuffin99](https://twitter.com/ninja_muffin99) - Programmer
- [PhantomArcade](https://twitter.com/phantomarcade3k) and [Evilsk8r](https://twitter.com/evilsk8r) - Artist
- [KawaiSprite](https://twitter.com/kawaisprite) - Musician
- [TheoDev](https://github.com/TheoPortz) - Theo Engine Developer
- [EstoyAburridow](https://twitter.com/EstoyAburridop) - Time Bar Creator
- [ElArabe98](https://www.youtube.com/channel/UCi_xw_cLbN_T6xoFYqKlAeA) - Logo Bumpin Animator
- [TwinGamerGuys](https://youtube.com/channel/UCadEWq_aCTBqD05iGgZfhiQ) - Code Helper

• Thanks Guys!!