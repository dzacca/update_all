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
#
echo "############################################################"
echo "Updating base system..."
sudo ${APT} upgrade -y
sudo ${APT} dist-upgrade -y
sudo ${APT} autoremove --purge -y

# Flatpak update
#
if [[ ${FLATPAK} =~ "flatpak" ]];
then
  echo
  echo "############################################################"
  echo "Updating flatpak..."

  sudo ${FLATPAK} update -y
  ${FLATPAK} update -y
  sudo ${FLATPAK} update --system -y
fi

# TeX Live update
#

if [[ ${TEX} =~ "tlmgr" ]]; then
  echo 
  echo "############################################################"
  echo "Updating TeX Live..."

  sudo tlmgr update --repository ctan --self --all
fi

# Conda
#

if [[ ${CONDA} =~ "conda" ]];
  echo
  echo "############################################################"
  echo "Updating Conda..."

then
  ${CONDA} update --update-all -y
fi

# Rust
#
if [[ ${RUST} =~ "rustup" ]];
  echo
  echo "############################################################"
  echo "Updating Rust..."

then
  ${RUST} update
fi

# rtl8821ce driver
#
export RTLDIR="/home/`whoami`/dev/rtl8821ce"
if [[ -d ${RTLDIR} ]];
then
  echo
  echo "############################################################"
  echo "Pulling latest rtl8821ce driver..."
  cd ${RTLDIR}
  git pull -q
  cd -
fi
