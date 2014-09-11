gsUpgrader [![Build Status](https://travis-ci.org/GsDevKit/gsUpgrader.svg?branch=master)](https://travis-ci.org/GsDevKit/gsUpgrader)
=========

Utility class to perform upgrades for GLASS, GLASS1 and Metacello.

##Upgrading

### GLASS1

The most common usage pattern is to upgrade to the latest version of [GLASS1](https://github.com/glassdb/glass#glass-):

```Smalltalk
Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
```

The above expression has been tested with against GLASS versions as old as `1.0-beta.8.7.1`.

### Metacello

**GsUpgrader** can also be used to upgrade to the latest version of [Metacello](https://github.com/dalehenrich/metacello-work#install-preview-version) independent of GLASS1:

```Smalltalk
Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
```

## Why use GsUpgrader

The current GLASS ecosystem is being converted from using the monticello-based repositories [GemSource](http://seaside.gemtalksystems.com/ss/) and [SS3](http://ss3.gemtalksystems.com/) to using the github-based repositories [glassdb](https://github.com/glassdb) and [GsDevKit](https://github.com/GsDevKit). 

As part of the conversion we are converting from using **ConfigurationOfGLASS** to **BaselineOfGLASS1**, from **ConfigurationOfMetacello** to **BaselineOfMetacello** and from **ConfigurationOfGrease** to **BaselineOfGrease**. 

To make a smooth conversion it is necessary to use the latest version of **Metacello**, but it can be difficult to use **Metacello** to upgrade itself, so the **GsUpgrader** class was created to provide a finer level of control and make sure that the upgrades are performed in the correct order.

Once you start using [tode](https://github.com/dalehenrich/tode#tode-the-object-centric-development-environment-), it isn't necessary to use **GsUpgrader**. The tODE command `project load Metacello` is equivalent to:

```Smalltalk
Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
```

and the tODE command `project load GLASS1` is equivalent to: 

```Smalltalk
Gofer new
  package: 'GsUpgrader-Core';
  url: 'http://ss3.gemtalksystems.com/ss/gsUpgrader';
  load.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
```

but it may be necessary to use **GsUpgrader** to install tODE.
