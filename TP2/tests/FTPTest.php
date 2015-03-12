<?php

require_once __DIR__ . "/../class/FTP.php";

class FTPTest extends PHPUnit_Framework_TestCase
{

	const TEST_TXT = 'test.txt';

	public function testLog()
	{
		$ftp = new FTP("127.0.0.1","2121");
		$ftp->connect();
		
		// anonymous login
		$islogged = $ftp->login();

		$this->assertTrue($islogged);
	}

	public function testTouch()
	{
		$ftp = new FTP("127.0.0.1", "2121");
		$ftp->connect();
		$ftp->login();
		
		$result = $ftp->touch(self::TEST_TXT);
		$this->assertTrue($result);
	}
	
	public function testGet()
	{
		$ftp = new FTP("127.0.0.1", "2121");
		$ftp->connect();
		$ftp->login();

		$result = $ftp->get(self::TEST_TXT);
		
		$this->assertEquals('', $result);
	}

	public function testDelete()
	{
		$ftp = new FTP("127.0.0.1", "2121");
		$ftp->connect();
		$ftp->login();

		$result = $ftp->delete(self::TEST_TXT);
		$this->assertTrue($result);		
	}
}
