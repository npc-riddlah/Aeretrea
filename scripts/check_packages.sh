#!/bin/bash
#LOOK HERE! In order to add packages in scripts please, add it and analogues in PKG_LIST_* vars.

  PKG_LIST_DEBIAN=("attr" "ccache" "clang" "git" "golang" "libbrotli-dev" "libgtest-dev" "liblz4-dev" "libpcre2-dev" "libprotobuf-dev" "libunwind-dev" "libusb-1.0-0-dev" "libzstd-dev" "lld" "openjdk-11-jdk" "protobuf-compiler" "zipalign")
  PKG_LIST_ARCH_PACMAN=("yaourt" "attr" "ccache" "clang" "git" "go" "brotli" "gtest" "lz4" "pcre2" "protobuf" "libunwind" "libusb" "zstd" "lld" "jre11-openjdk" "protobuf-c" "zip")
  PKG_LIST_ARCH_AUR=("android-sdk-build-tools")
  PKG_LIST_FEDORA=("attr" "ccache" "clang" "git" "go" "brotli" "gtest" "lz4" "pcre2" "protobuf" "libunwind" "libusb" "zstd" "lld" "jre11-openjdk" "protobuf-c" "zip")
  PKG_DISTRO_NAME=$(cat /etc/*-release)

  PKG_NOT_INSTALLED=("")
  PKG_NOT_INSTALLED_AUR=("")

check_packages() {
  PKG_DONE="true"

  case $PKG_DISTRO_NAME in
    *Manjaro*|*Arch*)
      echo_info "Checking packages for your Manjaro Linux"
      for i in ${PKG_LIST_ARCH_PACMAN[@]};
      do
        if pacman -Q $i > /dev/null; then
          echo_ok "$i"
        else
          PKG_DONE="false"
          echo_no "$i"
          PKG_NOT_INSTALLED+=($i);
        fi
      done
      for i in ${PKG_LIST_ARCH_AUR[@]};
      do
        if yaourt -Q $i > /dev/null; then
          echo_ok "$i"
        else
          PKG_DONE="false"
          echo_no "$i"
          PKG_NOT_INSTALLED_AUR+=($i);
        fi
      done
      if [[ "$PKG_DONE" == "true" ]]
      then
        echo_info "Configuring packages..."
        sudo archlinux-java set java-11-openjdk
      fi
    ;;
    *Ubuntu*|*Debian*|*Mint*)
      echo_info "Checking packages for your (Sub)Debian Linux"
      for i in ${PKG_LIST_DEBIAN[@]};
      do
        if dpkg -l $i; then
          echo_ok "$i"
        else
          PKG_DONE=false
          echo_no "$i"
          PKG_NOT_INSTALLED+=($i);
        fi
      done
    ;;
    *Fedora*)
      echo_info "Checking packages for your Fedora Linux"
      for i in ${PKG_LIST_FEDORA[@]};
      do
        if dnf list installed | grep -q $i; then
          echo_ok "$i"
        else
          PKG_DONE=false
          echo_no "$i"
          PKG_NOT_INSTALLED+=($i);
        fi
      done
    ;;
    *)
      echo_err "Your distro not supported! Try launch with --skip-pkg flag to ignore this step.\n Be Patient: absence of packages may lead to broken installation. In this case install packages and clean ./out folder."
      return 2
    ;;
  esac
  if [[ "$PKG_DONE" == "false" ]]
  then
    echo_err "Your installation missing packages:\n ${PKG_NOT_INSTALLED[*] ${PKG_NOT_INSTALLED_AUR[*]}}"
    return 1
  fi
  return 0
}

install_packages() {
  echo_info "Proceeding Installation"
  case $PKG_DISTRO_NAME in
  *Manjaro*|*Arch*)
    sudo pacman -Sy $PKG_NOT_INSTALLED
    sudo yaourt -Sy $PKG_NOT_INSTALLED_AUR
  ;;
  *Ubuntu*|*Debian*|*Mint*)
    sudo apt install -y $PKG_NOT_INSTALLED
  ;;
  *)
    echo_err "Your distro not supported! Try launch with --skip-pkg flag to ignore this step.\n Be Patient: absence of packages may lead to broken installation. In this case install packages and clean ./out folder."
    return 2
  ;;
  esac
  return 0
}

check_packages
if [ "$?" == "2" ]; then
    install_packages
fi

