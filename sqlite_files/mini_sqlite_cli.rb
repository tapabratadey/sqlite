# 1. err_validation
#     => exit_cli
    
# 2. parse
# 3. method calls using pre-existing class

# if arr[idx] == select and idx == 0 
# select = found
# validate arr[idx + 1] == passed (not commands)
#     request.select(arr[idx + 1])
#     idx += 2


# 1. SELECT
# 2. UPDATE
# 3. INSERT
# 4. DELETE
# 5. FROM
# 6. WHERE
# 7. JOIN
# 8. ORDER 



class SqliteCli
    def initialize
        @select_flag = 0
        @update_flag = 0
        @insert_flag = 0
        @delete_flag = 0
        @from_flag = 0
        @where_flag = 0
        @join_flag = 0
        @order_flag = 0
        @columns = []
        @query_array = ["SELECT", "UPDATE", "INSERT", "DELETE"]
        @command_array = ["FROM", "WHERE", "JOIN", "ORDER"]
    end

    def read_cli (request)
        _print_time
        while buf = Readline.readline("> ", true)
            

            end
        end 
        # MySQLiteRequest.run
    end

    def _print_time
        get_time = Time.new
        puts "MySQLite version 0.1 #{get_time.year}-#{get_time.month}-#{get_time.day}"
    end
end 


# during the validation phase
#     once each command req is clear
#         then set the variable in MySQLiteRequest

# after query is valid
#     check for the commands that were used i.e checks flag
#         lastly call run