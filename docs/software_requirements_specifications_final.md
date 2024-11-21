# Overview 
 
The purpose of this document is to provide a detailed analysis into the functionality of this software. This document will serve as a blueprint for the construction of the Software, as this document defines what the Software should do and what the software should be capable of.
 
# Functional Requirements 
 
1. New Game
   1.	(R1) The game shall allow the player to start a new game when the current game ends.
2. Enemy Difficulty
   1. (R2) The game shall adjust the enemy size to adjust the difficulty based on the player’s performance
   2. (R3) The game shall adjust the number of enemies to adjust the difficulty based on the player's performance
   3.(R4) The game shall adjust the enemy sight to adjust the difficulty based on the player’s performance
 
# Non-Functional Requirements 
 
1. Framerate
   1.	(R5) The system shall maintain a playable state, above 60 frames per second on a modern device
   2.	(R6) The system shall handle 25 enemies simultaneously, without experiencing a noticeable performance hit
2. End of Game
   1.  (R7) The system shall properly clean up any memory used and free any resources when the program ends
4. OS Support
   1. (R8) The game shall properly run on all common OS Systems such as Linux, Windows, and Mac, without experiencing any issues or problems
