<?php
	include_once('database.php');
	include_once('sherlock.php');

	$ss = new SherlockSession($db);

	$ss->populateFromGlobals($GLOBALS);

	$ss->storeSession();

	if ($ss->getValidationToken()) {
		$ss_old = new SherlockSession($db);
		$ss_old->loadFromSession($ss->old_session_id);
		
		foreach($ss->fingerprints as $key => $value) {
			if (!isset($ss_old->fingerprints[$key])) {
				$ss_old->storeSessionRecord($ss_old->session_id, $ss_old->getFieldId($key), $ss->fingerprints[$key]);
			}
		}

		#echo $ss_old->getClientId();
	}

	#$valid = $_GET['token'];

	#$ss->populateFromGlobals($GLOBALS);

	print_query_log();