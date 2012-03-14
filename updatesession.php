<?php
	include_once('database.php');
	include_once('sherlock.php');

	$ss = new SherlockSession($db);

	$ss->populateFromGlobals($GLOBALS);

	if ($ss->getValidationToken()) {
		$ss->updateRelatedSession($ss->old_session_id);
		$ss->setClientByFingerprints();
	}


	$ss->storeSession();

	#$valid = $_GET['token'];

	#$ss->populateFromGlobals($GLOBALS);

	print_query_log();