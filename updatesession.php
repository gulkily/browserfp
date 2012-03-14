<?php
	include_once('database.php');
	include_once('sherlock.php');

	$ss = new SherlockSession($db);

	$ss->populateFromGlobals($GLOBALS);

	$ss->storeSession();

	if ($ss->getValidationToken()) {
		$ss_old = new SherlockSession($db);
		$ss_old->loadFromSession($ss->old_session_id);
		
		$ss_old->session_id.',';
		$old_client_id = $ss_old->getClientId();

		foreach($ss->fingerprints as $key => $value) {
			if (!isset($ss_old->fingerprints[$key])) {
				$ss_old->storeSessionRecord($ss_old->session_id, $ss_old->getFieldId($key), $ss->fingerprints[$key]);
			}
		}

		$ss_old->setClientByFingerprints();
		$new_client_id = $ss_old->getClientId();

		if ($old_client_id != $new_client_id) {
			$session_id = $ss_old->session_id;
			$query = "UPDATE client_session SET client_id = $new_client_id WHERE client_id = $old_client_id AND session_id = $session_id";
			#todo this should be done with updateClientId() or setClientId()
			$db->query($query);
		}
	}

	#$valid = $_GET['token'];

	#$ss->populateFromGlobals($GLOBALS);

	print_query_log();