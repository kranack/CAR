<?php

require_once __DIR__ . "/../class/FTP.php";

class FTPTest extends PHPUnit_Framework_TestCase
{

	//
	public function testLog()
	{
		$ftp = new FTP("127.0.0.1","2121");
		$islogged = $ftp->login();

		$this->assertEquals(true,$islogged);
	}

}