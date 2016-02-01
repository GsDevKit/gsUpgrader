#!/bin/bash -x

set -e # exit on error

# UPGRADE_TEST : ALL_UPGRADE, 
#                TEST_FILETREE, TEST_GLASS1, TEST_GREASE, TEST_GREASE_GLASS1, TEST_SEASIDE31X, TEST_ZINC_2XX, 
#                UPGRADE_GLASS, UPGRADE_GLASS1, UPGRADE_GLASS1_GsDevKit, UPGRADE_GsDevKit, UPGRADE_METACELLO, UPGRADE_GsDevKit_home_GLASS

case "${UPGRADE_TEST}" in
	"ALL_UPGRADE")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGLASS, upgradeMetacello, upgradeGrease, upgradeGLASS1, upgradeGLASS, upgradeMetacello, upgradeGrease, upgradeGLASS1, upgradeGsDevKit"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
login
run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%
run
(Smalltalk at: #GsUpgrader) upgradeGLASS.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
(Smalltalk at: #GsUpgrader) upgradeGrease.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
false ifTrue: [ (Smalltalk at: #GsUpgrader) upgradeGsDevKit ].
%
run
Transcript 
  cr; show: '==================================';
  cr; show: 'test re-upgrades';
  cr; show: '=================================='.
(Smalltalk at: #GsUpgrader) upgradeGLASS.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
(Smalltalk at: #GsUpgrader) upgradeGrease.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
false ifTrue: [ (Smalltalk at: #GsUpgrader) upgradeGsDevKit ].
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%

exit 
EOF
		stopStone travis
		;;
	"TEST_FILETREE")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeMetacello install and run FileTree tests"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
set user SystemUser p swordfish
login

# synchronize timezones
run
TimeZone default: TimeZone fromLinux
%
commit
logout

set user DataCurator p swordfish
login

run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
%
run
Metacello new
  baseline: 'FileTree';
  repository: 'github://dalehenrich/filetree:gemstone2.4/repository';
  load: 'Tests'.
(Smalltalk at: #GsUpgrader) upgradeGLASS1
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%
# if there are defects, display the failures and set test failure flag
level 1
run
| results defects |
UserGlobals at: #TEST_FAILURE put: false. 
results := TestCase suite run .
(defects := results errors asArray, results unexpectedFailures asArray) isEmpty 
  ifTrue: [ ^results printString ].
UserGlobals at: #TEST_FAILURE put: true.
defects := defects collect: [:each | each printString ].
^defects
%
# if the test failure flag is set, throw an error and inform travis of the failure
run
TEST_FAILURE ifTrue: [nil error: 'test failures'].
%
exit 
EOF
		stopStone travis
		;;
	"TEST_ISSUE_3")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: Issue #3"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
login

run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
Gofer new
  package: 'ConfigurationOfGrease';
  url: 'http://smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main';
  load.
(Smalltalk at: #GsUpgrader) upgradeGLASS.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
%
run
Transcript cr; show: '++++Loading Grease configuration'.
Metacello new
  configuration: 'Grease';
  version: #'release1.0';
  repository: 'http://smalltalkhub.com/mc/Seaside/MetacelloConfigurations/main';
  load.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
%
exit 
EOF
		stopStone travis
		;;
	"TEST_GLASS1")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGLASS1 and run tests"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
set user SystemUser p swordfish
login

# synchronize timezones
run
TimeZone default: TimeZone fromLinux
%
commit
logout

set user DataCurator p swordfish
login

run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%
run
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%
# if there are defects, display the failures and set test failure flag
level 1
run
| results defects |
UserGlobals at: #TEST_FAILURE put: false. 
results := TestCase suite run .
(defects := results errors asArray, results unexpectedFailures asArray) isEmpty 
  ifTrue: [ ^results printString ].
UserGlobals at: #TEST_FAILURE put: true.
defects := defects collect: [:each | each printString ].
^defects
%
# if the test failure flag is set, throw an error and inform travis of the failure
run
TEST_FAILURE ifTrue: [nil error: 'test failures'].
%
exit 
EOF
		stopStone travis
		;;
	"TEST_GREASE")
		# NOTE - the tests for GREASE do not pass without loading GLASS1
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: install and run Grease tests"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
set user SystemUser p swordfish
login

# synchronize timezones
run
TimeZone default: TimeZone fromLinux
%
commit
logout

set user DataCurator p swordfish
login
run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
(Smalltalk at: #GsUpgrader) upgradeGrease.
(Smalltalk at: #Metacello) image
  baseline: 'Grease';
  load: 'Tests'.
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%
# if there are defects, display the failures and set test failure flag
level 1
run
| results defects |
UserGlobals at: #TEST_FAILURE put: false. 
results := TestCase suite run .
(defects := results errors asArray, results unexpectedFailures asArray) isEmpty 
  ifTrue: [ ^results printString ].
UserGlobals at: #TEST_FAILURE put: true.
defects := defects collect: [:each | each printString ].
^defects
%
# if the test failure flag is set, throw an error and inform travis of the failure
run
TEST_FAILURE ifTrue: [nil error: 'test failures'].
%
exit 
EOF
		stopStone travis
		;;
	"TEST_GREASE_GLASS1")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGLASS1 and install and run Grease tests"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
set user SystemUser p swordfish
login

# synchronize timezones
run
TimeZone default: TimeZone fromLinux
%
commit
logout

set user DataCurator p swordfish
login
run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%
run
(Smalltalk at: #GsUpgrader) upgradeGrease.
(Smalltalk at: #Metacello) image
  baseline: 'Grease';
  load: 'Tests'.
(Smalltalk at: #GsUpgrader) upgradeGLASS1
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%
# if there are defects, display the failures and set test failure flag
level 1
run
| results defects |
UserGlobals at: #TEST_FAILURE put: false. 
results := TestCase suite run .
(defects := results errors asArray, results unexpectedFailures asArray) isEmpty 
  ifTrue: [ ^results printString ].
UserGlobals at: #TEST_FAILURE put: true.
defects := defects collect: [:each | each printString ].
^defects
%
# if the test failure flag is set, throw an error and inform travis of the failure
run
TEST_FAILURE ifTrue: [nil error: 'test failures'].
%
exit 
EOF
		stopStone travis
		;;
	"TEST_GSDEVKIT")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGsDevKit and run tests"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
set user SystemUser p swordfish
login

# synchronize timezones
run
TimeZone default: TimeZone fromLinux
%
commit
logout

set user DataCurator p swordfish
login

run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%
run
(Smalltalk at: #GsUpgrader) upgradeGsDevKit.
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%
# if there are defects, display the failures and set test failure flag
level 1
run
| results defects |
UserGlobals at: #TEST_FAILURE put: false. 
results := TestCase suite run .
(defects := results errors asArray, results unexpectedFailures asArray) isEmpty 
  ifTrue: [ ^results printString ].
UserGlobals at: #TEST_FAILURE put: true.
defects := defects collect: [:each | each printString ].
^defects
%
# if the test failure flag is set, throw an error and inform travis of the failure
run
TEST_FAILURE ifTrue: [nil error: 'test failures'].
%
exit 
EOF
		stopStone travis
		;;
	"TEST_SEASIDE31X")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: Seaside3.1.x and run tests"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
set user SystemUser p swordfish
login

# synchronize timezones
run
TimeZone default: TimeZone fromLinux
%
commit
logout

set user DataCurator p swordfish
login
run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
(Smalltalk at: #GsUpgrader) upgradeGrease.
%
run
GsDeployer deploy: [
  Metacello new
    baseline: 'Seaside3';
    repository: 'github://GsDevKit/Seaside31:gs_master/repository';
    onLock: [:ex | ex honor];
    load: #('CI') ].
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%
# if there are defects, display the failures and set test failure flag
level 1
run
| results defects |
UserGlobals at: #TEST_FAILURE put: false. 
results := TestCase suite run .
(defects := results errors asArray, results unexpectedFailures asArray) isEmpty 
  ifTrue: [ ^results printString ].
UserGlobals at: #TEST_FAILURE put: true.
defects := defects collect: [:each | each printString ].
^defects
%
# if the test failure flag is set, throw an error and inform travis of the failure
run
TEST_FAILURE ifTrue: [nil error: 'test failures'].
%
exit 
EOF
		stopStone travis
		;;
	"TEST_ZINC_2XX")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: Zinc2.x.x and run tests"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
set user SystemUser p swordfish
login

# synchronize timezones
run
TimeZone default: TimeZone fromLinux
%
commit
logout

set user DataCurator p swordfish
login
run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
(Smalltalk at: #GsUpgrader) upgradeGrease
%
run
GsDeployer deploy: [
  Metacello new
    baseline: 'ZincHTTPComponents';
    repository: 'github://GsDevKit/zinc:gs_master/repository';
    onLock: [:ex | ex honor];
    load: #('Tests') ].
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%
# if there are defects, display the failures and set test failure flag
level 1
run
| results defects |
UserGlobals at: #TEST_FAILURE put: false. 
results := TestCase suite run .
(defects := results errors asArray, results unexpectedFailures asArray) isEmpty 
  ifTrue: [ ^results printString ].
UserGlobals at: #TEST_FAILURE put: true.
defects := defects collect: [:each | each printString ].
^defects
%
# if the test failure flag is set, throw an error and inform travis of the failure
run
TEST_FAILURE ifTrue: [nil error: 'test failures'].
%
exit 
EOF
		stopStone travis
		;;
	"UPGRADE_GLASS")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGLASS"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
login
run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
(Smalltalk at: #GsUpgrader) upgradeGLASS.
%

exit 
EOF
		stopStone travis
		;;
	"UPGRADE_GLASS1")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGLASS1"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 2 stack
iferr 3 exit 1
login
run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
%

exit 
EOF
		stopStone travis
		;;
	"UPGRADE_GLASS1_GsDevKit")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGLASS1 then upgradeGsDevKit"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
login
run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
(Smalltalk at: #GsUpgrader) upgradeGsDevKit.
%

exit 
EOF
		stopStone travis
		;;
	"UPGRADE_GREASE")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGrease"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
login
run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
(Smalltalk at: #GsUpgrader) upgradeGrease
%

exit 
EOF
		stopStone travis
		;;
	"UPGRADE_GREASE_GLASS1")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGrease then upgradeGLASS1"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
login
run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
(Smalltalk at: #GsUpgrader) upgradeGrease.
(Smalltalk at: #GsUpgrader) upgradeGLASS1
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%

exit 
EOF
		stopStone travis
		;;
	"UPGRADE_GsDevKit")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGsDevKit"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
login
run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
(Smalltalk at: #GsUpgrader) upgradeGsDevKit
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%

exit 
EOF
		stopStone travis
		;;
	"UPGRADE_METACELLO")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeMetacello"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 3 exit 1
login
run
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
%

exit
EOF
		stopStone travis
		;;
	"UPGRADE_GsDevKit_home_GLASS")
		newExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: UPGRADE_GsDevKit_home_GLASS"
		echo "=================================="
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 2 stack
iferr 3 exit 1
login
run
| sysDefaultServer |
sysDefaultServer := (GsFile
  _expandEnvVariable: 'GS_HOME'
  isClient: false), '/sys/default/server'.
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
Transcript
  cr;
  show: '-----Upgrade GLASS caching into ', sysDefaultServer.
(Smalltalk at: #'GsUpgrader')
  upgradeGLASSForGsDevKit_home: '${GS_VERSION}'
%

exit 
EOF
		newExtent travis
		startTopaz travis -l -q -T50000 <<EOF
iferr 1 stk
iferr 2 stack
iferr 3 exit 1
login
run
| sysDefaultServer |
sysDefaultServer := (GsFile
  _expandEnvVariable: 'GS_HOME'
  isClient: false), '/sys/default/server'.
Gofer new
  package: 'GsUpgrader-Core';
  repository: (MCDirectoryRepository new 
                 directory: (ServerFileDirectory on: '${BASE}/monticello'));
  load.
Transcript
  cr;
  show: '-----Upgrade GLASS loading from ', sysDefaultServer.
(Smalltalk at: #'GsUpgrader')
  upgradeGLASSForGsDevKit_home: '${GS_VERSION}'
%

exit 
EOF
		stopStone travis
		;;
	*)
		echo "unknown value of \$UPGRADE_TEST : $UPGRADE_TEST"
		exit 1
		;;
esac
