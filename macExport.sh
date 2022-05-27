# !/bin/bash
# Run on source mac to prepare ~/Library items for migrating

mkdir ~/Desktop/Library
pushd .
cd ~/Desktop/Library

items=(Colors ColorPickers "Keyboard Layouts" "Keyboard" "KeyboardServices" QuickLook Scripts Services Sounds StickiesDatabase)
for item in "${items[@]}"
do
    cp -r ~/Library/"$item" .
done

mkdir ~/Desktop/Library/Application\ Support
items=("Little Snitch" Charles)
for item in "${items[@]}"
do
    cp -r ~/Library/Application\ Support/"$item" .
done

mkdir -p ~/Desktop/Library/Developer/Xcode
cp -r  ~/Library/Developer/Xcode/UserData ./Developer/Xcode

mkdir ~/Desktop/Library/Preferences
cp ~/Library/Preferences/com.apple.dt* ./Preferences
popd
