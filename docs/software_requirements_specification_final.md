# Overview
<Describe the purpose of this document in 1 paragraph of less … hint: it is your SRS>

# Software Requirements
<Describe the structure of this section>

## Functional Requirements
### <Enemy Logic>
| ID | Requirement |
| :-------------: | :----------: |
| FR1 | Enemies shall spawn enemies at random intervals in random positions offscreen |
| FR2 | The game shall adjust the enemy size, number of enemies, and enemy sight to adjust the difficulty based on the player’s performance |
| FR3 | The SAS system must update the difficulty of the game (FR2) when the player's score updates |
| FR4 | The game shall adjust the enemy size, number of enemies, and enemy sight to adjust the framerate of the game |
| FR5 | Enemies shall follow the player when the player is within the enemies sight |

### <Framerate SAS>
| ID | Requirement |
| :-------------: | :----------: |
| FR6 | The zoom level should dynamically adjust based on player performance and happiness |
| FR7 | Happiness should increase with higher framerates and decrease with lower ones |
| FR8 | Zoom changes must not disorient the player |
| FR9 | Happiness should influence overall game behavior (e.g., difficulty) |
| FR10 | <> |

### <>
| ID | Requirement |
| :-------------: | :----------: |
| FR11 | <> |
| FR12 | <> |
| FR13 | <> |
| FR14 | <> |
| FR15 | <> |

### <>
| ID | Requirement |
| :-------------: | :----------: |
| FR16 | <> |
| FR17 | <> |
| FR18 | <> |
| FR19 | <> |
| FR20 | <> |

### <>
| ID | Requirement |
| :-------------: | :----------: |
| FR21 | <> |
| FR22 | <> |
| FR23 | <> |
| FR24 | <> |
| FR25 | <> |

## Non-Functional Requirements
### <>
| ID | Requirement |
| :-------------: | :----------: |
| NFR1 | <> |
| NFR2 | <> |
| NFR3 | <> |
| NFR4 | <> |
| NFR5 | <> |

### <>
| ID | Requirement |
| :-------------: | :----------: |
| NFR6 | <> |
| NFR7 | <> |
| NFR8 | <> |
| NFR9 | <> |
| NFR10 | <> |

### <>
| ID | Requirement |
| :-------------: | :----------: |
| NFR11 | <> |
| NFR12 | <> |
| NFR13 | <> |
| NFR14 | <> |
| NFR15 | <> |

### <>
| ID | Requirement |
| :-------------: | :----------: |
| NFR16 | <> |
| NFR17 | <> |
| NFR18 | <> |
| NFR19 | <> |
| NFR20 | <> |

### <>
| ID | Requirement |
| :-------------: | :----------: |
| NFR21 | <> |
| NFR22 | <> |
| NFR23 | <> |
| NFR24 | <> |
| NFR25 | <> |

# Change management plan
<Description of what this section is>

# Traceability links
<Description of this section>
## Use Case Diagram Traceability
| Artifact ID | Artifact Name | Requirement ID |
| :-------------: | :----------: | :----------: |
| UseCase1 | Move Player | FR5 |
| … | … | … |
## Class Diagram Traceability
| Artifact Name | Requirement ID |
| :-------------: |:----------: |
| classPlayer | NFR3, FR5 |
| … | … | … |
## Activity Diagram Traceability

<In this case, it makes more sense (I think, feel free to disagree) to link
to the file and to those requirements impacted>
| Artifact ID | Artifact Name | Requirement ID |
| :-------------: | :----------: | :----------: |
| <filename> | Handle Player Input | FR1-5, NFR2 |
| … | … | … |

# Software Artifacts
<Describe the purpose of this section>
* [I am a link](to_some_file.pdf)