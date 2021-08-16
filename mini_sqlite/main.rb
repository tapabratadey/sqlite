require 'csv'
require 'readline'
require 'optparse'
Dir["./sqlite_files/*.rb"].each {|sqlite_file| require sqlite_file }

$test_table = './csv_files/test.csv'
$nba_players_table = './csv_files/nba_players.csv'

#==========
#  SELECT
#==========

def select_query(request) # with order
    request.select('name')
    request.from($test_table)
    request.where('birth_date', "June 24, 1968")    # ===> OPTIONAL
    request.order('desc', 'name')
end
SELECT birth_city, college from nba_players
def select_join_query(request) # join
    request.select(['birth_city', 'college'])
    request.from($nba_players_table)
    # request.where('college', "Indiana University")
    # request.join('Player', $test_table, "name")
    p request.run
end

#==========
# UPDATE
#==========

def update_query(request)
    request.update($test_table)
    data = {"name" => "thays"}
    request.set(data)
    request.where('name', 'test') # ===> OPTIONAL
    request.run
end

#==========
# INSERT
#==========

def insert_query(request)
    request.insert($test_table)
    vals = {"name" => "Alaa Abdelnaby", "year_start" => "1991" ,"year_end" => "1995", "position" => "F-C","height" => "6-10" ,"weight" => "240","birth_date" => "'June 24, 1968'","college" => "Duke University"}
    request.values(vals)
    request.run
end

#==========
# DELETE
#==========

def delete_query(request)
    request.delete # delete the whole table
    request.from($test_table)
    request.where('name', 'test') # ===> OPTIONAL
    request.run
end

def main()
    request = MySqliteRequest.new
    # select_query(request)
    # select_join_query(request)
    # update_query(request)
    # insert_query(request)
    # delete_query(request)
    req_cli = SqliteCli.new
    req_cli.read_cli(request)
end

main()

=begin
    $>ruby my_sqlite_cli.rb class.db 

    MySQLite version 0.1 20XX-XX-XX
    
    my_sqlite_cli> SELECT * FROM students; =====> ["SELECT", [*], "FROM", "students"]
    Jane|me@janedoe.com|A|http://blog.janedoe.com
    
    my_sqlite_cli>INSERT INTO students VALUES (John, john@johndoe.com, A, https://blog.johndoe.com);
    
    my_sqlite_cli>UPDATE students SET email = 'jane@janedoe.com', blog = 'https://blog.janedoe.com' WHERE name = 'Jane';
    
    my_sqlite_cli>DELETE FROM students WHERE name = 'John';
    
    my_sqlite_cli>quit
$>
SELECT * FROM students WHERE name = "thays";
SELECT * FROM students WHERE name = "thays" JOIN ON table2
ON table1.column_name = table2.column_name;
SELECT * FROM students WHERE name = "thays" JOIN ON table2
ON table1.column_name = table2.column_name ORDER;




SELECT => 1 or 2 Columns or * | * == give me everything
!FROM = err ELSE get target table from the next index
WHERE =>


=end