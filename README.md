# my-sqlite

## Description

1. Remake SQL Query Types: `SELECT`, `INSERT`, `UPDATE`, `DELETE`
2. Remake SQL Query Commands: `SET`, `VALUES`, `ORDER`, `JOIN`, `FROM`, `WHERE`
3.

## Part I

---

Create a `class` called `MySqliteRequest` in `my_sqlite_request.rb.` It will have a similar behavior than a request on the real sqlite.

All methods, except run, will `return an instance of my_sqlite_request`. You will build the request by progressive call and `execute the request` by `calling run`.

`Each row must have an ID`.

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
