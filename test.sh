#! /bin/bash

TEST_CMD="xcodebuild -scheme QToasterSwift -workspace QToasterSwift -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 5,OS=9.1' build test"

which -s xcpretty
XCPRETTY_INSTALLED=$?

if [[ $TRAVIS || $XCPRETTY_INSTALLED == 0 ]]; then
eval "${TEST_CMD} | xcpretty"
else
eval "$TEST_CMD"
fi