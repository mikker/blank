tell application "Safari"
    activate
    tell application "System Events"
        tell process "Safari"
            keystroke "l" using {command down}
        end tell
    end tell
end tell

