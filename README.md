gsUpgrader [![Build Status](https://travis-ci.org/GsDevKit/gsUpgrader.svg?branch=master)](https://travis-ci.org/GsDevKit/gsUpgrader)
=========

Utility class to perform upgrades for GLASS, GLASS1, Grease and Metacello.

The current GLASS ecosystem is being converted from using the monticello-based repositories [GemSource](http://seaside.gemtalksystems.com/ss/) and [SS3](http://ss3.gemtalksystems.com/) to using the github-based repositories [glassdb](https://github.com/glassdb) and [GsDevKit](https://github.com/GsDevKit). At the end of the day, you should be using the latest github versions of Metacello, Grease and GLASS1, but getting to that point can be challenging. The main challenge is that in order to correctly load a project like [Seaside31](https://github.com/GsDevKit/Seaside31#seaside31), one must be using the latest version of Metacello and the process for correctly loading the latest version of Metacello depends upon what version of GLASS/GLASS1 you are using. 

The **GsUpgrader** class provides a simple solution for upgrading the various projects. The **GsUpgrader** class queries the image and determines the proper projects to upgrade in the proper sequence.

The **GsUpgrader** class is delivered in a single Monticello package available from [SS3](http://ss3.gemtalksystems.com/). Gofer is used to load the package thus eliminating any dependency upon Metacello:

```Smalltalk
Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
```

The **GsUpgrader** class can be loaded into GLASS versions as old as GLASS1.0-beta.8.1 (GemStone 2.4.4.1).

The **GsUpgrader** class provides 4 different upgrade entry points and a diagnostic entry point: 

- [upgrade GLASS](#gsupgrader-classupgradeglass) 
- [upgrade GLASS1](#gsupgrader-classupgradeglass1)
- [upgrade Grease](#gsupgrader-classupgradegrease)
- [upgrade Metacello](#gsupgrader-classupgrademetacello)
- [diagnostics]((#gsupgrader-classmetacelloreport)

**Note**: *If you have locked one of the projects: GLASS1, Grease, or Metacello then the lock will be honored. 
If you have locked one of the projects and the repository does not match the default repository location, then you will be responsible for handling the upgrade yourself.*

| project | default repository location |
|---------|-------------------|
| GLASS1  | github://glassdb/glass:master/repository |
| Grease  | github://GsDevKit/Grease:master/repository |
| Metacello | github://dalehenrich/metacello-work:master/repository |

---

---

### GsUpgrader class>>upgradeGLASS

**upgradeGLASS** ensures that your image is upgraded to GLASS1.0-beta.9.3:

```Smalltalk
Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
(Smalltalk at: #GsUpgrader) upgradeGLASS.
```

If your image has already been upgrade to GLASS1.0-beta.9.3 or beyond, no changes will be made. so it is safe to use **upgradeGLASS** at any time.

---

### GsUpgrader class>>upgradeGLASS1

**upgradeGLASS1** ensures that your image is upgraded to the latest version of [GLASS1](https://github.com/glassdb):

```Smalltalk
Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
```

**upgradeGLASS1** will run **[upgradeGLASS](#gsupgrader-classupgradeglass)** (if necessary), **[upgradeMetacello](#gsupgrader-classupgrademetacello)**, and **[upgradeGrease](#gsupgrader-classupgradegrease)**.

**Note**: *If you have locked the GLASS1 project and referenced a different repository than `github://glassdb/glass:master/repository`, you will be responsible for handling the upgrade yourself.*

---

### GsUpgrader class>>upgradeGrease

**upgradeGrease** ensures that your image is upgraded to the latest version of [Grease](https://github.com/GsDevKit/Grease):

```Smalltalk
Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
(Smalltalk at: #GsUpgrader) upgradeGrease.
```

**upgradeGrease** will run **[upgradeMetacello](#gsupgrader-classupgrademetacello)**, and lock the Grease project, using the default repository (`github://glassdb/glass:master/repository`).

**Note**: *If you have locked the Grease project and referenced a different repository than `github://GsDevKit/Grease:master/repository`, you will be responsible for handling the upgrade yourself.*

### GsUpgrader class>>upgradeMetacello

**upgradeMetacello** ensures that your image is upgraded to the latest version of [Metacello](https://github.com/dalehenrich/metacello-work):

```Smalltalk
Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
```

**upgradeMetacello** does not upgrade any other projects.

**Note**: *If you have locked the Metacello project and referenced a different repository than `github://dalehenrich/metacello-work:master/repository`, you will be responsible for handling the upgrade yourself.*

---

### GsUpgrader class>>metacelloReport

If an error occurs while running one of the scripts, it is helpful to produce some diagnostic information. The diagnostic information would be most useful if you could produce a before and after report using the the following workspace:

```Smalltalk
Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
(Smalltalk at: #GsUpgrader) metacelloReport.
```

The **metacelloReport** method produces a report that looks like the following:

```
------------------------
Metacello Version REPORT
------------------------
1. ConfigurationOfGLASS	1.0-beta.8.7.1	#'release'
2. ConfigurationOfGofer	1.0.5.1	#'release'
3. ConfigurationOfGoferProjectLoader	1.0-alpha2.2	#'development'
4. ConfigurationOfGrease	1.0.6.4	#'release'
5. ConfigurationOfGsCore	0.245.1	#'release'
6. ConfigurationOfGsMisc	0.240	#'release'
7. ConfigurationOfGsMonticello	0.242	#'release'
8. ConfigurationOfGsOB	0.242	#'release'
9. ConfigurationOfGsSqueakCommon	0.9.2	#'release'
10. ConfigurationOfMetacello	1.0-beta.31.1	#'release'
--------------
PACKAGE REPORT
--------------
Announcements.g-dkh.15
Base-Bootstrap-dkh.20
Bootstrap-dkh.201
Change-Notification-dkh.7
ConfigurationOfGLASS-dkh.201
ConfigurationOfGofer-dkh.36
ConfigurationOfGoferProjectLoader-DaleHenrichs.21
ConfigurationOfGrease-dkh.176
ConfigurationOfGsCore-dkh.241
ConfigurationOfGsMisc-dkh.88
ConfigurationOfGsMonticello-dkh.143
ConfigurationOfGsOB-dkh.83
ConfigurationOfGsSqueakCommon-dkh.19
ConfigurationOfMetacello-dkh.648
Core-dkh.55
GemStone-245-Exceptions-dkh.1
GemStone-ANSI-Streams-DaleHenrichs.5
GemStone-Deployment-dkh.22
GemStone-Exceptions-dkh.56
GemStone-Indexing-Extensions-dkh.3
GemStone-Release-Support.v2x-dkh.61
Gofer-Core.gemstone-dkh.135
GoferProjectLoader-DaleHenrichs.25
Grease-Core-lr.66
Grease-GemStone-Core-dkh.47
Grease-GemStone200-Core-dkh.2
Grease-GemStone240-Core-dkh.3
GsRandom-obi.7
GsSqueakCommon-Core-dkh.8
GsSqueakCommon-Core.2x-dkh.2
GsSqueakCommon-Tests-DaleHenrichs.1
GsUpgrader-Core-dkh.12
JadeServer-dkh.13
Metacello-Base-DaleHenrichs.19
Metacello-Core-dkh.468
Metacello-MC-dkh.531
Metacello-Platform.gemstone-dkh.23
Metacello-ToolBox-dkh.107
Monticello.g-dkh.440
OB-GemStone-Platform-dkh.68
OB-Metacello-dkh.82
OB-Monticello-DaleHenrichs.103
OB-Standard.g-dkh.437
OB-SUnitGUI.g-dkh.60
OB-SUnitIntegration-dkh.10
OB-Tools.g-dkh.129
OmniBrowser-DaleHenrichs.447
PackageInfo-Base.g-dkh.36
Regex-Core-DaleHenrichs.3
Regex-Tests-Core-DaleHenrichs.5
SMTPMail-dkh.10
Sport3.010-dkh.28
Squeak-dkh.279
System-Digital-Signatures-dkh.5
Utf8Encoding.230-DaleHenrichs.23
```

---

