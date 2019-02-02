import mysql.connector


def create_database(db_name):
    print(f"Creating {db_name} database")

    db = mysql.connector.connect(
      host="localhost",
      user="root",
      passwd=""
    )
    cursor = db.cursor()

    cursor.execute(f"CREATE DATABASE IF NOT EXISTS {db_name}")
    print(f"Created a database {db_name}")
    print()


def create_table(db_name, table_name, sql):
    print(f"Creating {table_name} table in {db_name} database")

    db = mysql.connector.connect(
      host="localhost",
      user="root",
      passwd="",
      database=db_name
    )
    cursor = db.cursor()

    cursor.execute(sql)
    print(sql)

    print(f"Created {table_name} table")
    print()


db_name = 'todo'
create_database(db_name)

create_table(db_name, 'users',
    """
    CREATE TABLE IF NOT EXISTS users (
        id INT AUTO_INCREMENT,
        email VARCHAR(255) NOT NULL UNIQUE,
        pass VARCHAR(255) NOT NULL,
        PRIMARY KEY (id)
    ) ENGINE=INNODB;
    """
)

create_table(db_name, 'lists',
    """
    CREATE TABLE IF NOT EXISTS lists (
        id INT AUTO_INCREMENT,
        name VARCHAR(255) NOT NULL,
        deleted BOOL DEFAULT 0,
        user_id INT NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY fk_user(user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
    ) ENGINE=INNODB;
    """
)

create_table(db_name, 'tasks',
    """
    CREATE TABLE IF NOT EXISTS tasks (
        id INT AUTO_INCREMENT,
        list_id INT NOT NULL,
        name VARCHAR(255) NOT NULL,
        description TEXT,
        created_date DATE, 
        due_date DATE,
        checked BOOL DEFAULT 0,
        deleted BOOL DEFAULT 0,
        PRIMARY KEY (id),
        FOREIGN KEY fk_list(list_id) REFERENCES lists(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
    ) ENGINE=INNODB;
    """
)
