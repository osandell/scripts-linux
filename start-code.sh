/run/current-system/sw/bin/code $1 >/dev/null 2>&1 &

hyprctl dispatch workspace 2

# Run the command up to 5 times until we get a match
for i in {1..5}; do
    sleep 3

    json_data=$(hyprctl -j clients)

    # Use jq to parse the output and check if any object has a "class" property set to "code-url-handler"
    match_found=$(echo "$json_data" | jq 'map(select(.class == "code-url-handler")) | length')

    # Check if match was found
    if [[ -n "$match_found" && $match_found -gt 0 ]]; then
        exit 0
    fi

    /run/current-system/sw/bin/code $1 >/dev/null 2>&1 &
done

echo "Reached maximum attempts. No match found."
