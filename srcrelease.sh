#! /bin/sh

echo Enter version number:
read QUTECSOUND_VERSION

git archive --format tar.gz -v --output csoundqt-${QUTECSOUND_VERSION}-src.tar.gz ${QUTECSOUND_VERSION}

#git clone git://qutecsound.git.sourceforge.net/gitroot/qutecsound/qutecsound csoundqt-$QUTECSOUND_VERSION-src
#git checkout $QUTECSOUND_VERSION
#rm -Rf csoundqt-$QUTECSOUND_VERSION-src/.git
#tar -czf csoundqt-$QUTECSOUND_VERSION-src.tar.gz csoundqt-$QUTECSOUND_VERSION-src
#rm -Rf csoundqt-$QUTECSOUND_VERSION-src

