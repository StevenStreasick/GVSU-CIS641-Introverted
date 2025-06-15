# Overview
The purpose of this document is to provide a detailed analysis into the functionality of this software. This document will serve as a blueprint for the construction of the Software, as this document defines what the Software should do and what the software should be capable of.


# Software Requirements
This section provides a set of functional and nonfunctional requirements that the software must follow

## Functional Requirements
| ID | Enemy Logic |
| :-------------: | :----------: |
| FR1 | The game shall spawn enemies at random intervals in random positions offscreen |
| FR2 | The game shall adjust the enemy size, number of enemies, and enemy sight to change the difficulty based on the player’s performance |
| FR3 | The SAS system must update the difficulty of the game (FR2) when the player's score updates |
| FR4 | The game shall adjust the enemy size, number of enemies, and enemy sight to adjust the framerate of the game |
| FR5 | Enemies shall follow the player when the player is within the enemies sight |

| ID | Framerate SAS |
| :-------------: | :----------: |
| FR6 | The zoom level must dynamically adjust based on player performance and happiness |
| FR7 | The zoom level must reset when a new game begins <REFER TO A FUTURE REQUIREMENT> |
| FR8 | Zoom changes must not disorient the player |
| FR9 | Happiness must influence overall game behavior (e.g., difficulty) |
| FR10 | Happiness must increase with higher framerates and decrease with lower ones |

| ID | Score |
| :-------------: | :----------: |
| FR11 | The score must increase when a player eats a smaller fish |
| FR12 | The score must increase proportionally to the enemy fish's size |
| FR13 | The score must be displayed while the game is active |
| FR14 | The score must never decrease while the game is active |
| FR15 | The score must reset when a new game begins |

| ID | Player Interactions |
| :-------------: | :----------: |
| FR16 | The player fish must move when the player inputs a movement key |
| FR17 | The player must not be able to go off screen |
| FR18 | The game must start when the player starts the game |
| FR19 | Collision detection must determine whether the player fish eats or is eaten |
| FR20 | Multiple input devices such as keyboards and controllers must be supported |
| FR21 | The game must end when the player touches a larger fish |
| FR22 | The player must grow when the player touches a smaller fish |

| ID | Performance and Stability |
| :-------------: | :----------: |
| FR23 | The game must maintain a minimum framerate of 30 FPS |
| FR24 | The game must handle unexpected input |
| FR25 | A performance monitor must log metrics regarding hapiness and framerate data |
| FR26 | The game must dynamically adjust settings to maintain the target framerate |
| FR27 | The system must be capable of handling skipped frames |

## Non-Functional Requirements
| ID | Enemy Logic |
| :-------------: | :----------: |
| NFR1 | Enemy sprites must maintain visual clarity at all zoom levels |
| NFR2 | Enemies must maintain a constant velocity across all framerates |
| NFR3 | Enemy movement and behavior must be consistent across all Operating Systems |
| NFR4 | Enemy difficulty must feel natural |
| NFR5 | Enemy difficulty changes must not cause delays |

| ID | Framerate SAS |
| :-------------: | :----------: |
| NFR6 | Zoom calculations must be completed within 2ms per frame |
| NFR7 | The happiness calculations must be completed within 1ms per frame |
| NFR8 | Changes in zoom must be gradual and must avoid disorienting the player |
| NFR9 | The zoom system must not interfere with the other SAS systems |
| NFR10 | Happiness levels must have a maximum gradual change of .05 happiness per second |

| ID | Score |
| :-------------: | :----------: |
| NFR11 | Score updates must be processed within 1ms per frame |
| NFR12 | The scoring UI must be legible across all zoom levels and systems |
| NFR13 | The scoring UI must be unaffected by resolution changes |
| NFR14 | The scoring UI must support localization |
| NFR15 | The end user score UI must appear within 1ms of the player dying |

| ID | Player Interactions |
| :-------------: | :----------: |
| NFR16 | User input must be processed within 20ms, even at low frame rates |
| NFR17 | Collision detection must occur within 1ms of occurance |
| NFR18 | Controls must be adhere to traditional game standards and support multiple sets of input keys |
| NFR19 | User input must be supported and processed for multiple different Operating Systems |
| NFR20 | The system must handle at least 4 simultaneous inputs without delay or missed actions |

| ID | Performance and Stability |
| :-------------: | :----------: |
| NFR21 | Framerate dips must recover within a second |
| NFR22 | The game must scale to different screen sizes and aspect ratios |
| NFR23 | The game must be capable of running for at least 2 hours without crashing |
| NFR24 | Performance logging must not take more than 1ms every frame |
| NFR25 | The game must not exceed 2GB of RAM usage during normal gameplay |

# Change management plan
As part of my training for this SAS system, I plan on creating documentation online which details the new features and SAS system. This documentation will also include a 'How it Works' section. Additionally, I plan on publishing my research findings and procedures for others to follow into a workshop or conference. 
To ensure integration, I produced a modular approach to the software, allowing the capability of adding a SAS toggle system. I also plan on performing compatibility testing with different hardware and software configurations to ensure the compatibility with different environments.
To help resolve any discovered bugs, I plan on utilizing the GitHub Issues tab on my GitHub project to get notified of any issues. Additionally, I plan on utilizing the logged data to ensure that the software operates as intended during the testing and logging of the SAS/non SAS game.

# Traceability links
This section associates each of the Artifact Names found within all of the artifacts with a set of requirement IDs
## Use Case Diagram Traceability
| Artifact ID | Artifact Name | Requirement ID |
| :-------------: | :----------: | :----------: |
| Player Basic Operations | Die | FR15 FR21 |
| Player Basic Operations | Consume Entity | FR11 |
| Player Basic Operations | Move | FR16 FR20 NFR18 NFR19 |
| Player Basic Operations | Start Game | FR15 FR18 |
| System Level Interactions | Spawn Enemy Fish | FR1 |
| System Level Interactions | Update Score | FR11 FR12 |
| System Level Interactions | Collision Detection | FR19 |
| System Level Interactions | Game Over | FR17 FR21 |
| System Level Interactions | Restart Game | FR15 |

## Class Diagram Traceability
| Artifact Name | Requirement ID |
| :-------------: |:----------: |
| Framerate Controller | FR6 FR7 FR8 FR9 FR10 |
| Enemy | FR1 FR2 FR3 FR4 FR5 |
| Moving Entity | FR1 FR2 |
| Player | FR16 FR17 FR18 FR19 FR20 |
| Entity | FR1 |
| UI | FR11 FR12 FR13 FR14 FR15 |

## Activity Diagram Traceability

| Artifact ID | Artifact Name | Requirement ID |
| :-------------: | :----------: | :----------: |
| Frame Update | Input | FR18 |
| Frame Update | Check Bounds | FR17 |
| Frame Update | Check Collisions | FR19 FR21 |
| Frame Update | Grow | FR22 |
| Frame Update | Game Over | FR17 FR21 |
| Frame Update | Check Framerate | FR17 FR21 |
| Game Difficulty | Monitor Player Performance | FR2 |
| Game Difficulty | Reduce Difficulty | FR2 |
| Game Difficulty | Increase Difficulty | FR2 |
| Game Difficulty | Adjust Enemy Spawn Rates | FR2 |
| Game Difficulty | Adjust Enemy Movement Speed | FR2 |
| Game Difficulty | Adjust Enemy Size | FR2 |


# Software Artifacts
Below are each of the aforementioned artifacts with embedded links to view them
* [Player Basic Operations](https://github.com/StevenStreasick/GVSU-CIS641-Introverted/blob/main/artifacts/Player%20Basic%20Operations.png)
* [System Level Interactions](https://github.com/StevenStreasick/GVSU-CIS641-Introverted/blob/main/artifacts/System%20Level%20Interactions.png)
* [Frame Update](https://github.com/StevenStreasick/GVSU-CIS641-Introverted/blob/main/artifacts/Frame%20Update.png)
* [Game Difficulty](https://github.com/StevenStreasick/GVSU-CIS641-Introverted/blob/main/artifacts/Game%20Difficulty.png)
