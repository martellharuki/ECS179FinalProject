# The title of your game #

## Summary ##

Our game, "Revenge of Zissors", is a top-down zombie shooter; the setting is a zombie apocalypse. Players will get a birds eye view of the map and use a gun to kill zombies. The game features 4 guns pistol, smg, assault rifle, and sniper rifle which have distinct fire rate, accuracy, damage, and bullet velocity stats associated with them. Guns are picked up off the ground. Players can also upgrade their gun by crafting, which consumes scrap, a material dropped by zombies. However, players cannnot move while crafting, so beware! Zombies also drop bandages, allowing the player to heal. Zombies spawn in waves, with each wave getting bigger then the last. Zombies also get ramping health. Be sure to upgrade your gun to keep up! At a certain poin in the game, a boss zombie, Zissors, spawn. Zissors has a unique attack patter, and is much more bulky then the base zombies. Defeating Zissors wins you the game!

## Project Resources

[Web-playable version of your game.](https://itch.io/)  
[Proposal: make your own copy of the linked doc.](https://docs.google.com/document/d/1qwWCpMwKJGOLQ-rRJt8G8zisCa2XHFhv6zSWars0eWM/edit?usp=sharing)  

## Gameplay Explanation ##

**In this section, explain how the game should be played. Treat this as a manual within a game. Explaining the button mappings and the most optimal gameplay strategy is encouraged.**
The player uses WASD to move, and click to shoot. Players are substantially faster than zombies, so continous shooting and movement is essential to survival. On game start, the player should roam the map looking for a gun spawn, since they are significantly more powerful then the base pistol. The town block the player starts in has 80 potential locations for gun spawns, so keep your eyes peeled! Because zombie count and health scale with wave, upgrading your gun is essential. Crafting allows a boost to either a base stat, or apply a multiplier, which significantly improves your DPS. Crafting requires scrap, which is dropped by zombies, so be sure to kill zombies. Hold E to craft. It takes 2 seconds where the player can't move, so be careful! Zombies also drop bandages, which can be consumed by pressing Q. Something to note is that the camera enables players to see further in the direction they're facing and less in the direction they're not. Because this creates a blind spot, be sure to check your six! The most common way to lose is being encircled since players cannot walk through zombies. If you see the zombies are in every direction, focus on breaking of the death circle before cleaning up the rest of the zombies.

**Add it here if you did work that should be factored into your grade but does not fit easily into the proscribed roles! Please include links to resources and descriptions of game-related material that does not fit into roles here.**

# External Code, Ideas, and Structure #

If your project contains code that: 1) your team did not write, and 2) does not fit cleanly into a role, please document it in this section. Please include the author of the code, where to find the code, and note which scripts, folders, or other files that comprise the external contribution. Additionally, include the license for the external code that permits you to use it. You do not need to include the license for code provided by the instruction team.

If you used tutorials or other intellectual guidance to create aspects of your project, include reference to that information as well.

# Team Member Contributions

This section be repeated once for each team member. Each team member should provide their name and GitHub user information.


# Bill

# Patrick

# Kaylie

# Haruki Martell
## Github: martellharuki
## Main Role: Systems and Tools Engineer
* #### Entity and Live Entity Classes/Scenes
  These classes add some base functionality to objects that have a sprite and hitbox. Entity handles showing and hiding sprites, and live entity handles a health or timer option to these objects giving them a "lifespan". When their life expires, it deleted the node. 
  **Relation to Course Content:** This ties into the component system learnings since the entity classes give a base implementation of an object's controller, on which other components can be added upon.
  **Commits**: [Entity Commit](https://github.com/martellharuki/ECS179FinalProject/commit/ee5b1d126b91f9faae15dcf99b7d9fcc06f886c9)

* #### Bullets and Base Weapon:
  By extending the Live Entity class, we make a bullet object which dies after a certain life span. The bullet also has an Area 2D which detects a collision, dying on rigid objects and ignoring the player. Given a velocity and direction, the bullet object also updates each frame to move. The bullet is fired by a weapon handler in the player node. The weapon handler is a factory which instanties the bullet scenes, and gives the bullet a velocity, direction, and damage. These values are determined by a weapon spec, which represents the players current weapon. On click, the player commands the weapon to fire. The weapon checks to see if it can fire based on fire rate (also part of spec) and builds the bullet if it can.
  **Relation to Course Content:** This ties into the factory pattern since weapon handler is a factory. Additionally, the weapon is a component of the player and gets commanded by said player (component and command pattern). The bullet and weapon specs fall under the mechanics/rules of our game and builds to gun system.
  
## Sub Role: Build and Release Manager

## Other Contributions:

# Hao

# Joseph


For each team member, you shoudl work of your role and sub-role in terms of the content of the course. Please look at the role sections below for specific instructions for each role.

Below is a template for you to highlight items of your work. These provide the evidence needed for your work to be evaluated. Try to have at least four such descriptions. They will be assessed on the quality of the underlying system and how they are linked to course content. 

*Short Description* - Long description of your work item that includes how it is relevant to topics discussed in class. [link to evidence in your repository](https://github.com/dr-jam/ECS189L/edit/project-description/ProjectDocumentTemplate.md)

Here is an example:  
*Procedural Terrain* - The game's background consists of procedurally generated terrain produced with Perlin noise. The game can modify this terrain at run-time via a call to its script methods. The intent is to allow the player to modify the terrain. This system is based on the component design pattern and the procedural content generation portions of the course. [The PCG terrain generation script](https://github.com/dr-jam/CameraControlExercise/blob/513b927e87fc686fe627bf7d4ff6ff841cf34e9f/Obscura/Assets/Scripts/TerrainGenerator.cs#L6).

You should replay any **bold text** with your relevant information. Liberally use the template when necessary and appropriate.

Add addition contributions int he Other Contributions section.

## Main Roles ##

## Sub-Roles ##

## Other Contributions ##
