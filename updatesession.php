<?php
	include_once('database.php');
	include_once('sherlock.php');

	$verbose = (isset($_GET['verbose'])?$_GET['verbose']:0) || (isset($_POST['verbose'])?$_POST['verbose']:0);

	$ss = new SherlockSession($db);

	$ss->populateFromGlobals($GLOBALS);

	if ($ss->getValidationToken()) {
	#todo this should be optimized so that the old session is only loaded once
		$ssRelated = $ss->getRelatedSession($ss->old_session_id);
		if ($ssRelated && $ssRelated->getSessionId()) {
			if ($ss->getSessionSimilarity($ssRelated) > 0.6) { #todo remove hardcoding, this should be automatically adjusted. this might also trigger something?
				$ss->updateRelatedSession($ssRelated);
				$ss->setClientByFingerprints();
			}
			$ssRelated->deleteValidationToken();
		}
	} else {
		$ss->storeSession();
	}

	#$valid = $_GET['token'];

	#$ss->populateFromGlobals($GLOBALS);

	if ($verbose) print_query_log();