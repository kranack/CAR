class Command

    @@_commands = ["GET", "STR", "USER", "PASS"]

    def get cmd
        return @@_commands.include?(cmd)
    end

    def exec cmd
        return "exec #{cmd}"
    end
end
