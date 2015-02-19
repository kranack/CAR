class CommandHandler

    @@_commands = nil
    @@_cmd = nil
    @@_args = nil
    @@_connectionHandler = nil

    def initialize connectionHandler
        @@_commands = ["GET", "STR", "USER", "PASS", "SYST", "FEAT", "PWD", "LIST", "MKD", "PASV", "CWD", "RETR", "REST"]
        @@_connectionHandler = connectionHandler
    end

    def get cmd
        @@_args = nil
        return @@_commands.include?(cmd)
    end

    def exec cmd
        @@_cmd = cmd[0]
        @@_args = cmd

        return send(@@_cmd) if respond_to?(@@_cmd)
    end

    def USER
        #return "youpi"
        return (@@_args != nil) ? "200 " : "Error Args"
    end

    def PASS
        return "230 - Login successfull"
    end

    def SYST
        return "215 - UNIX Type : L8"
    end

    def FEAT
        response  = "211 - Features :\n"
        @@_commands.each do |cmd|
            response += "#{cmd}\n"
        end
        response += "211 - End"
        return response
    end

    def PWD
        return "257 #{@@_connectionHandler.getCurrentDirectory}" 
    end

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

    def MKD

    end

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

    def CWD
        @@_connectionHandler.setCurrentDirectory  @@_args.last
        return "250 Directory successfull changed \r\n"
    end

    def PASV
	#addr = @@_connectionHandler.pasiveMode
	#addr="127,0,0,1,230,80"
	    return "227 Entering Passive Mode(#{@@_args.last})\n"
    end
end
