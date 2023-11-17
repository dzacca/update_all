#!/bin/bash
#
# Setting up variables
# 
export PATH=$PATH:/usr/local/go/bin
export APT=`which nala`
export TEX=`which tlmgr` >>/dev/null 2>&1
export FLATPAK=`which flatpak` >>/dev/null 2>&1
export CONDA=`which conda` >>/dev/null 2>&1
export RUST=`which rustup` >>/dev/null 2>&1

if [[ ${APT} =~ "nala" ]];
then
  export NALA="true"
else
  export NALA="false"
fi

if [[ ${NALA} =~ "false" ]];
then
  sudo ${APT} update
fi

# execute
echo "Updating base system..."
sudo ${APT} upgrade -y
sudo ${APT} dist-upgrade -y
sudo ${APT} autoremove --purge -y

# Flatpak update
#
if [[ ${FLATPAK} =~ "flatpak" ]];
then
  echo
  echo "Updating flatpak..."

  sudo ${FLATPAK} update -y
  ${FLATPAK} update -y
  sudo ${FLATPAK} update --system -y
fi

# TeX Live update
#
echo 
echo "Updating TeX Live..."

if [[ ${TEX} =~ "tlmgr" ]]; then
  sudo tlmgr update --repository ctan --self --all
fi

# Conda
#
echo
echo "Updating Conda..."

if [[ ${CONDA} =~ "conda" ]];
then
  ${CONDA} update --update-all -y
fi

# Rust
#
echo
echo "Updating Rust..."

if [[ ${RUST} =~ "rustup" ]];
then
  ${RUST} update
fi
