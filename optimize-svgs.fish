#!/usr/bin/env fish

# Convert strokes to paths and ungroup objects (hard-coded to 3 groups deep)
for f in $argv
    echo 'file-open:'$f';
select-all:all; object-stroke-to-path;
select-all:all; selection-ungroup;
select-all:all; selection-ungroup;
select-all:all; selection-ungroup;
export-filename:'$f';
export-do;
file-close;
'
end | inkscape --shell

svgo -- $argv

# Remove black background square to enable path-union, and remove some
# superfluous tags that SVGO can't easily remove
sd '<path\\b[^/]*\\bd="M(0|512) (0|512)([hvHV](0|512)){3}[zZ]"[^/]*/>| xml:space="preserve"| style="height:512px;width:512px"' '' $argv

# Union all paths
for f in $argv
    echo 'file-open:'$f';
select-all:all; path-union;
export-filename:'$f';
export-do;
file-close;
'
end | inkscape --shell

svgo -- $argv

# Add black background square back and ensure path fill is white
# shellcheck disable=SC2016
sd '^(<svg [^>]*>)(<path )' '$1<path d="M0 0h512v512H0z"/>${2}fill="#fff" ' $argv

# Remove any remaining style tags
sd ' style="[^"]*"' '' $argv

svgo -- $argv
