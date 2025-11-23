#!/usr/bin/env bash
set -euo pipefail

# Update dependencies and generate a new PHP CS Fixer configuration file.

if [[ "$(uname)" == "Darwin" ]]; then
    SED_INPLACE=(-i '')
else
    SED_INPLACE=(-i)
fi

cd "$(dirname "$0")"

laravel=assets/laravel-ruleset.php
echo "Updating $laravel..."
wget -q -O "$laravel" https://raw.githubusercontent.com/laravel/pint/HEAD/resources/presets/laravel.php
sed "${SED_INPLACE[@]}" '/^use .*;/ { N; d; }' "$laravel"
sed "${SED_INPLACE[@]}" 's/return .*(\[/return [/' "$laravel"
sed "${SED_INPLACE[@]}" 's/]);/];/' "$laravel"

echo "Updating dependencies..."
composer update -q

echo "Generating PHP CS Fixer configuration file..."
php generate.php
