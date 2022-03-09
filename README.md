# 007: Nightfire (GameCube) On-screen timer
![Gameplay Screenshot](https://cdn.discordapp.com/attachments/807451828002095175/817801194621239296/unknown.png)

## How to Use:

1) Download the latest version of [Dolphin 5.0 Lua Core](https://github.com/SwareJonge/Dolphin-Lua-Core)
2) Download this script and place it in the "Scripts" folder (Sys > Scripts)
3) Start running the North American version of 007: Nightfire in the emulator
4) While the game is running, go to Tools > Execute Script
5) Find "NightfireTimer.lua" in the drop-down list and click "Start"

The timer will only display when you're in a level. It doesn't do anything in the menus.
Once you go into a stage, you should see the in-game timer at the top corner of the screen.

If you get an error message saying something about not being able to read an address, go to config > Interface and disable "Use Panic Handlers."

## Known Issues:

The timer is totally inaccurate for Island Infiltration once you get past the first section where you're driving through the jungle. The reason is because the loading screens add on a seemingly random amount of time for no obvious reason. It's accurate for all the other driving levels, at least. I believe I'm looking at the wrong memory address here but I couldn't find a better one.

There is no support for the PAL version of the game. The memory addresses would have to be updated to work for that version.
