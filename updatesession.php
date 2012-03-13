<?php
	include_once('database.php');
	include_once('sherlock.php');

	$ss = new SherlockSession($db);

	$ss->populateFromGlobals($GLOBALS);

	echo('<pre>');
	print_r($ss->fingerprints);

	$ss->storeSession();

	#$valid = $_GET['token'];

	#$ss->populateFromGlobals($GLOBALS);

	print_query_log();