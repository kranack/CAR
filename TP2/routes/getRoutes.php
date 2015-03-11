<?php
    /**
     * Get Routes
     *
     * All the get request in one file
     *
     * @author Damien Calesse
     * @author Pierre Leroy
     */    


	$app->get('/', function() use ($app) {
		$ftp = new FTP("localhost", "2121");
		$ftp->connect();
		$isLogged = $ftp->login();
		$ftp->cdup();
		$list = $ftp->ls($ftp->pwd());

		$app->render('index.php', array('title' => '/', 'files' => $list));
	});

	$app->get('/:filepath+', function($filepath) use ($app) {
		$ftp = new FTP("localhost", "2121");
		$ftp->connect();
		$real_filepath = implode("/", $filepath);

		if ($ftp->isDir($real_filepath)) {
			$list = $ftp->ls($real_filepath);
			$app->render('index.php', array('title', "/$filepath", 'files' => $list));
		} else {
			echo $ftp->get($real_filepath);
		}
	});
