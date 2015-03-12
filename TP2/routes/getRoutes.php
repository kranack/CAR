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

		$app->render('index.php',
					array(
						'title' => '/',
						'files' => $list,
						'uri' => $app->request->getReferrer(),
						'path' => $app->request->getPath(),
						'host' => $app->request->getHost()
					));
	});

	$app->get('/:filepath+', function($filepath) use ($app) {
		$ftp = new FTP("localhost", "2121");
		$ftp->connect();
		$ftp->login();
		$real_filepath = implode("/", $filepath);
		$ftp->cdup();
		if ($ftp->isDir($real_filepath)) {
			$list = $ftp->ls($real_filepath);
			$app->render('index.php',
						array(
							'title' => "/$real_filepath",
							'files' => $list,
							'uri' => $app->request->getReferrer(),
							'path' => $app->request->getPath(),
							'host' => $app->request->getHost()
						));
		} else {
			//print_r($ftp->getMime($real_filepath));
			//print_r('<pre>');
			print_r($ftp->get($real_filepath));
			//print_r('</pre>');
		}
	});
