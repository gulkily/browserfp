<?php
	include_once('database.php');
	#$tables = $db->get_results("SHOW TABLES");	

	class SherlockSession {
		function __construct($db) {
			$this->db = $db;

			$dbVersion = 8; #todo remove this hack
			if (!$this->dbVersionCurrent($dbVersion)) {
				die("OH NO! wrong db version!<br>check the sherlock_config table!");
			}

			$this->fingerprints = array();

			$this->tokens = array();

			$this->populateFieldDefs();
		}

		function getJsBlock() {
			$token = $this->getReturnToken();

			$jsBlock = "
	var rurl = '';
	function returnUrl(n, v) {
		if (rurl == '') {
			rurl = 'updatesession.php?token=<?php echo ".$returnToken." ?>';
		}
		if (n && v) {
			rurl = rurl + '&' + n + '=' + v;
		}
		return rurl;
	}

	returnUrl('iw', window.innerWidth);
	returnUrl('ih', window.innerHeight);

	var d = new Date();
	returnUrl('toff', Math.round(<?php echo time()?> - d.getTime()/1000));

	document.write('<p><a href=\"' + returnUrl() + '&verbose=1\">call updatesession.php manually</a></p>');

	document.write('<p>tracking gif: <img src=\"' + returnUrl() + '\"></p>');
			";

			return $jsBlock;
		}

		function getSessionSimilarity($session, $match_only = true) {
			/* $match_only
					true = only datapoints present in both sessions are used
					false = all datapoints are scored and missing datapoints count against similarity
			*/

			if ($match_only) {
				$fields = array_intersect(
					array_keys($this->fingerprints),
					array_keys($session->fingerprints)
				);
			} else {
				$fields = array_unique(array_merge(array_keys($this->fingerprints),	array_keys($session->fingerprints)));
			}

			$sim = 1;

			foreach ($fields as $field) {
				if ($this->fingerprints[$field] != $session->fingerprints[$field]) {
					$sim -= 1 / count($fields);
				}
			}

			return $sim;
		}

		function getRelatedSession($sessionId) {
			$sessionId = intval($sessionId);
			if (!$sessionId) return null;

			$ssRelated = new SherlockSession($this->db);
			$ssRelated->loadFromSession($sessionId);

			return $ssRelated;
		}

		function updateRelatedSession($ssRelated) {
			if ($this->getValidationToken()) {
				$oldClientId = $ssRelated->getClientId();

				foreach($this->fingerprints as $key => $value) {
					if (!isset($ssRelated->fingerprints[$key])) {
						$ssRelated->storeSessionRecord($ssRelated->session_id, $ssRelated->getFieldId($key), $this->fingerprints[$key]);
					}
				}

				$ssRelated->setClientByFingerprints();
				$newClientId = $ssRelated->getClientId();

				if ($oldClientId != $newClientId) {
					$ssRelated->setClientId($newClientId);
				}

				if ($this->getClientId() != $ssRelated->getClientId()) {
					die ('have not thought of this yet'); #todo
				}
			}
		}

		function setClientId($clientId) {
			$clientId = intval($clientId);
			$sessionId = intval($this->session_id);

			if (!$clientId || !$sessionId) {
				return;
			}

			$query = "UPDATE client_session SET client_id = $clientId WHERE session_id = $sessionId";
			$db->query($query);
		}

		function populateFieldDefs() {
			$fp_fields = $this->db->get_results("SELECT * FROM fp_field"); #todo caching and active flag

			foreach($fp_fields as $field) {
				$fields[$field->field_name] = $field;

				$fields_nl[$field->field_id] = $field->field_name;
			}

			$this->fpFields = $fields;
			$this->fpFieldNames = $fields_nl;
		}

		function dbVersionCurrent($dbVersionExpected) {
			$dbVersionExpected = intval($dbVersionExpected);
			
			$query = "SELECT value FROM sherlock_config WHERE name = 'db_version'";
			$dbVersion = $this->db->get_var($query);

			if ($dbVersion == $dbVersionExpected) {
				return true;
			} else {
				return false;
			}
		}

		function populateFromGlobals($globals) {
			$PrintDefs = $this->fpFieldNames;

			$this->globals = $globals;

			foreach($PrintDefs as $key => $value) {
				$methodName = 'get'.$value;
				$this->fingerprints[$value] = $this->$methodName();
			}

			if ($this->getValidationToken()) {
				unset($this->fingerprints['ValidationToken']); #todo possible bug
				$this->old_client_id = $this->getClientIdBySessionId($this->old_session_id); #todo this is all sorts of bad in one line
			} else {
				$this->unsetFingerprintsWithValidate();
			}
		}

		function unsetFingerprintsWithValidate() { #todo cleanup
		#todo this needs an explanation comment
		#todo generic function example: unsetFingerprintsByType('validate', 1);
			
			foreach($this->fingerprints as $key => $value) {
				if (isset($this->fpFields[$key]->validate) && $this->fpFields[$key]->validate == 1) {
					unset($this->fingerprints[$key]);
				}
			}
		}

		function getClientRecords() {
			$clientId = $this->getClientId();
			if (!$clientId) return null;

			$query =
				"SELECT DISTINCT fp_field.field_name, fp_record.field_value ".
				"FROM client_record_v, fp_record, fp_field ".
				"WHERE 1=1 ".
				"AND client_record_v.client_id = $clientId ".
				"AND client_record_v.record_id = fp_record.record_id ".
				"AND fp_record.field_id = fp_field.field_id";

			$records = $this->db->get_results($query);
	
			#todo this needs a lot of optimization

			foreach ($records as $rec) {
				$clientRecords[$rec->field_name][] = $rec->field_value;
			}

			return $clientRecords;
		}

//
		function getFieldId($defName) {
			if (isset($this->fpFields[$defName])) {
				return $this->fpFields[$defName]->field_id;
			} else {
				return null;
			}
		}

		function getFieldName($defId) {
			$defs = $this->fpFieldNames;

			if (isset($defs[$defId])) {
				return $defs[$defId];
			} else {
				return null;
			}
		}

		function createSession() {
			$client_id = $this->getClientId();

			$query = "INSERT INTO fp_session() VALUES()";
			$this->db->query($query);
			$session_id = $this->db->insert_id;

			$query = "INSERT INTO client_session(client_id, session_id) VALUES($client_id, $session_id)";
			$this->db->query($query);

			$this->session_id = $session_id;

			return $session_id;
		}

		function getSessionId() {
			if (isset($this->session_id)) {
				return $this->session_id;
			} else {
				return $this->createSession();
			}
		}

		function getSessionIdFromDatapoint($fieldName, $fieldValue) {
			$field_id = intval($this->getFieldId($fieldName)); #todo some error checking
			$fieldValue = $this->db->escape($fieldValue);

			$query =
				"SELECT session_id ".
				" FROM fp_record, session_record_active ".
				" WHERE 1=1".
				" AND fp_record.record_id = session_record_active.record_id ".
				" AND fp_record.field_id = $field_id ".
				" AND fp_record.field_value = '$fieldValue'";

			$session_id = $this->db->get_var($query);

			#$this->session_id = $session_id; #todo might be a problem
			return $session_id;

		}

		function loadFromSession($sessionId) {
			$sessionId = intval($sessionId);
			if (!$sessionId) return;

			$query = 
				"SELECT fp_record.field_id, fp_record.field_value ".
				" FROM ".
				" fp_session, session_record_active, fp_record ".
				" WHERE " .
				" fp_session.session_id = session_record_active.session_id ".
				" AND session_record_active.record_id = fp_record.record_id ".
				" AND fp_session.session_id = $sessionId";
			$results = $this->db->get_results($query);

			if (count($results)) { foreach($results as $row) {
				$this->fingerprints[$this->getFieldName($row->field_id)] = $row->field_value;
			}}

			$this->session_id = $sessionId;
			$this->client_id = $this->getClientIdBySessionId($sessionId);
		}

		#function 

		function createClient() {
			$query = "INSERT INTO fp_client() VALUES()";
			$this->db->query($query);
			$client_id = $this->db->insert_id;

			return $client_id;
		}

		function storeSessionRecord($sessionId, $fieldId, $fieldValue) {
			if (!$sessionId || !$fieldId || !$fieldValue) {
				return;
			}

			if (!isset($this->fpFields[$this->getFieldName($fieldId)]->store) || !$this->fpFields[$this->getFieldName($fieldId)]->store) {
				die('trying to store datapoint that shouldn\'t be stored!'); #just a sanity check
			}

			#todo eliminate field_id lookup
			$fieldValue_e = $this->db->escape($fieldValue);

			#todo fix this to not use an extra query
			$query = 
				"SELECT record_id FROM fp_record WHERE ".
				"field_id = $fieldId AND field_value = '$fieldValue_e'";
			$record_id = $this->db->get_var($query);

			if (!$record_id) {
				$query = "INSERT IGNORE INTO fp_record(field_id, field_value) VALUES ";
				$query .= "($fieldId,'$fieldValue_e')";
				$this->db->query($query);

				$record_id = $this->db->insert_id;
			}

			if ($record_id) {
				$query = 
					"INSERT INTO session_record_active(session_id, record_id, record_timestamp) ".
					"VALUES($sessionId, $record_id, NOW())"; #todo use server time instead
				$this->db->query($query);

				if ($sessionId == $this->session_id) {
					$this->fingerprints[$this->getFieldName($fieldId)] = $fieldValue;
				}

				return $this->db->insert_id;
			}
		}

		function storeSession() {
			$session_id = $this->createSession();

			foreach($this->fingerprints as $key => $value) { #todo optimize 5 times
				$field_id = $this->getFieldId($key);

				if ($this->fpFields[$key]->store) {
					$this->storeSessionRecord($session_id, $field_id, $value);
				}
			}
		}

		function setClientByFingerprints() {
			if (!count($this->fingerprints)) {
				return;
			}

			$query =
				"SELECT DISTINCT client_record_v.client_id, fp_record.record_id, record_client_count.client_count ".
				" FROM fp_record, client_record_v, record_client_count".
				" WHERE fp_record.record_id = client_record_v.record_id ".
				" AND client_record_v.client_id = record_client_count.record_id ".
				" AND ";

			$comma = 0;
			foreach($this->fingerprints as $key => $value) { #todo foreach check
				if ($comma > 0) $query .= ' OR '; $comma++;

				$query .= "(field_id = " . $this->getFieldId($key) . " AND field_value = '" . $value . "')";
			}

			$result = $this->db->get_results($query);
			if (count($result)) { foreach ($result as $row) {
				$cc[$row->client_id][$row->record_id] = $row->client_count; #client count
			}}

/* #todo take into account unmatched records too, possibly on a per-session basis?
			$client_list = implode(',', array_keys($cc));
			$query = "SELECT DISTINCT client_record_v.client_id, client_record_v.record_id ".
				" FROM client_record_v ".
				" WHERE client_id IN ($client_list)" ;
			$result = $this->db->get_results($query);
*/

			if (isset($cc) && count($cc)) {
				foreach ($cc as $client => $records) {
					foreach ($records as $record => $client_count) {
						$p = 1/$client_count;

						$t = (isset($t) ?  $t * $p : $p);
						$br = (isset($br) ? $br * (1 - $p) : (1 - $p));
					}
					$cp[$client] = $t / ($t + $br);
				}

				asort($cp);
				$cp = array_reverse($cp, true);

				$cp_list = implode(',', $cp);
				print_r($cp_list);

				foreach ($cp as $client => $probability) {
					if ($probability > 0.5) { #todo make this configurable or calculated
						#echo ("<h1>".$probability."</h1>");
						$this->client_id = $client;
						$this->probability = $probability;

						return $client;
					}
				}
			}

			return null;
		}

		function getClientId() {
			if (isset($this->client_id)) {
				return $this->client_id;
			} else {
				$client_id = $this->setClientByFingerprints();

				if (!$client_id) {
					$client_id = $this->createClient();
				}
			}
			
			$client_id = intval($client_id);

			return $client_id;
		}

		function getClientIdBySessionId($sessionId) {
			$sessionId = intval($sessionId);
			if (!$sessionId) return null;

			$query =
				"SELECT DISTINCT client_id ".
				" FROM client_session".
				" WHERE session_id = $sessionId ";
			$client_id = $this->db->get_var($query);

			return $client_id;
		}

		function getClientVariable($varName) {
			$client_id = $this->getClientId();
			$varName   = $this->db->escape($varName);

			$query = "SELECT var_value FROM client_variable WHERE client_id = $client_id AND var_name = '$varName'"; #todo

			$varValue = $this->db->get_var($query);

			return $varValue;
		}

		function setClientVariable($varName, $varValue) {
			$client_id = $this->getClientId();
			$varName   = $this->db->escape($varName);
			$varValue  = $this->db->escape($varValue);

			$query = "INSERT INTO client_variable (client_id, var_name, var_value) VALUES($client_id, '$varName', '$varValue')";

			return $this->db->query($query); #todo error handling
		}

		function getUseragent() {
			return $this->globals['_SERVER']['HTTP_USER_AGENT'];
		}

		function getPlatform() {
			$platform = get_browser($this->globals['_SERVER']['HTTP_USER_AGENT']);
			
			#todo cleanup
			$platform_string = $platform->platform;

			if ($platform->win32) {
				$platform_string .= "-win32";
			} else if ($platform->win64) {
				$platform_string .= "-win64";
			}
			
			return $platform_string;
		}

		function getNewSessionCookie() {
			return md5($this->getRemoteIp() . $this->getAcceptedFiletypes() . time());
		}

		function getSessionCookie() {
			$sessionCookieName = 'session';

			if (isset($this->newCookie)) {
				return $this->newCookie;
			} else if (isset($this->globals['_COOKIE'][$sessionCookieName])) {
				return $this->globals['_COOKIE'][$sessionCookieName];
			} else {
				$newCookie = $this->getNewSessionCookie();
				setcookie($sessionCookieName, $newCookie, time() + 86400, '/');
				return $newCookie;
			}
		}

		function getRemoteIp() {
			return $this->globals['_SERVER']['REMOTE_ADDR'];
		}

		function getRemoteIpBlock() { #todo check for ipv4 vs ipv6
			$remote_ip = $this->globals['_SERVER']['REMOTE_ADDR'];
			$remote_ip = explode('.', $remote_ip);
			unset($remote_ip[3]);
			$remote_ip = implode('.', $remote_ip);

			return $remote_ip;
		}

		function getAcceptedFiletypes() {
			return $this->globals['_SERVER']['HTTP_ACCEPT'];
		}

		function getAcceptedLangs() {
			return $this->globals['_SERVER']['HTTP_ACCEPT_LANGUAGE'];
		}

		function getVarFromPost($varName) {
			$v = $varName; #todo maybe some sanitizing?
			
			if (isset($this->globals['_GET'][$v])) {
				return $this->globals['_GET'][$v];
			}
			else if (isset($this->globals['_POST'][$v])) {
				return $this->globals['_POST'][$v];
			}

			return null;
		}

		function getScreenResWidth() { #todo genericize
			return $this->getVarFromPost('iw'); 
		}

		function getScreenResHeight() {
			return $this->getVarFromPost('ih'); 
		}

		function getTimeOffset() {
			return $this->getVarFromPost('toff');
		}

		function getEtag() {
			return null;
		}

		function getReturnParam($varName) {
			if (isset($this->returned_params)) {
				return $this->returned_params[$varName];
			}
		}

		function getReturnToken() {
			if (isset($this->fingerprints['ValidationToken'])) {
				$this->fpFields['ReturnToken']->store = 0;
				$this->fingerprints['ReturnToken'] = $this->fingerprints['ValidationToken'];
			}

			if (isset($this->fingerprints['ReturnToken'])) {
				return $this->fingerprints['ReturnToken'];
			}

			$token = md5($this->getRemoteIp() . $this->getAcceptedFiletypes() . time() . "some salt 12435246243 jfadjfadjfjda"); #todo globalize

			return $token;
		}

		function getValidationToken() {
			if (isset($this->validation_token)) {
				return $this->validation_token;
			}

			if (isset($_POST['token'])) {
				$validation_token = $_POST['token'];
			} else if (isset($_GET['token'])) {
				$validation_token = $_GET['token'];
			} else {
				$validation_token = null;
			}

			if ($validation_token) {
				$this->old_session_id = $this->getSessionIdFromDatapoint('ReturnToken', $validation_token);
				
				#$this->old_client_id = #todo
				$this->validation_token = $validation_token; #todo is this really needed?
				#todo remove old validation token
				return $validation_token;
			}
		}

		function deleteValidationToken() {
			$token = $this->getValidationToken();

			#todo this could use some optimizing, we can just grab the record_id during getValidationToken()
			#todo hardcoded field_id

			$record_id = $this->db->get_var("SELECT record_id FROM fp_record WHERE field_id = 11 AND field_value = '$token'");

			$this->db->query("UPDATE session_record SET active = 0 WHERE record_id = $record_id AND session_id = ".$this->getSessionId());

			if ($this->db->rows_affected > 1) { #sanity check
				die ('more than 1 row set inactive in deleteValidationToken()! something went horribly wrong!');
			}

			if ($this->db->rows_affected == 1) {
				//$this->db->query("DELETE FROM fp_record WHERE record_id = $record_id");
				#todo think about what leaving this behind entails
			}
		}
	}
