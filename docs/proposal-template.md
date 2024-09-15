Team name: Introverted

Team members:
Steven Streasick

# Introduction

This project will consist of creating and testing one method of implementing a de-centralized Self Adapating System (SAS) within the game development environment. The central idea is to implement two SAS agents, each governing a distinct but counteracting objective. To encourage cooperation between these systems, a "Happiness" metric will be introduced. This happiness metric will act as an overview of the current state of the SAS system, to allow for external systems to make decisions without exposing the underlying data of the SAS. 
e SAS system measures its current state and provides the other SAS with a overview of its data. This focus on happiness distinguishes this project from previous projects and provides a new spin on the traditional method of creating decentralized systems.

While previous research has examined SAS in various contexts, none have specifically addressed the challenges or benefits of decentralized SAS within the unique constraints of game design. This project will try to address this. The success of this project will be determined by the system's ability to adapt to imposed constraints while maintaining the desired balance between framerate and difficulty. A successful project will demonstrate the potential of decentralized SAS to enhance game design.

# Anticipated Technologies

We suspect that the only technologies that will be required to build this project be Git/GitHub and GoDot 4.

# Method/Approach

We plan on recreating the game Feesh within the game engine GoDot as a test environment. Within this environment, we plan on allowing one SAS system control the framerate of the game. Additionally, we plan on allowing a second SAS system control the enemy AI of the game. Due to the conflicting goals of the two SAS systems, we plan to introduce an additional constraint on the AI SAS, requiring it to ensure that the FPS SAS maintains a satisfactory 'happiness' level.

# Estimated Timeline
                 
The first major milestone for this project will be getting the base game implemented. I anticipate that this portion may take up to two weeks of the semester and may take up to a month. The next milestone would be implementing the SAS controls over the game. I anticipate that this take another two or three weeks of the semester. The last milestone would be producing all expected deliverables, which I anticipate could take anywhere from two weeks to a month.  

# Anticipated Problems

One of the major problems that I foresee is not knowing how to do something within GoDot. With how many resources are available online, I anticipate that this problem will only be a temporary problem that can be fairly easily resolved. I also anticipate that getting the SAS system to work together will be difficult in one form or another, because of their conflicting goals. Lastly, I anticipate that time may be a problem, especially as the semester continues and the workload increases.