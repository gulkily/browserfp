<?php
	include_once('database.php');

	$tables = array(
		'client_session',
		'client_variable',
		'fp_client',
		'fp_record',
		'fp_session',
		'session_record'
	);

	foreach ($tables as $table) {
		$db->query("truncate $table");
	}