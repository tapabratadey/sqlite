# 1. types of query = select, delete, update, insert    => GRAB QUERY TYPE
# 2. table name = nba.csv                               => FROM
# 3. select_columns = single columns or array columns   => SELECT
# 4. order_type = asc (default) OR DESC => "selects"    => ORDER
# 5. where col = WHERE filter query                     => WHERE
# 6. where val = WHERE filter query value               => WHERE
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
            puts @update_vals
        else
            raise "SET must correspond with UPDATE Query"
        end
    end

    # def join(column_on_db_a, filename_db_b, column_on_db_b)
    # end

    # def delete
        # @type_of_query = :delete
    # end
    
    # def run
    #     # SELECT name FROM nba_player_data.csv WHERE birth_state = Indiana
    #     # @type_of_query @columns @table_name ...
        
    #     1. first we grab the table data (file) => loop through it
    #     2. find a match with all our queries 
	# end
end


# @return {array of hash} [{ }]

def main()
    request = MySqliteRequest.new #creating an instance
    
    #PARSING
    # request.from('nba_player_data.csv')
    # request.select('name')
    # request.select(['name', 'test'])
    # request.where('birth_state', 'Indiana')
    # request.order('name', 'desc')
    
    # INSERT / VALUES

    # request.insert('nba_player_data.csv')
    # vals = {"name" => "Alaa Abdelnaby", "year_start" => "1991" ,"year_end" => "1995", "position" => "F-C","height" => "6-10" ,"weight" => "240","birth_date" => "June 24, 1968","college" => "Duke University"}
    # request.values(vals)
    
    # UPDATE / SET
    
    request.update('nba_player_data.csv')
    data = {"name" => "tapa"}
    request.set(data)
    
    
    #EXECUTE
    # request.run
end

main()