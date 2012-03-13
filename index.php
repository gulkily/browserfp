<title>test</title>
<?php
	include_once('sherlock.php');

	$ss = new SherlockSession($db);

	$ss->populateFromGlobals($GLOBALS);

	$ss->storeSession();

	$fav_color = $ss->getClientVariable('favorite_color');

	if (!$fav_color) {
		$fav_color = '#';
		$fav_color .= dechex(mt_rand(192,255));
		$fav_color .= dechex(mt_rand(192,255));
		$fav_color .= dechex(mt_rand(192,255));

		$ss->setClientVariable('favorite_color', $fav_color);
	}

	$client_id = $ss->getClientId();
	#$probability = $ss->probability; #todo  make method

	$clientName = $ss->getClientVariable('name');

	$print_client_name_form = false;

	if (!$clientName) {
		if (isset($_GET['name'])) {
			$clientName = $_GET['name'];
			$ss->setClientVariable('name',$clientName);
		} else {
			$clientName = "(undefined)";

			$print_client_name_form = true;
		}
	}

	#$screen_res_token = $ss->generateScreenResolutionToken();

	$returnToken = $ss->getReturnToken();
?>

<table border=1>
<tr><td>client id:</td><td><?php echo $client_id ?></td></tr>
<tr><td>name:</td><td bgcolor="<?php echo $fav_color ?>"><?php echo $clientName ?></td></tr>
</table>

<?php

if ($print_client_name_form) {
?>

<p><hr>
<form>
<input type=text name=name>
<input type=submit value=save>
</form>

<script>
<!--
	var returnToken = '<?php echo $returnToken ?>';

	var iw = window.innerWidth;
	var ih = window.innerHeight;
	
	document.write('<a href="updatesession.php?token=' + returnToken + '">updatesession.php</a>');

-->
</script>

<?php

}