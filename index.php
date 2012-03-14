<title>test</title>
<?php
	include_once('database.php');
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

	#echo('<pre>');
	#print_r($ss->getClientRecords());
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

<?php

}

?>

<script>
<!--
	var rurl = '';
	function returnUrl(n, v) {
		if (rurl == '') {
			rurl = 'updatesession.php?token=<?php echo $returnToken ?>';
		}
		if (n && v) {
			rurl = rurl + '&' + n + '=' + v;
		}
		return rurl;
	}

	returnUrl('iw', window.innerWidth);
	returnUrl('ih', window.innerHeight);

	var d = new Date();
	returnUrl('toff', Math.round(<?php echo time()?> - d.getTime()/1000));

	document.write('<img src="' + returnUrl() + '">');
	
	//document.write('<a href="' + returnUrl() + '&verbose=1">updatesession.php</a>');

-->
</script>


<?php
#print_query_log();