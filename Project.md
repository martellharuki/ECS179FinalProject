# Revenge of Zissors #

## Summary ##

Our game, "Revenge of Zissors", is a top-down zombie shooter; the setting is a zombie apocalypse. Players will get a birds eye view of the map and use a gun to kill zombies. The game features 4 guns pistol, smg, assault rifle, and sniper rifle which have distinct fire rate, accuracy, damage, and bullet velocity stats associated with them. Guns are picked up off the ground. Players can also upgrade their gun by crafting, which consumes scrap, a material dropped by zombies. However, players cannnot move while crafting, so beware! Zombies also drop bandages, allowing the player to heal. Zombies spawn in waves, with each wave getting bigger then the last. Zombies also get ramping health. Be sure to upgrade your gun to keep up! At a certain poin in the game, a boss zombie, Zissors, spawn. Zissors has a unique attack patter, and is much more bulky then the base zombies. Defeating Zissors wins you the game!

## Project Resources

[Web-playable version of your game.](https://martellharuki.itch.io/revenge-of-zissors)  
[Proposal: make your own copy of the linked doc.](https://docs.google.com/document/d/1SG45SkCJg-_YqTW3saoH2T0eArfKZdetLfeUSvTiIBg/edit?tab=t.0#heading=h.i3tv2mxf7h7z)  

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
## Github: Koumbabill
## Main Role: Game Logic
* #### Player Aiming / Facing Mouse Cursor
  Implemented mouse-based aiming so the player character always faces the mouse cursor using `look_at(get_global_mouse_position())`. Added a sprite-facing offset (ex: rotation += deg_to_rad(90)) to compensate for art orientation (sprite facing “up” while Godot’s forward axis is +X). [Related Files](https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/player/player.gd)

* #### Custom Aiming Cursor
  Replaced the default mouse cursor with a custom aiming reticle drawn in-engine. It is implemented as a **CanvasLayer** tracking the mouse so it stays stable regardless of camera movement.
  Designed the reticle to be parameterized, including a adjustable `gap_radius` (distance from center to bars), `bar_thickness`, `bar_length`, and optional center dot. [Related Files](https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/mouse_cursor.gd)

* #### Flashlight cone lighting
  Used a **PointLight2D** object with procedurally generated cone texture that does not require a texture asset. The texture was made manually in real-time through code. It bein a child node of the player scene, there was no redirection necessary. Its properties are modifiable like the angle, the power, and the range. [Related Files](https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/flashlight.gd)

* #### Dynamic Camera Lead System
  This cursor-led camera with leash was inspired by our Exercise 2 Stage 4 on camera controls. Similarly, it is a Camera2D object that a `lead_speed` for how quickly the camera catches to the cursor and a `leash_distance` which is the maximum distance of the camera from the cursor. In opposition to the Exercise 2 implementation, the camera is led by the cursor, so there is an additional `max_dist` variable so that the player does not exit the camera's sight. [Related Files](https://github.com/martellharuki/ECS179FinalProject/blob/main/camera_handler.gd)
* #### Dash Mechanic with Cooldown
  Implemented a player dash action. When dashing, the player character has a burst of velocity at `dash_speed` for `dash_duration`, the dash has a 2 second cooldown before it can be reused and the dash direction defaults to movement direction, or mouse direction if standing still. [Related Files](https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/player/player.gd)
* #### Consumable Bandage Healing
  Implemented a consumable healing system of bandage. When using the bandage input Q, it will verify if the player has missing health. If there is no missing health, bandage will not be consumed, otherwise bandage is used to heal by a `heal_amount` without exceeding the player `max_health` and remove one from the `bandage_count`. The player starts with 3 bandages for balance purpose. [Related Files](https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/player/bandage_handler.gd)

## Sub Role: Gameplay Testing
#### Link to Game Testing Reports
[Report Folder](https://drive.google.com/drive/folders/1VcvKhtboJzChzymfOTVz2D2E3f3ab_U-?usp=drive_link)
#### Main questions asked during Testing
1. What was your favorite part about the game?
2. What didn’t you like about the game?
3. What was confusing or not explained enough?
4. Did the game feel too long, too short, or just about right?
5. How did the controls feel? Were the camera movements optimal?
6. If you were to suggest that one change be made to the game, what would it be?

#### Key findings
* Better Sound Design - Outside from the background music and the shooting sounds, there is no other sound effects
* Clearer Boss UI - There is no visual nor audio cue that the boss has spawned, and no health bar to give a better assertion of the fight
* Improved enemy behavior - It is too common to find multiple enemies stuck behind obstacles including the boss, it also leads to some zombies 
 especially since the map has many elements blocking both the player and the zombies

#### What has been achieved before final version
* Increased sound design with heal, and damage sound effects on the player, and damage, attack and death sound effects for the zombies

## Other Contributions
* Maintainability Improvements - Added modifieable variables to help tuning and balancing of the gameplay overall
* Performance & Responsiveness Checks -  Ensured that the game stayed responsive and that previously implemented features remained after new additions


# Patrick
## Github: Chunkio
## Main Role: Systems and Tools Engineer
I made all the menus and screens for the game, and set up how players control their character.

UI Manager System - Created a UI manager that controls all the different menus and screens in one place. This includes the pause menu, title screen, health bar, and hotbar. The manager keeps everything organized and makes it easy to show or hide different UI elements when needed. 

https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/hud.gd

Pause Menu System - Implemented a fully functional pause screen with resume and return-to-title functionality. This system halts game state while maintaining UI responsiveness. The pause system uses Godot's process pausing and implements the State Pattern to ensure clean transitions between play and pause states. 

https://github.com/martellharuki/ECS179FinalProject/blob/main/scripts/pause_screen.gd

Main Menu - Created the title screen with three core buttons (Start, How to Play, Quit) that serve as the game's entry point. This implements scene management and UI navigation hierarchies, ensuring smooth transitions between game states. 

https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/title_screen.gd

Health Bar - Developed a responsive HP bar that updates in real-time as the player takes damage. The UI subscribes to health change events from the player controller. The visual feedback provides crucial game feel elements that communicate player state clearly and immediately.

https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/health_bar.gd

Player Controls - Set up the basic WASD movement controls so players can move around in the game.

https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/player/player.gd

## Sub Role: Accessibility and Usability Design
In this role, I focused on making the game more accessible and improving the overall user experience through iterative design and testing features. This connects to the Usability Engineering and Iterative Design principles emphasized throughout the course.

Testing Buttons - Created a comprehensive set of testing inputs (heal button, damage button, instant win) to facilitate rapid iteration and debugging of UI systems. These testing features allowed for quick validation of visual feedback systems without requiring full gameplay loops.  
https://github.com/martellharuki/ECS179FinalProject/blob/fc74ab76b2a36d901162826293c1c640809269a2/Scripts/player/player.gd#L96-L98

Hotbar UI - Designed and implemented the hotbar interface structure that serves as the foundation for the inventory system.

Win and Lose Screens - Developed win screen, lose screen, and objective screen to clearly communicate game state to players. The objective screen appears immediately after game start, providing clear player goals ("Survive"). These screens implement feedback systems and ensure players always understand their current objective and performance.

https://github.com/martellharuki/ECS179FinalProject/blob/main/Scenes/lose_screen.tscn
https://github.com/martellharuki/ECS179FinalProject/blob/main/Scenes/win_screen.tscn
https://github.com/martellharuki/ECS179FinalProject/blob/main/Scenes/objective_screen.tscn
https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/win_screen.gd
https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/lose_screen.gd
https://github.com/martellharuki/ECS179FinalProject/blob/main/Scripts/objective_screen.gd

Score System - Added a score counter in HUD.gd that tracks how many enemies you kill. The score shows up on the win/lose screens at the end so you can see how well you did. 

## Other Contributions:
Visual Setup - Assisted with the visual polish of the game by integrating graphical assets including title graphics, background images, and button icons into their appropriate UI screens. 

Removed Features - Developed and later removed an inventory screen system after determining it added unnecessary complexity to the core gameplay loop.

# Kaylie Lam (Github: Kalam721)

## Main Role: Level and World Designer ##
I originally wanted to create a small town set in the modern day. The town would have been an old mining town that is run down and long abandoned by the time the player is in town. The town would have been the central part of the map. But I also drafted areas connected to the town so that those areas' borders like cliffs and the sea served as a natural border on the overall map. These maps were created around the intial plans stage and additional notes in these maps at the time were spitball ideas that could be helpful for gamefeel given the time.  After speaking with Joseph (our asset designer) on the feasibility of creating the map, we settled to only focus on creating the town area.

| Draft Maps |   |   
| :------------: |:------------: |
|  <img src="https://github.com/martellharuki/ECS179FinalProject/blob/main/ProjectDocumentationPhotos/Originaldraft_Overallmapmap.webp" alt="DraftMapV1" width="80%">  |  <img src="https://github.com/martellharuki/ECS179FinalProject/blob/main/ProjectDocumentationPhotos/OriginalDraft_TownmapWesternStyle.webp" alt="DraftTownV1" width="80%">  |
| Draft of the overall areas map | Draft of the small town |

This new town would be a bigger town than the original drafts. I created maps for the houses, stores, resturants, parks, and parking lot (the parking lot was discarded in the final build due to asset limitations and time constraints). These buildings had 2 variations to them (and a third, slight variation for businesses on the corner for stores and resturants only) to make them look more diverse. One variation of the house map intends a family to live there while the other variation likely would have a single or a couple living at the household. The resturant variations also have slightly different purposes to them as well. The first variation is intended to  be more of an open kitchen/pizzaria/diner look to it while the other variation of the map is a more traditional resturant layout. The general store variation layouts are similar to what I think the layouts at a Walgreens or 7-11 are. The overall town was going to be centered around a big park with business becoming increasingly sparce the further away the building was from the park.

| Town Building Maps |   |   |  |
| :------------: |:------------: | :------------: | :------------: |
|  <img src="https://github.com/martellharuki/ECS179FinalProject/blob/main/ProjectDocumentationPhotos/GeneralHouseMap.webp" alt="House Maps" width="80%">  |  <img src="https://github.com/martellharuki/ECS179FinalProject/blob/main/ProjectDocumentationPhotos/GeneralStoreMap.webp" alt="Store Maps" width="80%">  | <img src="https://github.com/martellharuki/ECS179FinalProject/blob/main/ProjectDocumentationPhotos/ResturantMap.webp" alt="Resturaunt Maps" width="80%">  |  <img src="https://github.com/martellharuki/ECS179FinalProject/blob/main/ProjectDocumentationPhotos/CornerVariationsResturantStoreMap.webp" alt="Corner Business Variations" width="80%">  |
| General House variations | General Store variations | Resturant variations | Corner Business Variations |

| Outside Areas and Overall Town Maps |   |   |
| :------------: |:------------: | :------------: |
|  <img src="https://github.com/martellharuki/ECS179FinalProject/blob/main/ProjectDocumentationPhotos/ParkMap.webp" alt="Park Map" width="80%">  |  <img src="https://github.com/martellharuki/ECS179FinalProject/blob/main/ProjectDocumentationPhotos/ParkingLotMap_Scrapped.webp" alt="Parking Lot" width="80%">  | <img src="https://github.com/martellharuki/ECS179FinalProject/blob/main/ProjectDocumentationPhotos/RevisedOverallTownMap.webp" alt="Overall Town Offcentered Map" width="80%">  |
| Park variations | Parking Lot (Scrapped) | Overall town map |

## Sub-Role: Narrative Design ##
Due to time constraints and my prioritizing of my main role, this role was unfortunately mostly sidelined.

Original plans were to play the game on a timer and escape from the town after surviving. But with our game name chosen, I shifted the story to fit the game. Zissors, the zombie boss, took over the player's town. The town now abandoned by people, the player seeks to reclaim the town by killing zombies. Surviving long enough allows the player to lure out and have a chance to take their revenge on Zissors. Hints of this story are in the objectives screen.

## Other Contributions ##
Implementing world tilemaps and subsequent tile layers according to the maps I have made.
Each item in the tileset was isolated and I placed collision upon items that needed them.

The base Tilemap has nothing on it. The first layer is a grass layer that would will in the empty tiles in between the buildings and roads of the town. The furniture layer contains bigger items (~32x32 pixels) on the map and their collision (eg. tables, cars). The details layer has the smaller items (~16x16 pixels) and their collision (and some bigger items that can't fit on the 32x32 grid due to the asset's constraints). The borders and walls are separated between the details, walls, and house/store borders layers to make sure that previous layers' tiles on the map aren't overriden. The InvisWalls layer is just an invisible wall to prevent the player from going outside the map. The roof layer is an extra layer that places roofs on top of the houses and stores that are outside of the map. It also serves as a secondary indication that the house is unable to be entered. All of the buildings besides the ones on the outside ring of the map do have detail within them but the current game implementation of the zombies and time constraints in other roles limit the map size severely.

The original map was supposed to be much bigger in accordance to my town layout map. By the Sunday before the demo, I had around 2.5x the size of the map that is currently placed but unfortunately that save was corrupted and lost right before commiting to the github (It was around 3x3 city blocks before commiting instead of the 2x2 that it is today). 

Outside details, like the cars were somewhat intentionally placed (random bad parking jobs, only placed on sidewalks or house driveways, street laws followed). House and building variations were created as intended. But the park didn't quite follow the map due to time constraints and in hopes of giving the boss a big area to fight on. Other small details, like box clutter and flowers were also placed in areas where they would make sense.

Post-Game demo, I cleaned up the playable map and added borders.





# Haruki Martell
## Github: martellharuki
## Main Role: Systems and Tools Engineer
* #### Entity and Live Entity Classes/Scenes
  These classes add some base functionality to objects that have a sprite and hitbox. Entity handles showing and hiding sprites, and live entity handles a health or timer option to these objects giving them a "lifespan". When their life expires, it deleted the node. 
  **Relation to Course Content:** This ties into the component system learnings since the entity classes give a base implementation of an object's controller, on which other components can be added upon.
  **Commits**: [Entity Commit](https://github.com/martellharuki/ECS179FinalProject/commit/ee5b1d126b91f9faae15dcf99b7d9fcc06f886c9)

* #### Bullets and Base Weapon:
  By extending the Live Entity class, we make a bullet object which dies after a certain life span. The bullet also has an Area 2D which detects a collision, dying on rigid objects and ignoring the player. Given a velocity and direction, the bullet object also updates each frame to move. The bullet is fired by a weapon handler in the player node. The weapon handler is a factory which instanties the bullet scenes, and gives the bullet a velocity, direction, and damage. These values are determined by a weapon spec, which represents the players current weapon. On click, the player commands the weapon to fire. The weapon checks to see if it can fire based on fire rate (also part of spec) and builds the bullet if it can.
  **Relation to Course Content:** Factory, Component, Command, Mechanics (Weapon spec)
  **Commits:** [Base Bullet Scene](https://github.com/martellharuki/ECS179FinalProject/commit/d8f97fe6202c1b169f241070a819d2a430346fbe) | [Weapon Spec and Bullet Logic](https://github.com/martellharuki/ECS179FinalProject/commit/026e796080583bf0e4d7aabdbedd5ac573448217)

* #### Action Display:
  This is a node (named Action Item) that other handlers use to depict an action being taken. Specifically, it features a progress bar, used in crafting and item pick up as well as text, which tells the player the buff they crafted. Other controllers access this node through its unique name, and they have an option to set the bar or the text. The Action Handler then takes care of the specifics, including: hiding text after a set time, prioritizing crafting progress over item pick up, and resetting the bar. The intent is to convey action information. 
**Relation to Course Content:** Command pattern, Components, and Mechanics
**Commits:** [Action Item (Look for action_item.gd)](https://github.com/martellharuki/ECS179FinalProject/commit/8db35cda48a6c008784f684feb0411ecf990dde6)

* #### Item Pick Up:
  We once again extend the Live Entity to create items, which can drop for 20 seconds. The item scene also contians an enum of the item type and its grouped under "item". The player then contains an Item Pickup Handler. The handler consists of the handler and then a child area 2D. The child area is responsible for telling the handler if an item is hovered and which item that is. The handler is responsible for keeping track of progress, telling the Action Display what to depict, and manages item pick up by deleting the item and commanding the proper containers (gun, scrap, and bandage). The intent is to allow players to pick up items while making them work for it (stand ontop for a set time).
  **Relation to Course Content:** Command Pattern, Components, and Mechanics
  **Commits:**  [Item Pickup Collider and Handler](https://github.com/martellharuki/ECS179FinalProject/commit/8db35cda48a6c008784f684feb0411ecf990dde6) | [More Types for Item Pickup Handler](https://github.com/martellharuki/ECS179FinalProject/commit/684ca384a042d73789059ef3112342fcc5352513#diff-bfd5490bc6c085f12d45d1b61a5447b1932d388cdd862dfa2c26206c3c3dba3f) | [Enables Players to Hover Over Multiple Items and Updates the Hud](https://github.com/martellharuki/ECS179FinalProject/commit/2f422c9853a9df2e85c21d84458e12a43544fa1d)

* #### Gun Spawning and Pickup: 
  Extending the item scene, we add another enum depicting what kind of gun it is. Each gun then gets its own scene. On gun pickup, the Item Pickup System commands the Weapon Handler to switch to a new gun, passing in the enum. The weapon handler then gets its gun by using a static function that holds each base weapon spec. The weapon handler also commands the player animator to change animations (more on this later). Item spawning uses the Item Spawning Handler, which contains possible spawn locations and has a chance to instantiate them every second. The intent is adding gun drops randomly around the world. The gun is a live entity, so it deletes after a delay
**Relation to Course Content**: Command Pattern, Factory
**Commits:** [Item Spawner (used to spawn scrap, refactored for guns)](https://github.com/martellharuki/ECS179FinalProject/commit/35c6e4e907b9b6d1d42c350e23ab0ba475fd4bcd) | [Adding Gun Scenes To Item Spawner](https://github.com/martellharuki/ECS179FinalProject/commit/684ca384a042d73789059ef3112342fcc5352513#diff-bfd5490bc6c085f12d45d1b61a5447b1932d388cdd862dfa2c26206c3c3dba3f)

* #### Crafting
  Added a crafting handler that handles crafting when E is pressed. It commands the ActionItem node to display the progress. When completing crafting, it commands its child, UpgradeSpec to randomly upgrade a gun value, which can either be a base increase or an increase to a multiplier. The intent is to reward taking to time to pick up scrap while adding an element of RNG to it. The crafting handler also locks player movement. The weapon handler instantiates bullets by taking (gun_spec + upgrade_spec_base) * upgrade_spec_mult
  **Relation to Course Content:** Component, Command, Mechanics
  **Commits:** [Crafting and Upgrade Spec](https://github.com/martellharuki/ECS179FinalProject/commit/8db35cda48a6c008784f684feb0411ecf990dde6#diff-3adcf11f7abf00c3186f15d21a9bafd37b3d47830020eeb470f381cefb754d7a)

* #### Zombie Item Drops:
  Added zombie item drops by having zombies command the item spawner to roll for a chance to drop an item. Zombies pass their location. Should the roll succeed, the spawner will spawn an item at the passed location. The intent is to reward players for killing zombies.
  **Relation to Course Content:** Command, Mechanics
  **Commits:** [Zombie Drops Scrap](https://github.com/martellharuki/ECS179FinalProject/commit/684ca384a042d73789059ef3112342fcc5352513#diff-7c2affd6258b13da46a6094e8a596d55de9758511f1a8ba15294ce3f64689eb6) | [Zombie Scrap Drop Additions](https://github.com/martellharuki/ECS179FinalProject/commit/9c5d126799a899725850e253f7d121119fef43ec#diff-78f6ba713faf4d8fda8490938d6e8db139b5864aa41b708a25a7c4c74ab0017d) | [Zombie Drops Bandage](https://github.com/martellharuki/ECS179FinalProject/commit/518c9199071563baa00e28fb91ac32ba37f758a3#diff-7c2affd6258b13da46a6094e8a596d55de9758511f1a8ba15294ce3f64689eb6) 
## Sub Role: Build and Release Manager
* #### Built and Pushed Webversion
  I was in charge of uploading the game to itch.io
* #### Helped Teammates Merge Changes:
  I helped our team merge their changes in. Here are some exmaples:
  * Helped Hao merge zombie changes in on call
  * Kaylie's tile map changes was corrupting our World.tscn and deleting progress, so I merged the branches correctly. ![alt text](image.png)
  * Me and another teammate both pushed bandage dropping logic, so I reverted the duplicate changes. ![alt text](image-1.png)
## Other Contributions:
* #### Animation Handling:
  Imported the player animation and created an animation handler where the player can command different animations. The animation handler will account for the equipted gun when determining animations.
  **Relation to Course Content:** Component design pattern
  **Commits:** [Animations](https://github.com/martellharuki/ECS179FinalProject/commit/684ca384a042d73789059ef3112342fcc5352513)

* #### Audio Handling
  Implemented some sounds before the demo since the audio person was busy. Made an audio handler that gets commanded to play certain sounds. All sounds found online for free. Trimmed gunshot to fit our game. Intent was to add some audio since a silent game is bad.
  **Links to Sounds**: [Gunshot](https://pixabay.com/sound-effects/gun-fire-346766/) | [Music](https://pixabay.com/music/video-games-356-8-bit-chiptune-game-music-357518/)
  **Relation to Course Content:** Game feel, Component, Command
# Hao
## Github: Edward-Fraus-Lu
## Main Role: AI and Behavior Designer
* #### In this role I focused on the core gameplay loop the enemy behavior which include wave progression, enemy spawning, Nevigation to avoid objects on the map.

#### Central Zombie spawn control--I implemented the overall wave progression and game state logic. A central “Game Master” controller tracks the current wave, how many zombies are alive, when to start the next wave, and when to spawn the boss Zissors. It also ramps up difficulty over time by increasing zombie count and health each wave.
 **Linked to Course content:** game loops, state management, and difficulty tuning
 **Commits:** [spawn_zombie]https://github.com/martellharuki/ECS179FinalProject/blob/ad57a6bb49a1f8a0fee7f1e6e3857aa439778a70/Scripts/Enemy/zombie_spawner.gd

#### Zombie AI and Combat Behavior--I implemented the base zombie behavior: zombies detect the player and move toward them, dealing contact damage when close enough. The zombie logic effectively works as a simple state machine (idle/search → chase → attack → death). I integrated this with health and damage systems so that zombies react to bullets and can die, add particle effect to make the game feel more interactive for the player.
**Linked to Course content:** enemy AI, combat mechanics 
**Commits:** [basic_zombie]https://github.com/martellharuki/ECS179FinalProject/blob/4f90d9212746d90afd2457f6c41e766b622721ef/Scripts/Enemy/basic_zombie.gd
[lump_zombie]https://github.com/martellharuki/ECS179FinalProject/blob/4f90d9212746d90afd2457f6c41e766b622721ef/Scripts/Enemy/lump_zombie.gd

#### Boss "Zissors"--I designed and implemented the boss variant, Zissors. Compared to basic zombies, Zissors has significantly more health, unique movement/attack patterns, and acts as the final objective of the run. Zissors is spawned by the Game Master once the game reaches a specified point in the wave progression, and defeating it triggers the win condition and win screen.
**Linked to Course content:** boss/encounter design, pacing and climax, and structuring the game loop
**Commits:** [Boss]https://github.com/martellharuki/ECS179FinalProject/blob/4f90d9212746d90afd2457f6c41e766b622721ef/Scripts/Enemy/scissor_zombie.gd

#### Collision and Pathfinding--I set up and tuned collision for enemies so zombies properly interact with the map, props, and the player, instead of sliding through walls or overlapping in unreadable ways. This included configuring collision layers/masks so bullets reliably hit zombies and stop on solid environment, while avoiding unintended collisions with the player and other zombies.

On the movement side, I adjusted zombie navigation so they move toward the player while reacting to obstacles in the level, allowing them to “flow” around corners and objects instead of getting stuck. This creates the feeling of being chased and potentially surrounded, which is important for our survival-style gameplay. 
**Linked to Course content:** physics and collision systems, spatial reasoning, navigation around obstacles, and level-informed enemy movement
**Commits:** [pathfinding]https://github.com/martellharuki/ECS179FinalProject/tree/49c70bc193923364226202e6efadde8710ae282e/Scenes/diff_zombie

## Sub Role: Audio 
* #### In this role I focused on enemy and combat-related sounds that support feedback and game feel.

#### Enemy and Player Audio Feedback--I worked on finalizing the audio hooks and behaviors for both zombies and the player. This includes:

Zombie sounds (vocalizations, hits, and death cues) that make enemy presence and danger more noticeable, even when they’re off-screen or in the player’s blind spots.

Player-centric sounds (taking damage, being attacked, and other key events) that give immediate audio feedback when the player is in danger.

#### The goal was to make the world feel more alive, tense, and satisfying to play, tying into course topics on game feel, feedback systems, and audio as an important channel for conveying state and danger to the player.
**Linked to Course content:** game feel, feedback systems, audiovisual signaling of state, and using sound to communicate danger and impact
 **Links:** [audio]https://github.com/martellharuki/ECS179FinalProject/tree/51622f908638377ad5a4482ccd28fc66c53f198e/assets/Audio
 [web]www.101soundboards.com/sounds [death-zombie](https://www.101soundboards.com/sounds/294190-death-zombie)[hurt-zombie](https://www.101soundboards.com/sounds/294747-hurt2-zombie)

# Joseph Lee
## Github: jhblee
## Main Role: Animation and Visuals
## SUb Role: Game Feel
* #### Player Animation
* #### Zombie Animation
* #### Weapon Assets
* #### Tileset
* #### Title, UI Designs, Background


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
