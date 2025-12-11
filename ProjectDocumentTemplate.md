# Revenge of Zissors #

## Summary ##

**A paragraph-length pitch for your game.**

## Project Resources

[Web-playable version of your game.](https://itch.io/)  
[Trailor](https://youtube.com)  
[Press Kit](https://dopresskit.com/)  
[Proposal: make your own copy of the linked doc.](https://docs.google.com/document/d/1qwWCpMwKJGOLQ-rRJt8G8zisCa2XHFhv6zSWars0eWM/edit?usp=sharing)  

## Gameplay Explanation ##

**In this section, explain how the game should be played. Treat this as a manual within a game. Explaining the button mappings and the most optimal gameplay strategy is encouraged.**


**Add it here if you did work that should be factored into your grade but does not fit easily into the proscribed roles! Please include links to resources and descriptions of game-related material that does not fit into roles here.**

# External Code, Ideas, and Structure #

If your project contains code that: 1) your team did not write, and 2) does not fit cleanly into a role, please document it in this section. Please include the author of the code, where to find the code, and note which scripts, folders, or other files that comprise the external contribution. Additionally, include the license for the external code that permits you to use it. You do not need to include the license for code provided by the instruction team.

If you used tutorials or other intellectual guidance to create aspects of your project, include reference to that information as well.

# Team Member Contributions

This section be repeated once for each team member. Each team member should provide their name and GitHub user information.

The general structures is 
```
Team Member 1
  Main Role
    Documentation for main role.
  Sub-Role
    Documentation for Sub-Role
  Other contribtions
    Documentation for contributions to the project outside of the main and sub roles.

Team Member 2
  Main Role
    Documentation for main role.
  Sub-Role
    Documentation for Sub-Role
  Other contribtions
    Documentation for contributions to the project outside of the main and sub roles.
...
```

For each team member, you shoudl work of your role and sub-role in terms of the content of the course. Please look at the role sections below for specific instructions for each role.

Below is a template for you to highlight items of your work. These provide the evidence needed for your work to be evaluated. Try to have at least four such descriptions. They will be assessed on the quality of the underlying system and how they are linked to course content. 

*Short Description* - Long description of your work item that includes how it is relevant to topics discussed in class. [link to evidence in your repository](https://github.com/dr-jam/ECS189L/edit/project-description/ProjectDocumentTemplate.md)

Here is an example:  
*Procedural Terrain* - The game's background consists of procedurally generated terrain produced with Perlin noise. The game can modify this terrain at run-time via a call to its script methods. The intent is to allow the player to modify the terrain. This system is based on the component design pattern and the procedural content generation portions of the course. [The PCG terrain generation script](https://github.com/dr-jam/CameraControlExercise/blob/513b927e87fc686fe627bf7d4ff6ff841cf34e9f/Obscura/Assets/Scripts/TerrainGenerator.cs#L6).

You should replay any **bold text** with your relevant information. Liberally use the template when necessary and appropriate.

Add addition contributions int he Other Contributions section.

# Team Member 1

## Main Roles ##

## Sub-Roles ##

## Other Contributions ##
**Document what you added to and how you tweaked your game to improve its game feel.**

# Team Member 2

## Main Roles ##

## Sub-Roles ##

## Other Contributions ##
**Document what you added to and how you tweaked your game to improve its game feel.**

# Team Member 3

## Main Roles ##

## Sub-Roles ##

## Other Contributions ##
**Document what you added to and how you tweaked your game to improve its game feel.**

# Team Member 4

## Main Roles ##

## Sub-Roles ##

## Other Contributions ##
**Document what you added to and how you tweaked your game to improve its game feel.**

# Team Member 5: Patrick Wang (Github: Chunkio)

## Main Roles: UI and Input ##
I made all the menus and screens for the game, and set up how players control their character.

UI Manager System - Created a UI manager that controls all the different menus and screens in one place. This includes the pause menu, title screen, health bar, and hotbar. The manager keeps everything organized and makes it easy to show or hide different UI elements when needed. https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/hud.gd

Pause Menu System - Made a pause screen that stops the game. It has two buttons: one to resume playing and one to go back to the main menu. The game freezes when you pause but the buttons still work. https://github.com/martellharuki/ECS179FinalProject/blob/main/scripts/pause_screen.gd

Main Menu - Created the title screen with three buttons: Start Game, How to Play, and Quit. This is the first thing players see when they open the game. Each button works and takes you to the right place. https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/title_screen.gd

Health Bar - Built the HP bar that shows the player's health. It updates whenever the player takes damage so you can always see how much health you have left. The bar shrinks as you lose health. https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/health_bar.gd

Player Controls - Set up the basic WASD movement controls so players can move around in the game. https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/player/player.gd

## Sub-Roles: Accessibility and Usability Design	 ##
I worked on making the game easier to use and test.

Testing Buttons - Made special testing buttons (heal, damage, instant win) so we could quickly check if the UI was working right without having to play through the whole game. This made it way faster to test if things looked correct. 
https://github.com/martellharuki/ECS179FinalProject/blob/fc74ab76b2a36d901162826293c1c640809269a2/Scripts/player/player.gd#L96-L98


Hotbar UI - Created the hotbar interface that shows at the bottom of the screen.

Win and Lose Screens - Made the screens that show up when you beat the boss or die. Also made an objective screen that appears right after you start the game and tells you to survive. https://github.com/martellharuki/ECS179FinalProject/blob/main/Scenes/lose_screen.tscn
https://github.com/martellharuki/ECS179FinalProject/blob/main/Scenes/win_screen.tscn
https://github.com/martellharuki/ECS179FinalProject/blob/main/Scenes/objective_screen.tscn
https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/win_screen.gd
https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/lose_screen.gd
https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/objective_screen.gd

Score System - Added a score counter in HUD.gd that tracks how many enemies you kill. The score shows up on the win/lose screens at the end so you can see how well you did. 

## Other Contributions ##
Visual Setup - Helped put the visual parts of the UI together, like placing the title image, adding the background to the title screen, and putting button icons in the right spots.

Removed Features - Made an inventory screen and script but ended up removing it because it made the game too complicated.

# Team Member 6: Kaylie Lam (Github: Kalam721)

## Main Role: Level and World Designer ##
I originally wanted to create a small town set in the modern day. The town would have been an old mining town that is run down and long abandoned by the time the player is in town. The town would have been the central part of the map. But I also drafted areas connected to the town so that those areas' borders like cliffs and the sea served as a natural border on the overall map. After speaking with Joseph (our asset designer) on the feasibility of asset creation, we settled to only focus on creating the town area.

This new town would be a bigger town than the original drafts. I created maps for the houses, stores, resturants, parks, and parking lot (the parking lot was discarded in the final build due to asset limitations and time constraints). These buildings had 2 variations to them (and a third for corner places for stores and resturants only) to make them look more diverse. The overall town was going to be centered around a big park with business becoming increasingly sparce the further away the building was from the park.

## Sub-Role: Narrative Design ##
Due to time constraints and my prioritizing of my main role, this role was unfortunately mostly sidelined.

Original plans were to play the game on a timer and escape from the town after surviving. But with our game name chosen, I shifted the story to fit the game. Zissors, the zombie boss, took over the player's town. The town now abandoned by people, the player seeks to reclaim the town by killing zombies. Surviving long enough allows the player to lure out and have a chance to take their revenge on Zissors. Hints of this story are in the objectives screen.

## Other Contributions ##
Implementing world tilemaps and subsequent tile layers according to the maps I have made.
Each item in the tileset was isolated and I placed collision upon items that needed them.

The base Tilemap has nothing on it. The first layer is a grass layer. The furniture layer contains bigger items (~32x32 pixels) on the map and their collision (eg. tables, cars). The details layer has the smaller items (~16x16 pixels) and their collision (and some bigger items that can't fit on the 32x32 grid due to the asset's constraints). The borders and walls are separated between the details, walls, and house/store borders layers to make sure that previous layers' tiles on the map aren't overriden. The InvisWalls layer is just an invisible wall to prevent the player from going outside the map. The roof layer is an extra layer that places roofs on top of the houses and stores that are outside of the map. It also serves as a secondary indication that the house is unable to be entered. All of the buildings besides the ones on the outside ring of the map do have detail within them but the current game implementation of the zombies and time constraints in other roles limit the map size severely.

The original map was supposed to be much bigger in accordance to my town layout map. By Sunday, I had around 2.5x the size of the map that is currently placed but unfortunately that save was corrupted and lost right before commiting to the github (It was around 3x3 city blocks before commiting instead of the 2x2 that it is today). 

Outside details, like the cars were somewhat intentionally placed (random bad parking jobs, only placed on sidewalks or house driveways, street laws followed). House and building variations were created as intended. But the park didn't quite follow the map due to time constraints and in hopes of giving the boss a big area to fight on.

Post-Game demo, I cleaned up the playable map and added borders.
