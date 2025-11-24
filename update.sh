#!/usr/bin/env bash
set -euo pipefail

# Update dependencies and generate new configuration files.

# Determine sed in-place editing option for macOS or Linux
if [[ "$(uname)" == "Darwin" ]]; then
    SED_INPLACE=(-i '')
else
    SED_INPLACE=(-i)
fi

cd "$(dirname "$0")"

echo "Installing dependencies..."
composer install -q

laravel=assets/laravel-ruleset.php
echo "Updating $laravel..."
if curl -fsSL -o "$laravel" https://raw.githubusercontent.com/laravel/pint/HEAD/resources/presets/laravel.php; then
    sed "${SED_INPLACE[@]}" '/^use .*;/ { N; d; }' "$laravel"
    sed "${SED_INPLACE[@]}" 's/return .*(\[/return [/' "$laravel"
    sed "${SED_INPLACE[@]}" 's/]);/];/' "$laravel"
else
    git restore "$laravel"
fi

echo "Generating configuration files..."
php generate.php

echo

dirty_src="assets/DirtyExample.php"
dirty_dest="assets/DirtyExample.fixed.php"
echo "Fix CS for $dirty_src"

cp "$dirty_src" "$dirty_dest"
./vendor/bin/php-cs-fixer fix "$dirty_dest"

cp "$dirty_src" "$dirty_dest"
./vendor/bin/pint "$dirty_dest"
