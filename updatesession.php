<?php
	include_once('database.php');
	include_once('sherlock.php');

	$ss = new SherlockSession($db);

	$valid = $_GET['token'];

	#$ss->populateFromGlobals($GLOBALS);

