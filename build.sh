#!/bin/bash

cd ubuntu-kernel

#VFIO patches
echo Applying patches
patch -p1 < ../patches/vfio/0001-i915-Add-module-option-to-support-VGA-arbiter-on-HD-.patch
patch -p1 < ../patches/vfio/0001-pci-Enable-overrides-for-missing-ACS-capabilities-4..patch

#Configs
echo Copying configs
cp -r -f -v config/** ubuntu-kernel/debian.master/config/

#Build
echo Build
fakeroot debian/rules clean
corecount=$(grep -c ^processor /proc/cpuinfo)
fakeroot make -j$corecount olddefconfig bindeb-pkg LOCALVERSION=-enas-1

echo Done!