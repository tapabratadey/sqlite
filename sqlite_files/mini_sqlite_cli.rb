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
            arr = buf.split
            arr.each_with_index do |item, index|
                # if index == 0 and @query_array.include?(item.upcase)
                #     query_col = arr[index + 1]
                #     if query_col and !@command_array.include?(query_col.upcase)
                #         request.send(item, query_col) 
                #         request.run
                #     end
                # end
                if item.upcase == "SELECT" and @select_flag == 0
                    select_flag = 1
                    query_col = arr[index + 1]
                    if query_col and !@command_array.include?(query_col.upcase)
                        request.select(query_col)
                    else
                        puts "Invalid Request"
                    end
                else
                    puts "Invalid Request"
                end    


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
#         lastly call run# 1. err_validation
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
        @set_flag = 0
        @values_flag = 0
        @columns = []
        @query_array = ["SELECT", "UPDATE", "INSERT", "DELETE"]
        @command_array = ["FROM", "WHERE", "JOIN", "ORDER", "SET", "VALUES"]
    end

    def set_select(request, arr, index, item)
        @select_flag = 1
        query_col = arr[index + 1]
        if query_col and !@command_array.include?(query_col.upcase)
            request.select(query_col)
        else
            puts "Invalid Request"
        end
    end

    def read_cli (request)
        _print_time
        while buf = Readline.readline("> ", true)
            arr = buf.split
            arr.each_with_index do |item, index|
                if item.upcase == "SELECT" and @select_flag == 0
                    set_select(request, arr, index, item)
                end
                if item.upcase == "FROM" and @from_flag == 0
                    set_from(request, arr, index, item)
                    request.run
                end
                # elsif item.upcase == "UPDATE" and @update_flag == 0
                #     set_update(request, arr, index, item)
                # elsif item.upcase == "INSERT" and @insert_flag == 0
                #     set_insert(request, arr, index, item)
                # elsif item.upcase == "DELETE" and @delete_flag == 0
                #     set_delete(request, arr, index, item)
                # 
                # elsif item.upcase == "WHERE" and @where_flag == 0
                #     set_where(request, arr, index, item)
                # elsif item.upcase == "JOIN" and @join_flag == 0
                #     set_join(request, arr, index, item)
                # elsif item.upcase == "ORDER" and @order_flag == 0
                #     set_order(request, arr, index, item)
                # elsif item.upcase == "SET" and @set_flag == 0
                #     set_set(request, arr, index, item)
                # elsif item.upcase == "VALUES" and @values_flag == 0
                #     set_values(request, arr, index, item)
                # else
                #     puts "Invalid Request"
                # end
            end
            # arr.each_with_index do |item, index|
            #     if index == 0 and @query_array.include?(item.upcase)
            #         query_col = arr[index + 1]
            #         if query_col and !@command_array.include?(query_col.upcase)
            #             request.send(item.downcase, query_col) 
            #             request.run
            #             if (index + 2) < arr.length
            #                 if item == "SELECT" and arr[index + 2] == "FROM"
            #                     @from_flag = 1
            #                 elsif item == "UPDATE" and arr[index + 2] == "SET"
            #                     @where_flag = 1
            #                 elsif item == "INSERT" and arr[index + 2] == "VALUES"
            #                     @join_flag = 1
            #                 elsif item == "SELECT" and arr[index + 2] == "ORDER"
            #                     @order_flag = 1
            #                 else
            #                     puts "Invalid Request"
            #                 end

            #                 index += 2
            #         else
            #             puts "Invalid Request"
            #         end
            #     else
            #         puts "Invalid Request"
            #     end
            #     if 
            # end
        end 
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