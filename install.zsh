#!/bin/zsh
if command -v jq &> /dev/null; then
    echo ""
else
    brew install jq
fi

source ~/.zshrc
fetch ~/jap/plugins/packages/ ~/jap/plugins/packages/webgrab.zsh https://raw.githubusercontent.com/philipstuessel/web-grab/main/webgrab.zsh
echo "--Web Grab is installed--"