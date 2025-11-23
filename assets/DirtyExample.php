<?php



namespace   App\Example;

use  Illuminate\Support\Str;
use DateTime ;
use App\Models\User;
use  App\Models\UnusedModel;


class   DirtyExample  extends   \stdClass
{


public    $foo=   'bar'  ;



public function   testMethod( $a= array("x"=>1,"y" => 2  ,  "z"  =>3 , )   )
{


     $var= 1+2  ;
  $text =  "hello" ;
 $list=[  'a' ,    'b',  'c'    ];


$date= new  DateTime(  "now"  );
$result =
Str::of(  $text )->  trim()
  ->upper(   )
-> append(  "!"  ) ;



/**
* test doc
   * more text
    @param string $text
  @return  array
*/
   $arr=  [
'x'   =>1,
 'y'=> [ 1,2 ,3],
   'z'=> array(
  "a"  =>   123 ,

 ),

   ];



return    array(
    "user"     =>   new  User( ),
    "result"    => $result ,
"text"=>$text,


);



}
}
