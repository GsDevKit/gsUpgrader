#!/bin/bash -x

set -e # exit on error

startStone travis

cd ${GS_HOME}/gemstone/stones/travis

. defStone.env

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
