<?php
	/**
	 * Delete Routes
	 *
	 * All the delete requests in one file
	 *
	 * @author Damien Calesse
	 * @author Pierre Leroy
	 */

	$app->delete('/:filepath+', function($filepath) {
		$ftp = new FTP("localhost", "2121");
		$ftp->connect();
		$ftp->login();
		
		$real_filepath = implode("/", $filepath);
		
		if ($ftp->isDir($real_filepath)) {
			$ftp->deleteDir($real_filepath);
		} else {
			if ($ftp->delete($real_filepath))
				print_r('ok');
			else
				print_r('ko');
		}
	});
