
#!/bin/bash

set -euo pipefail

DOWNLOAD_URI=hhttps://github.com/Lobster-King/ProjectCleaner/files/369255/ProjectCleaner.xcplugin.zip
PLUGINS_DIR="${HOME}/Library/Application Support/Developer/Shared/Xcode/Plug-ins"
XCODE_VERSION="$(xcrun xcodebuild -version | head -n1 | awk '{ print $2 }')"
PLIST_PLUGINS_KEY="DVTPlugInManagerNonApplePlugIns-Xcode-${XCODE_VERSION}"
BUNDLE_ID="com.lobster.ProjectCleaner"
TMP_FILE="$(mktemp -t ${BUNDLE_ID})"


if defaults read com.apple.dt.Xcode "$PLIST_PLUGINS_KEY" &> "$TMP_FILE"; then

/usr/libexec/PlistBuddy -c "delete skipped:$BUNDLE_ID" "$TMP_FILE" > /dev/null 2>&1 && {
pgrep Xcode > /dev/null && {
echo 'An instance of Xcode is currently running.' \
'Please close Xcode before installing ProjectCleaner.'
exit 1
}
defaults write com.apple.dt.Xcode "$PLIST_PLUGINS_KEY" "$(cat "$TMP_FILE")"
echo 'Alcatraz was removed from Xcode'\''s skipped plugins list.' \
'Next time you start Xcode select "Load Bundle" when prompted.'
}
else

KNOWN_WARNING="The domain/default pair of \(.+, $PLIST_PLUGINS_KEY\) does not exist"

# tr: For some mysterious reason, some `defaults` errors are outputed on two lines.
# grep: -v returns 1 when output is empty (ie. we filtered the known warning)
# so we exit on 0, which means an unknown error occured.
tr -d '\n' < "$TMP_FILE" | egrep -v "$KNOWN_WARNING" && exit 1
fi
rm -f "$TMP_FILE"

# Download and install Alcatraz
mkdir -p "${PLUGINS_DIR}"
curl -L $DOWNLOAD_URI | tar xvz -C "${PLUGINS_DIR}"

beer='🍻'
# the 1 is not a typo!
omg_one_meme='!!1!' # the 1 is not a typo
# the 1 is not a typo!
echo "ProjectCleaner successfully installed$omg_one_meme$beer " \
"Please restart your Xcode ($XCODE_VERSION)."



