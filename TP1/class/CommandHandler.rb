class CommandHandler

    @@_commands = nil
    @@_cmd = nil
    @@_args = nil
    @@_connectionHandler = nil

    def initialize connectionHandler
        @@_commands = ["GET", "STR", "USER", "PASS", "SYST", "FEAT", "PWD", "LIST", "MKD", "PASV"]
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
        return "257 /home/m1/calesse/Documents/CAR/CAR/TP1/monpetukrainien" 
        #dir = @@_connectionHandler.getCurrentDirectory
        #return "257 #{dir}"
    end

    def LIST
       response = "150 Directory listing\n"
       files = Dir["/home/m1/calesse/Documents/CAR/CAR/TP1/monpetukrainien"]
       files.each do |file|
           #response += "/home/m1/calesse/Documents/CAR/CAR/TP1/monpetukrainien\n"
           puts "#{file}\n"
       end
       #response += "150 Directory listing\n"
       response += "226 Directory send\n"
       return response
    end

    def MKD

    end

    def CWD
        
    end

    def PASV
	#addr = @@_connectionHandler.pasiveMode
	#addr="127,0,0,1,230,80"
	    return "227 Entering Passive Mode(#{@@_args.last})\n"
    end
end
