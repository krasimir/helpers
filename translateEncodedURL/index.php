<?php

	require("./map.php");

	$text = isset($_POST["text"]) ? $_POST["text"] : "";

	if($text != "") {

		function translate($text) {
			global $map;
			foreach($map as $item) {
				$text = str_replace($item[1], $item[0], $text);
			}
			return $text;
		}

		$params = explode("?", $text);

		$result = '';
		$result .= 'URL: '.$params[0]."<br /><br />";

		if(isset($params[1])) {
			$variables = explode("&", $params[1]);
			foreach($variables as $variable) {
				$result .= translate($variable)."<br /><br />";
			}
		}

		echo '<div>'.$result.'</div>';

	}

?>
<form method="post" action="index.php">
	<textarea name="text" style="width:500px; height:300px;"><?php echo $text; ?></textarea>
	<br />
	<input type="submit">
</form>