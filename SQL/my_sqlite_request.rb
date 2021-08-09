# 1. types of query = select, delete, update, insert    => GRAB QUERY TYPE
# 2. table name = nba.csv                               => FROM
# 3. select_columns = single columns or array columns   => SELECT
# 4. order_type = asc (default) OR DESC => "selects"    => ORDER
# 5. where col = WHERE filter query                     => WHERE
# 6. where val = WHERE filter query value               => WHERE
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
        @order = order
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

    def join(column_on_db_a, filename_db_b, column_on_db_b)
        @column_join_db_a = column_on_db_a
        @second_db = filename_db_b
        @column_join_db_b = column_on_db_b
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
        end
    
    end
    
    def _exec_select
        result = []
        csv = CSV.parse(File.read(@table_name), headers: true)
        csv.each do |row|
            if row[@where_col] == @where_col_val
                result << row.to_hash.slice(*@columns)
            end
        end
        result
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
    
    def run
        _parser
    end
    
end

# @return {array of hash} [{ }]

def main()
    request = MySqliteRequest.new #creating an instance
    
    #PARSING

    # SELECT 

    # request.select('name')
    # request.from('nba_player_data.csv')
    # request.where('birth_date', "June 24, 1968") # ===> OPTIONAL
    
    # INSERT / VALUES

    # request.insert('test.csv')
    # vals = {"name" => "Alaa Abdelnaby", "year_start" => "1991" ,"year_end" => "1995", "position" => "F-C","height" => "6-10" ,"weight" => "240","birth_date" => "'June 24, 1968'","college" => "Duke University"}
    # request.values(vals)
    # request.where('birth_state', 'Indiana')
    
    # UPDATE / SET
    
    request.update('test.csv')
    data = {"name" => "thays"}
    request.set(data)
    request.where('name', 'test') # ===> OPTIONAL
    
    #EXECUTE
    request.run

    # ORDER / SELECT (ARRAY) =====> EXTRAS

    # request.order('name', 'desc')
    # request.select(['name', 'test'])

end

main()

