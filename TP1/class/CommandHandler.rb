#
# File : CommandHandler.rb
# Description: Handle commands from the client and execute commands on the FTP Server
#
# @author Damien Calesse, Pierre Leroy
#

class CommandHandler

    @@_commands = nil
    @@_cmd = nil
    @@_args = nil
    @@_connectionHandler = nil
	
	#
	# Initialize
	# Initialize list of commands available and save connectionHandler
	# @param connectionHandler [ConnectionHandler] connectionHandler initializing this CommandHandler
	#

    def initialize connectionHandler
        @@_commands = ["GET", "STR", "USER", "PASS", "SYST", "FEAT", "PWD", "LIST", "MKD", "PASV", "CWD", "RETR", "REST"]
        @@_connectionHandler = connectionHandler
    end

	#
	# Get Command
	# Check if the command asked is implemented on the server
	# @param cmd [String] command to check
	# @return [Boolean] command is implemented
	#

    def get cmd
        @@_args = nil
        return @@_commands.include?(cmd)
    end

	#
	# Execute Command
	# Execute the command if there exists a function related to it
	# @param cmd [String] command to execute
	# @return [String] return of the command
	#

    def exec cmd
        @@_cmd = cmd[0]
        @@_args = cmd

        return send(@@_cmd) if respond_to?(@@_cmd)
    end

	#
	# USER
	# Accept all connection
	# @return [String] return code 200
	#

    def USER
        return (@@_args != nil) ? "200 " : "Error Args"
    end

	#
	# PASS
	# Not used yet
	# @return [String] return code 230
	#

    def PASS
        return "230 - Login successfull"
    end

	#
	# SYST
	# Return the type of the system
	# @return [String] return code 215 with system type
	#

    def SYST
        return "215 - UNIX Type : L8"
    end

	#
	# FEAT
	# Return All the commands available
	# @return [String] return code 211 + all the commands + code 211
	#

    def FEAT
        response  = "211 - Features :\n"
        @@_commands.each do |cmd|
            response += "#{cmd}\n"
        end
        response += "211 - End"
        return response
    end

	#
	# PWD
	# Return the main directory
	# @return [Sring] return code 257 + main directory (currentDirectory)
	#

    def PWD
        return "257 #{@@_connectionHandler.getCurrentDirectory}" 
    end

	#
	# LIST
	# List all files in the current directory
	# @return [String] return code 150 and code 266
	# @return [String] return a list of files
	#

    def LIST
       cmd = "150 Directory listing\r\n"
       files = %x(cd #{@@_connectionHandler.getCurrentDirectory} && ls -al).split("\n")
       puts "#{files}"
       data = []
       files.each do |file|
           data.push("#{file}\r\n")
           puts "#{file}"
       end
       cmd += "226 Directory send\r\n"
       return cmd,data
    end

	#
	# MKD
	# Create a new directory in the current directory
	# Not Yet Implemented
	#

    def MKD

    end

	#
	# RETR
	# Download a file from the server
	# @return [String] return code 250
	# @return [String] List of string ([0] is file [1] is backspace)
	#

    def RETR
        data = []
        
        #File.open(@@_args.last, 'rb') do |file|
        '''
            while chunk = file.read(1024*1024*120)
                data.push(chunk)
            end
            #data.push(EOF)
        end
        '''
        file = open(@@_args.last, "rb")
        data.push(file.read)
        data.push("\r\r\n\n")
        return "250 File download ok", data
    end

	#
	# REST
	# Retrieve download in case of errors during RETR
	# @return [String] return code 250
	# @return [String] return chunk of file from @@_args.last byte
	#

    def REST
        pos = @@_args.last
        data = []
        count = 0
        File.open(@@_args.last, 'rb') do |file|
            while chunk = file.read(pos-1)
                if (count > 0)
                    data.push(chunk)
                end
                count += 1
            end
        end
        puts data
        return "250 File download ok", data

    end

	#
	# CWD
	# Change Working Directory
	# @return [String] code 250
	#

    def CWD
        @@_connectionHandler.setCurrentDirectory  @@_args.last
        return "250 Directory successfull changed \r\n"
    end

	#
	# PASV
	# Enter in passive mode
	# @return [String] code 227 without address to connect for client
	#

    def PASV
	    return "227 Entering Passive Mode(#{@@_args.last})\n"
    end
end
