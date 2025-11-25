<?php

return [
    'preset' => 'laravel',
    'rules' => require __DIR__.'/custom-rules.php',
    'exclude' => [
        'third',
        'legacy',
    ],
];
