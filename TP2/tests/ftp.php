<?php
	error_reporting(E_ALL & ~E_NOTICE);

	require __DIR__.'/vendor/autoload.php';
	require __DIR__.'/includes.php';
		
	use Slim\Slim;
	
	$ftp = new FTP("localhost", "2121");
		$ftp->connect();
		$isLogged = $ftp->login();
		echo "Requesting files with HTTP get<br>";
		echo ($isLogged) ? "Successfully logged to FTP Server" : "Unable to connect FTP Server -- check your credentials";

		$list = $ftp->pwd();
		echo $list;

	/*$app = new Slim();
	$app->config('debug', true);
	
	$log = $app->getLog();
	$log->setEnabled(true);

	require __DIR__.'/routes.php';

	$app->run()*/
