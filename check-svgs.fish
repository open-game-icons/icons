#!/usr/bin/env fish
# Check for any unoptimized SVG files

if not type -q rg
    echo 'command not found: rg' >&2
    echo 'ensure ripgrep is installed and available on your PATH' >&2
    exit 1
end

set success 0

# For all icons, check:
# - Icon size is 512x512
# - Icon has a black 512x512 background
# - Icon has exactly one white foreground path
# - No superfluous attributes are present
set icon_regex '^<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M0 0h512v512H0z"/><path fill="#fff" d="[^"]*"/></svg>$'
if not rg --invert-match --files-with-matches $icon_regex -- **/*.svg | rg --invert-match badges/
    echo 'All icons are optimized' >&2
else
    set success 1
end

# For all badges, check:
# - Badge size is 256x256
# - Badge has a black circular background of radius 128
# - Badge has a white circular border of radius 101 and stroke width 18
# - Badge has exactly one white foreground path
# - No superfluous attributes are present
set badge_regex '^<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 256 256"><circle cx="128" cy="128" r="128"/><circle stroke="#fff" stroke-width="18" cx="128" cy="128" r="101"/><path fill="#fff" d="[^"]*"/></svg>$'
if not rg --invert-match --files-with-matches $badge_regex badges/*.svg | rg --invert-match blank
    echo 'All badges are optimized' >&2
else
    set success 1
end

exit $success
