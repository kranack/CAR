<?php

	class FTP {
		
		private $hostname = 'localhost';
		private $port = '21';
		private $login;
		private $passwd;

		private $conn;

		function __construct($hostname = "", $port = "") {
			if ($hostname != "")
				$this->hostname = $hostname;

			if ($port != "")
				$this->port = $port;

			$this->conn = NULL;
		}

		function __destruct() {
			$this->close();	
		}
		
		function connect() {
			$this->conn = ftp_connect($this->hostname, $this->port) or die ("Impossible de se connecter à $this->hostname:$this->port");

		}
		
		function login($login = "", $passwd = "") {
			assert($this->conn);

			$this->login = ($login == "") ? "anonymous" : $login;
			$this->passwd = $passwd;
			
			$isLogged = ftp_login($this->conn, $this->login, $this->passwd);

			return $isLogged;
		}
		
		function get($filename, $mode = FTP_ASCII) {
			assert($this->conn);

			$handler = fopen('php://stdout', 'w') or die ('Impossible d\'écrire sur la sortie standard');
			$result = ftp_nb_fget($this->conn, $handler, $filename, $mode);
			while ($result == FTP_MOREDATA) $result = ftp_nb_continue($this->conn);
			if($result == FTP_FINISHED)
				print $handler;
		}

		function close() {
			ftp_close($this->conn);
		}

		function ls() {
			//return ftp_nlist($this->conn, $this->pwd());
			return ftp_rawlist($this->conn, $this->pwd());
		}

		function pwd() {
			return ftp_pwd($this->conn);
		}
		
		function cdup() {
			return ftp_cdup($this->conn);
		}

		function isDir($filepath) {
			$root = ($this->cdup()) ? $this->pwd() : die('Erreur interne. Changement de répertoire impossible');
			return is_dir("ftp://$this->login:$this->passwd@$this->hostname:$this->port$root/$filepath");
		}
	}
