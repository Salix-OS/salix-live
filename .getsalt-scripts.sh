#!/bin/sh
# vim: set syn=sh et ai sw=2 st=2 ts=2 tw=0:
#
# Used to download the correct version of SaLT Scripts and SaLT.

cd "$(dirname "$0")"
SALT_SCRIPTS_VER='trunk'
SALT_SCRIPTS_URL="https://salix.svn.sourceforge.net/svnroot/salix/salix-live/SaLT/SaLT-scripts/$SALT_SCRIPTS_VER"
if [ -d salt-scripts ]; then
  rm -rf salt-scripts || echo "salt-scripts directory cannot be removed, check permissions" >&2
fi
svn export "$SALT_SCRIPTS_URL" salt-scripts
# get SaLT too
(
  cd salt-scripts
  ./.getsalt.sh
)
# install symlinks
for a in 32 64 arm; do
  if [ -d $a ]; then
    for f in salt-scripts/*; do
      ln -s ../$f $a/
    done
  fi
done
