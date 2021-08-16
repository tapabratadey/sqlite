# 1. types of query = select, delete, update, insert    => GRAB QUERY TYPE
# 2. table name = nba.csv                               => FROM
# 3. select_columns = single columns or array columns   => SELECT
# 4. order_type = asc (default) OR DESC => "selects"    => ORDER
# 5. where col = WHERE filter query                     => WHERE
# 6. where val = WHERE filter query value               => WHERE

# module Testing
#     def Testing.test
#         puts "test"
#     end
# end


1. select✅
2. update✅ 
3. insert✅
4. delete ✅

5. from ✅
6. where ✅
7. set ✅
8. values ✅
9. join ✅
10. order ✅

11. _print_select✅
12. _print_update✅
13. _print_insert✅
14. _print_delete✅

15. _parser ✅
16. run          ✅ 
17. _exec_select ✅
18. _exec_update ✅
19. _exec_insert ✅
20. _exec_delete ✅

21. _updating_file ✅
22. initialize ✅

=begin
=> csv_files
=> my_sqlite/
    => my_sqlite_request.rb
    => select.rb
    => update.rb
    => insert.rb
    => delete.rb
=> main.rb
=end

#=========================
#   my_sqlite_request.rb
#=========================
initialize method
run method
where method
parser method
from method

#=========================
#       select.rb
#=========================
select method
join method
order method
_print_select
_exec_select

#=========================
#       update.rb
#=========================
update method
set method
_updating_file
_print_update
_exec_update

#=========================
#       insert.rb
#=========================
insert method
values method
_print_insert
_exec_insert

#=========================
#       delete.rb
#=========================
delete method
_print_delete
_exec_delete



require 'csv'

class MySqliteRequest
    
    def initialize
        @type_of_query = :none
        @table_name = nil
        @columns = []
        @order_type = :asc
        @where_col = nil
        @where_col_val = nil
        @order_col = nil
        @insert_vals = {}
        @update_vals = {}
        @column_join_db_a = nil
        @second_db = nil
        @column_join_db_b = nil
        @join_flag = 0
    end
    def from(table_name)
        @table_name = table_name
    end
    
    def select(query_col)
        @type_of_query = :select
        if (query_col.kind_of?(Array))
            # if query_col is an array
            @columns += query_col.map { |col| col.to_s} 
        else
            @columns << query_col.to_s # if not an array
        end
    end

    def where(column_name, criteria)
        @where_col = column_name
        @where_col_val = criteria
    end

    def order(order, column_name)
        @order_type = order
        @order_col = column_name
    end

    def insert(table_name)
        @type_of_query = :insert
        @table_name = table_name
    end

    # @param {hash key value}
    def values(data)
        if (@type_of_query == :insert)
            @insert_vals = data
            # puts @insert_vals
        else
            raise "VALUES must correspond with INSERT Query"
        end
    end

    def update(table_name)
        @type_of_query = :update
        @table_name = table_name
    end

    def set(data) 
        if (@type_of_query == :update)
            @update_vals = data
        else
            raise "SET must correspond with UPDATE Query"
        end
    end

    def join(col_on_db_a, file_db_b, col_on_db_b)
        @join_flag = 1
        @column_join_db_a = col_on_db_a
        @second_db = file_db_b
        @column_join_db_b = col_on_db_b
    end


    def delete 
        @type_of_query = :delete
        # delete all matching row
    end

    def _print_select
        puts "SELECT #{@columns} "
        puts "FROM #{@table_name} "
        if (@where_col)
            puts "WHERE #{@where_col} = #{@where_col_val}"
        end
        # @table_name.@column_join_db_a = @file_db_b.@column_join_db_b
        if (@column_join_db_a and @column_join_db_b and @second_db)
            puts "JOIN #{@second_db} ON #{@table_name}.#{@column_join_db_a}=#{@second_db}.#{@column_join_db_b}"
        end
        if (@order_col and @order_type == "desc")
            puts "ORDER BY #{@order_col} #{@order_type}"
        end
    end
    
    def _print_insert
        puts "INSERT INTO #{@table_name} "
        puts "VALUES #{@insert_vals} "
        if (@where_col)
            puts "WHERE #{@where_col} = #{@where_col_val}"
        end
    end
    
    def _print_update
        puts "UPDATE #{@table_name} "
        puts "SET #{@update_vals} "
        if (@where_col)
            puts "WHERE #{@where_col} = #{@where_col_val}"
        end
    end

    def _print_delete
        puts "DELETE FROM #{@table_name}"
        if (@where_col)
            puts "WHERE #{@where_col} = #{@where_col_val}"
        end
    end

    def _parser #select, update, delete, insert
        if (@type_of_query == :select)
            _print_select
            _exec_select            
        elsif(@type_of_query == :insert)
            _print_insert
            _exec_insert  
        elsif(@type_of_query == :update)
            _print_update
            _exec_update
        elsif(@type_of_query == :delete)
            _print_delete
            _exec_delete
        end
    
    end
    
    def _exec_select
        result = []
        csv = CSV.parse(File.read(@table_name), headers: true)
        if @join_flag != 1
            csv.each do |row|
                if row[@where_col] == @where_col_val and @where_col and @where_col_val
                    result << row.to_hash.slice(*@columns)
                else
                    result << row.to_hash.slice(*@columns)
                end
            end
        else
            csv_b = CSV.parse(File.read(@second_db), headers: true)
            csv.each do |row|
                csv_b.each do |row_b|
                    if !row[@column_join_db_a] or 
                        !row_b[@column_join_db_b] or 
                        !row.has_key?(@columns[0]) or 
                        !row_b.has_key?(@columns[1]) or
                        !row.has_key?(@where_col)
                        throw "Column doesn't exist in the database"
                    end
                    if (row[@column_join_db_a] == row_b[@column_join_db_b]) and (row[@where_col] == @where_col_val)
                        result << {@columns[0] => row[@columns[0]], @columns[1] => row_b[@columns[1]]}
                    elsif (!@where_col or !@where_col_val) and (row[@column_join_db_a] == row_b[@column_join_db_b])
                        result << {@columns[0] => row[@columns[0]], @columns[1] => row_b[@columns[1]]}
                    end
                end
            end
        end
        # p result.sort_by { |element| element.values }

        if (@order_col and @order_type == "desc")
            result = result.sort_by!{ |h| h[@order_col] }.reverse!
        elsif (@order_col and @order_type == "asc")
            result = result.sort_by{ |h| h[@order_col] }
        else
            result = result.sort_by { |element| element.values }
        end
        p result
    end

    def _exec_insert
        File.open(@table_name, 'a') do |file|
            file.puts @insert_vals.values.join(',')
        end
    end
    
    def _updating_file(csv)
        File.open(@table_name, 'w+') do |file|
            idx = 0
            csv.each do |row|
                if idx == 0
                    file << csv.headers.join(',') + "\n"
                end
                file << row
                idx += 1
            end
        end
    end

    def _exec_update
        csv = CSV.read(@table_name, headers:true)
        csv.each do |row|
            if @where_col and @where_col_val and (row[@where_col] == @where_col_val)
                row[@where_col] = @update_vals[@where_col]
            elsif !@where_col or !@where_col_val
                row[@update_vals.keys.join] = @update_vals.values.join
            end
        end
        _updating_file(csv)
    end

    def _exec_delete
        csv = CSV.read(@table_name, headers:true)
        csv.delete_if do |row|
            !@where_col and !@where_col_val
        end
        csv.delete_if do |row|
            @where_col and @where_col_val and (row[@where_col] == @where_col_val)
        end
        _updating_file(csv)
    end 

    def run
        _parser
    end

end

def main()
    request = MySqliteRequest.new #creating an instance
    # request.select('name')
    #PARSING
    # SELECT 

    request.select('name')
    request.from('test.csv')
    request.where('birth_date', "June 24, 1968")    # ===> OPTIONAL
    request.order('asc', 'asfd')                   # ===> OPTIONAL
    
    # INSERT / VALUES

    # request.insert('test.csv')
    # vals = {"name" => "Alaa Abdelnaby", "year_start" => "1991" ,"year_end" => "1995", "position" => "F-C","height" => "6-10" ,"weight" => "240","birth_date" => "'June 24, 1968'","college" => "Duke University"}
    # request.values(vals)
    # request.where('birth_state', 'Indiana')
    
    # UPDATE / SET
    
    # request.update('test.csv')
    # data = {"name" => "thays"}
    # request.set(data)
    # request.where('name', 'test') # ===> OPTIONAL

    # DELETE 
    # request.delete # delete the whole table
    # request.from('test.csv')
    # request.where('name', 'test') # ===> OPTIONAL

    # JOIN
    # request.select(['id', 'name']) # [col from 1st, col from 2nd]
    # request.from('orders.csv') # col 1st
    # # request.where('college', "Indiana University") # ===> OPTIONAL
    # request.join('cus_id', 'customers.csv', "cus_id") #Orders.CustomerID = Customers.CustomerID

    # request.select(['birth_city', 'college']) # [col from 1st, col from 2nd]
    # request.from('nba_players.csv') # col 1st
    # request.where('college', "Indiana University") # ===> OPTIONAL
    # request.join('Player', 'test.csv', "name") #Orders.CustomerID = Customers.CustomerID
    

    #EXECUTE
    request.run

    # ORDER / SELECT (ARRAY) =====> EXTRAS
    

end

main()

