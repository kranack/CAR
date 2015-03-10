<?php
    /**
     *  FTP Client Class File
     * 
     * @author Damien Calesse
     * @author Pierre Leroy
     *
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
         * @var string $hostname
         * @var string $port
         * @var string $login
         * @var string $passwd
         * @var FTPStream $conn
         *
         */
		private $hostname = 'localhost';
		private $port = '21';
		private $login;
		private $passwd;

		private $conn;
        
        /**
         * Class constructor
         *
         * @param string $hostname  FTP Server hostname or ip
         * @param string $port      FTP Server port
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
         * Class Destructor
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
         * 
         */
		function connect() {
			$this->conn = ftp_connect($this->hostname, $this->port) or die ("Impossible de se connecter à $this->hostname:$this->port");

		}


        /**
         * Login to FTP Server
         *
         * @param string $login     username
         * @param string $passwd    password
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
         * @param string $filename  file to download
         */
		function get($filename) {
			assert($this->conn);

			//ftp_get($this->conn, $filename
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
         * @see FTP::pwd()  For getting the FTP pwd
         * 
         * @return string[] files in the current directory
         */
		function ls() {
			//return ftp_nlist($this->conn, $this->pwd());
			return ftp_rawlist($this->conn, $this->pwd());

		}


        /**
         * Get the current directory
         *
         * return string    current server directory
         */
		function pwd() {
			return ftp_pwd($this->conn);
		}
	}
