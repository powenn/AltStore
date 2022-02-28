#!/bin/bash

set -ex

# cd script dir
cd "$(dirname "$0")" || exit

GIT_ROOT=$(pwd)

rm -rf build Payload AltStore.ipa

xcodebuild -workspace "$GIT_ROOT/AltStore.xcworkspace" \
 -scheme AltStore -configuration Release \
 -derivedDataPath "$GIT_ROOT/build" \
 -destination 'generic/platform=iOS' \
 -sdk iphoneos \
 clean build \
 CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=NO CODE_SIGNING_REQUIRED=NO \
 PRODUCT_BUNDLE_IDENTIFIER="com.rileytestut.AltStore" \

ldid -S -M build/Build/Products/Release-iphoneos/AltStore.app
ln -sf build/Build/Products/Release-iphoneos Payload
zip -r9 AltStore.ipa Payload/AltStore.app
