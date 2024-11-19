
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
