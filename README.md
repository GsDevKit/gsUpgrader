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

The **GsUpgrader** class can be loaded into GLASS versions as old as [GLASS1.0-beta.8.7.1](http://gemstonesoup.wordpress.com/2011/11/21/glass-1-0-beta-8-7-1-released/).

The **GsUpgrader** class provides 4 different upgrade entry points: 

- [upgrade GLASS](#gsupgrader-classupgradeglass) 
- [upgrade GLASS1](#gsupgrader-classupgradeglass1)
- [upgrade Grease](#gsupgrader-classupgradegrease)
- [upgrade Metacello](#gsupgrader-classupgrademetacello)

**Note**: *If you have locked one of the projects: GLASS1, Grease, or Metacello then the lock will be honored. 
If you have locked one of the projects and the repository does not match the default repository location, then you will be responsible for handling the upgrade yourself.*

| project | default repository location |
|---------|-------------------|
| GLASS1  | github://glassdb/glass:master/repository |
| Grease  | github://GsDevKit/Grease:master/repository |
| Metacello | github://dalehenrich/metacello-work:master/repository |

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

