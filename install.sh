if command -v jq &> /dev/null; then
    echo ""
else
    brew install jq
fi

echo $(mkdir -p ~/jap/plugins/packages/ && curl -o ~/jap/plugins/packages/webgrab.sh https://raw.githubusercontent.com/philipstuessel/web-grab/main/webgrab.sh)
echo "--Web Grab is installed--"