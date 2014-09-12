#!/bin/bash -x

set -e # exit on error

startStone travis

cd ${GS_HOME}/gemstone/stones/travis

. defStone.env

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
