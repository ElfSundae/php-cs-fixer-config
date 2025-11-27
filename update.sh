#!/usr/bin/env bash
set -euo pipefail

# Install dependencies and generate new configuration files.

# `sed -i` replacement function compatible with Linux/macOS.
sed_in_place() {
    if sed --version >/dev/null 2>&1; then
        sed -i "$@"
    else
        sed -i '' "$@"
    fi
}

cd "$(dirname "$0")"

echo "Installing dependencies..."
composer install -q

laravel=assets/laravel-ruleset.php
echo "Updating $laravel..."
if curl -fsSL -o "$laravel" https://raw.githubusercontent.com/laravel/pint/HEAD/resources/presets/laravel.php; then
    sed_in_place '/^use .*;/ { N; d; }' "$laravel"
    sed_in_place 's/return .*(\[/return [/' "$laravel"
    sed_in_place 's/]);/];/' "$laravel"
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
