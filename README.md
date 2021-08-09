# my-sqlite

updating

## Description

1. Remake SQL Query Types: `SELECT`, `INSERT`, `UPDATE`, `DELETE`
2. Remake SQL Query Commands: `SET`, `VALUES`, `ORDER`, `JOIN`, `FROM`, `WHERE`
3.

## Part 1 => tapa

---

Create a `class` called `MySqliteRequest` in `my_sqlite_request.rb.` It will have a similar behavior than a request on the real sqlite.

All methods, except run, will `return an instance of my_sqlite_request`. You will build the request by progressive call and `execute the request` by `calling run`.

`Each row must have an ID`

We will do only 1 join and 1 where per request.

`Example 1:`

```
request = MySqliteRequest.new
request = request.from('nba_player_data.csv')
request = request.select('name')
request = request.where('birth_state', 'Indiana')
request.run
=> [{"name" => "Andre Brown"]
```

`Example 2:`

```
Input: MySqliteRequest('nba_player_data').select('name').where('birth_state', 'Indiana').run
Output: [{"name" => "Andre Brown"]
```

`Constructor`

```
def initialize
```

`SQL FROM Command`

```
From Implement a from method which must be present on each request. From will take a parameter and it will be the name of the table. (technically a table_name is also a filename (.csv))

def from(table_name)
```

`SQL SELECT Command`

```
From Implement a from method which must be present on each request. From will take a parameter and it will be the name of the table. (technically a table_name is also a filename (.csv))

def from(table_name)
```

TODO </br>

##

PARSING (AUG 6th, 2021)

-   def initialize ✅
-   def from(table_name)✅
-   def select(column_name) OR def select([column_name_a, column_name_b]) ✅
-   def where(column_name, criteria) ✅
-   def order(order, column_name) ✅
-   def insert(table_name) ✅
-   def values(data)✅
-   def update (table_name)✅
-   def set(data)✅

ALGO (AUG 7th, 2021)

-   def delete ✅
-   def join(column_on_db_a, filename_db_b, column_on_db_b) ✅
-   def exec_select ✅
-   fix path in File.read() ✅
-   def exec_insert ✅
-   def exec_update ✅
-   def exec_delete
-   def join
-   def order
-   PART II
-   try to split the class into files by query type

ALGO (AUG 8th, 2021)
