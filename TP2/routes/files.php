<?php

	$app->get('/files', function() {
		$ftp = new FTP("localhost", "2121");
		$ftp->connect();
		$isLogged = $ftp->login();
		echo "Requesting files with HTTP get<br>";
		echo ($isLogged) ? "Successfully logged to FTP Server" : "Unable to connect FTP Server -- check your credentials";

		$list = $ftp->pwd();
		//print_r($list);
	});