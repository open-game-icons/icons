#!/usr/bin/env fish

argparse v/verbose -- $argv; or return

function log
    echo (status basename): $argv >&2
end

if not set -q argv[1]
    echo 'nothing to do (no args given)' >&2
    exit 0
end

function inkscape_wrapper
    if set -q _flag_verbose
        inkscape --shell
    else
        inkscape --shell &>/dev/null
    end
end

set svgo_flags
if not set -q _flag_verbose
    set svgo_flags -q
end

log 'inkscape: convert strokes to paths and ungroup objects'
# Hard-coded to 3 groups deep
for f in $argv
    echo "file-open:$f;
select-all:all; object-stroke-to-path;
select-all:all; selection-ungroup;
select-all:all; selection-ungroup;
select-all:all; selection-ungroup;
export-filename:$f;
export-do;
file-close;
"
end | inkscape_wrapper

log svgo
svgo $svgo_flags -- $argv

log 'remove black background square and some superfluous tags'
sd '<path\\b[^/]*\\bd="M(0|512) (0|512)([hvHV](0|512)){3}[zZ]"[^/]*/>| xml:space="preserve"| style="height:512px;width:512px"' '' $argv

log 'inkscape: union all paths'
for f in $argv
    echo "file-open:$f;
select-all:all; path-union;
export-filename:$f;
export-do;
file-close;
"
end | inkscape_wrapper

log svgo
svgo $svgo_flags -- $argv

log 'restore black background square and ensure path fill is white'
# shellcheck disable=SC2016
sd '^(<svg [^>]*>)(<path )' '$1<path d="M0 0h512v512H0z"/>${2}fill="#fff" ' $argv

log 'remove any remaining style tags'
sd ' style="[^"]*"' '' $argv

log svgo
svgo $svgo_flags -- $argv

log done
