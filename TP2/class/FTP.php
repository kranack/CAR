<?php
	/**
	 * FTP Client Class File
	 * 
	 * @author Damien Calesse
	 * @author Pierre Leroy
	 */

	/**
	 * FTP Client Class
	 * 
	 * This class connect to the ftp server with php dedicated functions
	 * Only support IPv4 connection
	 *
	 * @category FTP
	 */
	class FTP {

		/**
		 * @var string $hostname FTP Server hostname
		 */
		private $hostname = 'localhost';
		/**
		 * @var string $port FTP Server port
		 */
		private $port = '21';
		/**
		 * @var string $login FTP Server's username
		 */
		private $login;
		/**
		 * @var string $passwd FTP Server's password
		 */
		private $passwd;
		/**
		 * @var FTPStream|null $conn FTP Connection handler
		 */
		private $conn;
		
		/**
		 * Class constructor
		 *
		 * @param string $hostname	FTP Server hostname or IP
		 * @param string $port		FTP Server port
		 *
		 * Set the current connection to NULL
		 */
		function __construct($hostname = "", $port = "") {
			if ($hostname != "")
				$this->hostname = $hostname;

			if ($port != "")
				$this->port = $port;

			$this->conn = NULL;
		}

		/**
		 * Class destructor
		 *
		 * Close the current connection using FTP::close()
		 */
		function __destruct() {
			$this->close();	
		}

		/**
		 * Connect to FTP Server
		 *
		 * using $this->hostname and $this->port connect to FTP Server
		 */
		function connect() {
			$this->conn = ftp_connect($this->hostname, $this->port) or die ("Impossible de se connecter à $this->hostname:$this->port");

		}

		/**
		 * Login to FTP Server
		 *
		 * @param string $login		username
		 * @param string $passwd	password
		 *
		 * @return boolean $isLogged
		 */
		function login($login = "", $passwd = "") {
			assert($this->conn);

			$this->login = ($login == "") ? "anonymous" : $login;
			$this->passwd = $passwd;
			
			$isLogged = ftp_login($this->conn, $this->login, $this->passwd);

			return $isLogged;
		}
		
		/**
		 * Download a file
		 *
		 * @param string $filename	file to download
		 * @param int $mode			mode for ftp connection
		 */	
		function get($filename, $mode = FTP_ASCII) {
			assert($this->conn);

			$handler = fopen('php://stdout', 'w') or die ('Impossible d\'écrire sur la sortie standard');
			$result = ftp_nb_fget($this->conn, $handler, $filename, $mode);
			while ($result == FTP_MOREDATA) $result = ftp_nb_continue($this->conn);
			if($result == FTP_FINISHED)
				print $handler;
		}

		/**
		 * Close the FTP connection
		 *
		 * close the current FTP connection
		 */
		function close() {
			ftp_close($this->conn);
		}

		/**
		 * List files in the pwd
		 *
		 * @see FTP::pwd()	get the FTP pwd
		 *
		 * @return string[]	files in the current directory
		 */
		function ls() {
			//return ftp_nlist($this->conn, $this->pwd());
			return ftp_rawlist($this->conn, $this->pwd());
		}
		
		/**
		 * Get the current directory
		 *
		 * @return string	current server directory
		 */
		function pwd() {
			return ftp_pwd($this->conn);
		}
		
		/**
		 * Reset FTP current directory
		 *
		 * reset the pwd value to default
		 */	
		function cdup() {
			return ftp_cdup($this->conn);
		}
		
		/**
		 * Is it a directory ?
		 *
		 * check if a file is a directory
		 *
		 * @param string filepath	filepath to check
		 *
		 * @return boolean 
		 */
		function isDir($filepath) {
			$root = ($this->cdup()) ? $this->pwd() : die('Erreur interne. Changement de répertoire impossible');
			return is_dir("ftp://$this->login:$this->passwd@$this->hostname:$this->port$root/$filepath");
		}
	}
