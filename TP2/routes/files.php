<?php

	$app->get('/', function() use ($app){
		$ftp = new FTP("localhost", "2121");
		//$ftp = new FTP("d3cima.com", "21");
		$ftp->connect();
		//$isLogged = $ftp->login("ftptest", "ftptest");
		$isLogged = $ftp->login();
		$ftp->cdup();
		$pwd = $ftp->pwd();
		$list = $ftp->ls($pwd);
		
		$app->render('index.php', array('title' => '/', 'files' => $list));
	});

	$app->get('/:filepath+', function($filename) use($app) {
		$ftp = new FTP("localhost", "2121");
		$ftp->connect();
		$filepath = implode("/", $filename);
		if ($ftp->isDir($filepath)) {
			$list = $ftp->ls($filepath);
			$app->render('index.php', array('title' => "/$filepath", 'files' => $list));
		} else
			echo $ftp->get($filepath);
		//echo $ftp->isDir($filepath);
	});
