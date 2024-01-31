#!/bin/bash
#
# Setting up variables
#
export PATH=$PATH:/usr/local/go/bin
APT=$(which nala)
TEX=$(which tlmgr) >>/dev/null 2>&1
FLATPAK=$(which flatpak) >>/dev/null 2>&1
CONDA=$(which conda) >>/dev/null 2>&1
RUST=$(which rustup) >>/dev/null 2>&1
SNAP=$(which snap) >>/dev/null 2>&1

export APT
export TEX
export FLATPAK
export CONDA
export RUST
export SNAP

if [[ ${APT} =~ "nala" ]]; then
  export NALA="true"
else
  export NALA="false"
fi

if [[ ${NALA} =~ "false" ]]; then
  sudo "${APT}" update
fi

# execute
#
echo "############################################################"
echo "Updating base system..."
sudo "${APT}" upgrade -y
sudo "${APT}" dist-upgrade -y
sudo "${APT}" autoremove --purge -y

# Snaps update
#
if [[ ${SNAP} =~ "snap" ]]; then
  echo
  echo "############################################################"
  echo "Updating snaps..."
  sudo snap refresh
fi

# Flatpak update
#
if [[ ${FLATPAK} =~ "flatpak" ]]; then
  echo
  echo "############################################################"
  echo "Updating flatpak..."

  sudo "${FLATPAK}" update -y
  "${FLATPAK}" update -y
  sudo "${FLATPAK}" update --system -y
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

if
  [[ ${CONDA} =~ "conda" ]]
  echo
  echo "############################################################"
  echo "Updating Conda..."
then
  ${CONDA} update --update-all -y
fi

# Rust
#
if
  [[ ${RUST} =~ "rustup" ]]
  echo
  echo "############################################################"
  echo "Updating Rust..."
then
  ${RUST} update
fi

# rtl8821ce driver
#
RTLDIR="/home/$(whoami)/dev/rtl8821ce"
export RTLDIR
if [[ -d ${RTLDIR} ]]; then
  echo
  echo "############################################################"
  echo "Pulling latest rtl8821ce driver..."
  cd ${RTLDIR}
  git pull -q
  cd -
fi
