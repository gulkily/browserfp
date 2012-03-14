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

	#if ($verbose) print_query_log();

	echo "\107\111\106\70\71\141\001\000\001\000\360\001\000\377\377\377\000\000\000\041\371\004\001\012\000\000\000\054\000\000\000\000\001\000\001\000\000\002\002\104\001\000\073";
	#todo send proper headers