#!/usr/bin/env php
<?php

require __DIR__.'/vendor/autoload.php';

use Brick\VarExporter\VarExporter;

$outputFile = __DIR__.'/.php-cs-fixer.php';

$rules = array_merge(
    require __DIR__.'/assets/laravel-ruleset.php',
    require __DIR__.'/assets/custom-rules.php'
);
ksort($rules);

$content = file_get_contents(__DIR__.'/assets/.php-cs-fixer.template.php');
$content = str_replace("['{{exported}}']", VarExporter::export(
    $rules, VarExporter::INLINE_SCALAR_LIST | VarExporter::TRAILING_COMMA_IN_ARRAY
), $content);
file_put_contents($outputFile, $content);

exec(__DIR__.'/vendor/bin/pint '.escapeshellarg($outputFile));

echo 'Generated PHP CS Fixer configuration file: '.$outputFile.PHP_EOL;
