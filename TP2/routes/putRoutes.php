<?php
	/**
	 * Put Routes
	 *
	 * All the put requests in one file
	 *
	 * @author Damien Calesse
	 * @author Pierre Leroy
	 */

	$app->put('/:filepath+', function($filepath) {
		$ftp = new FTP("localhost", "2121");
		$ftp->connect();
		$ftp->login();
		
		$real_filepath = implode("/", $filepath);

		echo $ftp->touch($real_filepath);
	});
