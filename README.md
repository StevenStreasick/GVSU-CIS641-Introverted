# Introverted

This project will consist of creating and testing one method of implementing a de-centralized Self Adapating System (SAS) within the game development environment. The current plan of attack is to have each SAS system control a counteracting goal. To encourage cooperation between these SAS systems, we will introduce a 'Happiness' metric that one of the systems must satisfy based on the state of the other. For simplicity sake, we plan on only implementing two counteracting SAS agents. While similar studies such as this one have been done before, none have previously analyzed the impact that de-centralized SAS systems have within the game environment world. 

## Team Members and Roles

* [Steven Streasick](https://github.com/StevenStreasick/GVSU-CIS641-Introverted/tree/main) https://github.com/StevenStreasick

## Prerequisites
GoDot 4.3 - Stable release

## Run Instructions
Download the ZIP file from the public repo. Then open GoDot and select 'Import'. GoDot will recognize and handle all of the project setup if you provide a zip file during this import process. After the project is created, the project can be played by pressing the 'Run Project' button in the top right. 

## Data Collection
The game will automatically create a folder under %app_data%/Godot/app_userdata/[PROJECT NAME] called 'sas_data'. The data will begin being collected 15 seconds after the game has started and will end 45 seconds after the game has started. When the data finishes collecting, a print out statement will display within the output stating 'Times up'. Each run will be automatically logged into a new text file, where each file following the naming scheme 'Run i.txt'

## Relevant Artifacts and Documents

* [Software Requirements Specification](https://github.com/StevenStreasick/GVSU-CIS641-Introverted/blob/main/docs/software_requirements_specification.md)
* [Proposal](https://github.com/StevenStreasick/GVSU-CIS641-Introverted/blob/main/docs/proposal-template.md)
