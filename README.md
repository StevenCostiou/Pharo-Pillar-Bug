## The Pillar bug
Pillar is markup language to generate books.
The bug reproduced in this repository was really hard to understand for the Pillar developers.
It was originally described here https://github.com/guillep/pillar-bug, and was then studied in some papers.

This repository provides code to reproduce the original bug in the following Pharo versions:
- Pharo 13 (Nov 20th, 2024)

## Installation

1) During loading, you will encounter the following error:
   
![Capture d’écran 2024-11-19 à 21 59 02](https://github.com/user-attachments/assets/b6f30f45-3647-4e41-9a9c-ae365a57b0c9)

This is just a notification, proceed with the loading (click `proceed`).

2) To load the **working** version, execute the following baseline:
 ```Smalltalk
   Metacello new
    baseline: 'PillarBug';
    repository: 'github://StevenCostiou/Pharo-Pillar-Bug:main';
    load.
   ```

3) To load the **failing** version, execute the following baseline:
 ```Smalltalk
   Metacello new
    baseline: 'PillarBug';
    repository: 'github://StevenCostiou/Pharo-Pillar-Bug:failure';
    load.
   ```

## Reproducing the Pillar bug

In both versions (working and failing), got into the `Pillar-Tests` package and execute the test `testInclude1FileInto1Include` from the test class `PRFileInclusionTest`.

The test will pass with the working version but raise an error with the failing version.

The problem can be reproduced automatically through the following script, in which case it will execute silently with the working version and raise an error with the failing version:

```Smalltalk
PRFileInclusionTest new setUp; testInclude1FileInto1Include
```
## Credits

The code used in this repository comes from various [SmalltalkHub archived repositories](http://smalltalkhub.com/) , that do not load into recent Pharo images (>13):

- **Grease**: http://smalltalkhub.com/BenoitAstruc/Grease/
- **Magritte**: http://smalltalkhub.com/Magritte/Magritte2/
- **Cocoon**: http://smalltalkhub.com/PharoExtras/Cocoon/
- **LightPhaser**: http://smalltalkhub.com/Pier/LightPhaser/
- **PetitParser**: http://smalltalkhub.com/JanKurs/PetitParser/
- **Pillar**: http://smalltalkhub.com/Pier/Pillar/
