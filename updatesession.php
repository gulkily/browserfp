<?php
	include_once('database.php');
	include_once('sherlock.php');

	$ss = new SherlockSession($db);

	$ss->populateFromGlobals($GLOBALS);

	if ($ss->getValidationToken()) {
	#todo this should be optimized so that the old session is only loaded once
		$ssRelated = $ss->getRelatedSession($ss->old_session_id);
		$ss->updateRelatedSession($ssRelated);
		$ss->setClientByFingerprints();
	}


	#$ss->storeSession();

	#$valid = $_GET['token'];

	#$ss->populateFromGlobals($GLOBALS);

	print_query_log();