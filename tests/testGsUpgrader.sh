#!/bin/bash -x

set -e # exit on error

startStone travis

cd ${BASE}/gemstone/stones/travis

. defStone.env

echo "=================================="
echo "TESTING: upgradeGLASS, upgradeMetacello, upgradeGLASS1"
echo "=================================="

topaz -l -q -T50000 <<EOF
iferr 1 stk
iferr 2 stack
iferr 3 exit 1
login
run
Metacello new
  baseline: 'GsUpgrader';
  repository: 'filetree://${BASE}/repository';
  load.
(Smalltalk at: #GsUpgrader) upgradeGLASS.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
%

exit 
EOF

stopStone travis
stoneExtent travis
startStone travis

echo "=================================="
echo "TESTING: upgradeGLASS, upgradeMetacello, upgradeGLASS1, upgradeGLASS, upgradeMetacello, upgradeGLASS1"
echo "=================================="

topaz -l -q -T50000 <<EOF
iferr 1 stk
iferr 2 stack
iferr 3 exit 1
login
run
Metacello new
  baseline: 'GsUpgrader';
  repository: 'filetree://${BASE}/repository';
load.
(Smalltalk at: #GsUpgrader) upgradeGLASS.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
(Smalltalk at: #GsUpgrader) upgradeGLASS.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
%

exit 
EOF

stopStone travis
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
Metacello new
  baseline: 'GsUpgrader';
    repository: 'filetree://${BASE}/repository';
      load.
(Smalltalk at: #GsUpgrader) upgradeMetacello.
%

exit
EOF

stopStone travis
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
Metacello new
  baseline: 'GsUpgrader';
      repository: 'filetree://${BASE}/repository';
            load.
(Smalltalk at: #GsUpgrader) upgradeGLASS1.
%

exit 
EOF

