# Open Game Icons

All SVG icons available on [Open Game Icons](https://open-game-icons.net), forked from [game-icons/icons](https://github.com/game-icons/icons).

## Contribution

Contributions are welcomed!
Have a look at [CONTRIBUTING.md](CONTRIBUTING.md) for guidance.

## Scripts

This repo includes a few shell scripts for various batch tasks.

### `optimize-svgs.sh`

Convert the given SVGs into an standard "optimized" format to reduce file size and ensure they work on every platform.

Depends on [Inkscape](https://inkscape.org/) and [SVGO](https://svgo.dev/).

```sh
# Run on a specific SVG
./optimize-svg.sh my-icon.svg

# Run on all SVGs
./optimize-svg.sh **/*.svg
```

**WARNING**: This will change the structure of your SVG files and may ruin them!
I suggest committing the original version of your icon to the repo before running this, and/or making a backup copy of it outside the repo first.

This script is a bit hacky, so if you can't this it working for your icon (e.g. if you just end up with a white or black square, or an invalid SVG), don't worry about it.
Just contribute what you have.

### `check-svgs.sh`

Checks for any unoptimized SVG files.
Run this before deploying new icons to the website.

Depends on [ripgrep](https://github.com/BurntSushi/ripgrep).

### `colorize-svgs.sh`

By default, all the provided icons in this repository have a white foreground on a black background.
You may need them in other color combinations.

The `colorize-svgs.sh` script takes two optional arguments, the first one for the foreground color in hexadecimal,
the second one for the background color also in hexadecimal or with the special value `transparent`.

```sh
# red on green
./colorize-svgs.sh '#f00' '#0f0'

# blue on transparent
./colorize-svgs.sh '#0011da' 'transparent'
```

The generated SVG files are created in the gitignored `_out` directory.

### `rasterize-svgs.sh`

This script walks through the whole content of the `_out` directory and generates an optimized PNG file for every SVG file it encounters.
So it means, that if you want to rasterize the default collection of white on black icons:

```sh
# first copy the default SVG file to "_out" directory
./colorize-svgs.sh

# then generate one PNG file for each SVG file
./rasterize-svgs.sh
```

Depending on the power of your machine, the execution of the script may take a while (no parallel executions yet).

### `rebuild_db.sh`

This deletes and rebuilds the SQLite database `icons.db` from the contents of `icons.sql`.
This is only necessary if you want to run an instance of the website yourself, or if you're a developer interested in querying the database.

Depends on [SQLite](https://sqlite.org/index.html) 3.

## License

See [license.txt](license.txt).
