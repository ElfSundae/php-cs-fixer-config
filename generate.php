#!/usr/bin/env php
<?php

require __DIR__.'/vendor/autoload.php';

use Brick\VarExporter\VarExporter;

$pcfConfigFile = __DIR__.'/.php-cs-fixer.php';
$pintConfigFile = __DIR__.'/pint.json';

$customRules = require __DIR__.'/assets/custom-rules.php';

// Generate php-cs-fixer config file
$pcfRules = array_merge(require __DIR__.'/assets/laravel-ruleset.php', $customRules);
ksort($pcfRules);

$pcfConfig = file_get_contents(__DIR__.'/assets/.php-cs-fixer.template.php');
$pcfConfig = str_replace("['{{exported}}']", VarExporter::export(
    $pcfRules, VarExporter::INLINE_SCALAR_LIST | VarExporter::TRAILING_COMMA_IN_ARRAY
), $pcfConfig);
file_put_contents($pcfConfigFile, $pcfConfig);
echo 'Generated PHP CS Fixer configuration file: '.$pcfConfigFile.PHP_EOL;

// Generate Laravel Pint config file
$pintConfig = [
    'preset' => 'laravel',
    'rules' => $customRules,
];
file_put_contents($pintConfigFile, json_encode(
    $pintConfig, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES
));
echo 'Generated Laravel Pint configuration file: '.$pintConfigFile.PHP_EOL;
