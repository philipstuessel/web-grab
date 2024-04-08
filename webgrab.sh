wg_check() {
    if [ ! -f "$(pwd)/webgrab.json" ]; then
        echo "${RED}webgrab.json File not found${NC}"
        return 1
    fi
    return 0
}

wg_core() {
    if [[ -z "$2" ]]; then
        DIR=$(pwd)
    else
        if [ ! -d "$2" ]; then
            mkdir -p "$2"
        fi
        DIR="$2"
    fi

    if [[ -e "$1" ]]; then
        cp "$1" ${DIR}/"$(basename "$1")" >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "🚛 ${UNDERLINE}$1${NC} ${MAGENTA}->${NC} ${DIR}"
        else
            echo "🚚 ${RED}$1${NC} ${MAGENTA}->${NC} ${DIR}"
        fi
    else
        curl -o "${DIR}/$(basename "$1")" "$1" >/dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo "🚛 ${UNDERLINE}$1${NC} ${MAGENTA}->${NC} ${DIR}"
        else
            echo "🚚 ${RED}$1${NC} ${MAGENTA}->${NC} ${DIR}"
        fi
    fi
}

wg() {
    if [[ "$1" == "v" || "$1" == "-v" ]]; then
        echo "${BLUE}Web Grab 🚛${NC}"
        echo "${BOLD}v.0.1.1${NC}"
        echo "${YELLOW}JAP plugin${NC}"
    elif [[ "$1" == "i" || "$1" == "install" ]]; then
        wg_check
        json=$(cat webgrab.json)
        urls=$(echo "$json" | jq -r 'to_entries[] | .key + " " + .value')
        
        while IFS= read -r url; do
            key=$(echo "$url" | cut -d ' ' -f 1)
            value=$(echo "$url" | cut -d ' ' -f 2)
            wg_core $key $value
        done <<< "$urls"
    else
        wg_core "$1" "$2"
    fi
}
