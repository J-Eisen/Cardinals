# Cardinals
A lightweight multiplayer story generator  
Cardinals is a game of contests, from fistfights to cookoffs. Each contest will slowly build a history for the characters involved, leaving gaps for the user to fill in.

## Current Features
* New Game Screen  
  * Custom name fields for each player  
  * Computer buttons for each player Turns the player into an AI opponent  
  *  Functional Game Type selection picker  
* Current Game Screen  
  * Messages display at the end of each turn to show each player's action  
  * Messages contain users' selected names
  * 4 buttons for each game type  
  * Button text changes by type  
  * User names with visual scores at bottom  
* Automatic Victory Screen  
  * A victory screen appears as soon as one player's score drops to 0  
  * If both players drop to 0 at the same time, the game will acknowledge that too  
  
## Features Under Development  
* Save states  
  * Characters will be saved, with results from previous contests as well  
  * Characters can be loaded into any new contest  
  * Contests in progress will be able to be saved  
* Persistence  
  * Characters will have preferences assigned as they are needed  
    * e.g. If a character fights with a sword in one fight, it will use a sword in all fights. However, its preference will be lazy and be created as needed.
  * Characters will keep results from previous contests that can appear in similar ones  
    * e.g. If they are cut by a sword, they will always be scarred from that sword slash.  
* Contest Types  
  * Contests will have different action text  
  * Contests will have a different pace as starting scores and action mechanics are linked to the contest  
  * Changing starting scores and how various actions interact
* Networking  
  * Bluetooth based local multiplayer
* Graphics  
  * A selection of character portraits is also under development  
* Improved AI  
  * AI will have personalities in that they will prefer or forbid certain choices
  * Preference and forbidding will also have certain break points
    * (e.g. if the computer's preferred strategy isn't working, it will be able to switch its strategy under duress)
