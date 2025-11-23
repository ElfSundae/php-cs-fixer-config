# PHP CS Fixer Config

Generate PHP CS Fixer and Laravel Pint configuration files based on Laravel’s official coding style, with a few lightweight custom enhancements.

This project includes:

- `update.sh`: Update dependencies and regenerate all config files.
- `generate.php`: Build the final config files.
- Pre-generated [`.php-cs-fixer.php`](https://raw.githubusercontent.com/ElfSundae/php-cs-fixer-config/HEAD/.php-cs-fixer.php) and [`pint.json`](https://raw.githubusercontent.com/ElfSundae/php-cs-fixer-config/HEAD/pint.json) ready for direct use.

## Usage

Run the generator:

```sh
./update.sh
```

Or regenerate configs manually:

```sh
php generate.php
```

The resulting `.php-cs-fixer.php` and `pint.json` at the project root can be used directly in your PHP projects.
