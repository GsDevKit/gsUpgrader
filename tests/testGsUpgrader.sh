#!/bin/bash -x

set -e # exit on error

cd ${GS_HOME}/gemstone/stones/travis
. defStone.env

# UPGRADE_TEST : ALL_UPGRADE, TEST_GLASS1, TEST_GREASE, TEST_SEASIDE312, TEST_SEASIDE313, UPGRADE_GLASS, UPGRADE_GLASS1, UPGRADE_METACELLO 

case "${UPGRADE_TEST}" in
	"ALL_UPGRADE")
		stoneExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGLASS, upgradeMetacello, upgradeGrease, upgradeGLASS1, upgradeGLASS, upgradeMetacello, upgradeGrease, upgradeGLASS1"
		echo "=================================="
		topaz -l -q -T50000 <<EOF
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
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%
run
(Smalltalk at: #GsUpgrader) upgradeGLASS.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
(Smalltalk at: #GsUpgrader) upgradeGrease.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
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
%
print
(Smalltalk at: #GsUpgrader) metacelloReport
%

exit 
EOF
		stopStone travis
		;;
	"TEST_GLASS1")
		stoneExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGLASS1 and run tests"
		echo "=================================="
		topaz -l -q -T50000 <<EOF
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
		stoneExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGrease and run tests"
		echo "=================================="
		topaz -l -q -T50000 <<EOF
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
(Smalltalk at: #GsUpgrader) upgradeGrease.
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
	"TEST_SEASIDE312")
		stoneExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: Seaside3.1.2 and run tests"
		echo "=================================="
		topaz -l -q -T50000 <<EOF
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
(Smalltalk at: #GsUpgrader) upgradeGrease.
GsDeployer deploy: [
  Metacello new
    baseline: 'Seaside3';
    repository: 'github://GsDevKit/Seaside31:v3.1.2-gs/repository';
    onLock: [:ex | ex honor];
    load: #('CI') ].
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
	"TEST_SEASIDE313")
		stoneExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: Seaside3.1.3 and run tests"
		echo "=================================="
		topaz -l -q -T50000 <<EOF
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
(Smalltalk at: #GsUpgrader) upgradeGrease.
GsDeployer deploy: [
  Metacello new
    baseline: 'Seaside3';
    repository: 'github://GsDevKit/Seaside31:v3.1.3-gs/repository';
    onLock: [:ex | ex honor];
    load: #('CI') ].
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
		stoneExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGLASS"
		echo "=================================="
		topaz -l -q -T50000 <<EOF
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
(Smalltalk at: #GsUpgrader) upgradeGLASS.
%

exit 
EOF
		stopStone travis
		;;
	"UPGRADE_GLASS1")
		stoneExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGLASS1"
		echo "=================================="
		topaz -l -q -T50000 <<EOF
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
	"UPGRADE_GREASE")
		stoneExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeGrease"
		echo "=================================="
		topaz -l -q -T50000 <<EOF
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
(Smalltalk at: #GsUpgrader) upgradeGrease
%

exit 
EOF
		stopStone travis
		;;
	"UPGRADE_METACELLO")
		stoneExtent travis
		startStone travis
		echo "=================================="
		echo "TESTING: upgradeMetacello"
		echo "=================================="
		topaz -l -q -T50000 <<EOF
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
(Smalltalk at: #GsUpgrader) upgradeMetacello.
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
