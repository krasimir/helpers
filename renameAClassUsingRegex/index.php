<?php

    $content = '

        \$test = 20;
        \$var = 10;

        class TestA {
            public functon methods() {

            }
        }

        class TestB{
            public functon methods() {
                
            }
        }

        // more code here

    ';

    $customPart = "ohyeah";

    var_dump("before -------------------------- ");
    var_dump($content);
    var_dump("after -------------------------- ");
    $content = preg_replace("/class (\S{1,})\s?\{/", "class $1_".$customPart." {", $content);
    var_dump($content);

?>