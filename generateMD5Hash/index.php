<?php

    if(isset($_POST["text"])) {
        echo md5($_POST["text"])."<br /><br />";
    }

?>
<form method="post" action="index.php">
    <input type="text" placeholder="type your text here" name="text" />
    <br />
    <input type="submit">
</form>