<?php
	
	include_once('test.php');

	$ss = new SherlockSession($db);

	$ss->populateFromGlobals($GLOBALS);

