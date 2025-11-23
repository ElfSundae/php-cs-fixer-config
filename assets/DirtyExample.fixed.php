<?php

namespace App\Example;

use App\Models\User;
use DateTime;
use Illuminate\Support\Str;

class DirtyExample extends \stdClass
{
    public $foo = 'bar';

    public function testMethod($a = ['x' => 1, 'y' => 2,  'z' => 3])
    {

        $var = 1 + 2;
        $text = 'hello';
        $list = ['a',    'b',  'c'];

        $date = new DateTime('now');
        $result =
        Str::of($text)->trim()
            ->upper()
            ->append('!');

        /**
         * test doc
         * more text
         @param string $text
  @return  array
         */
        $arr = [
            'x' => 1,
            'y' => [1, 2, 3],
            'z' => [
                'a' => 123,

            ],

        ];

        return [
            'user' => new User,
            'result' => $result,
            'text' => $text,

        ];

    }
}
