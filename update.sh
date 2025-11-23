#!/usr/bin/env bash
set -euo pipefail

# Update dependencies and generate a new PHP CS Fixer configuration file.

# Determine sed in-place editing option for macOS or Linux
if [[ "$(uname)" == "Darwin" ]]; then
    SED_INPLACE=(-i '')
else
    SED_INPLACE=(-i)
fi

cd "$(dirname "$0")"

echo "Updating dependencies..."
composer update -q

laravel=assets/laravel-ruleset.php
echo "Updating $laravel..."
wget -q -O "$laravel" https://raw.githubusercontent.com/laravel/pint/HEAD/resources/presets/laravel.php
sed "${SED_INPLACE[@]}" '/^use .*;/ { N; d; }' "$laravel"
sed "${SED_INPLACE[@]}" 's/return .*(\[/return [/' "$laravel"
sed "${SED_INPLACE[@]}" 's/]);/];/' "$laravel"

echo "Generating PHP CS Fixer configuration file..."
php generate.php

dirty_src="assets/DirtyExample.php"
dirty_dest="assets/DirtyExample.fixed.php"
echo "Fixing $dirty_src..."
cp "$dirty_src" "$dirty_dest"
./vendor/bin/php-cs-fixer fix "$dirty_dest" --config=.php-cs-fixer.php
