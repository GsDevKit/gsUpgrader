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

- [upgrade GLASS](#gsupgrader-class>>upgradeglass) 
- [upgrade GLASS1](#gsupgrader-class>>upgradeglass1)
- [upgrade Grease](#gsupgrader-class>>upgradegrease)
- [upgrade Metacello](#gsupgrader-class>>upgrademetacello)

### GsUpgrader class>>upgradeGLASS

```Smalltalk
ConfigurationOfGLASS project updateProject.
GsDeployer
  deploy: [ (ConfigurationOfGLASS project version: '1.0-beta.9.3') load ].
```

### GsUpgrader class>>upgradeGLASS1

The most common usage pattern is to upgrade to the latest version of [GLASS1](https://github.com/glassdb/glass#glass-):

```Smalltalk
Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
```

The above expression has been tested with against GLASS versions as old as `1.0-beta.8.7.1`.

### GsUpgrader class>>upgradeGrease

### GsUpgrader class>>upgradeMetacello

The most common usage pattern is to upgrade to the latest version of [Metacello](https://github.com/dalehenrich/metacello-work#install-preview-version). Metacello itself :

```Smalltalk
Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
```

