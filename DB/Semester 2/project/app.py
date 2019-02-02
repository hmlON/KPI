from flask import Flask, render_template, request, redirect, url_for, session
import mysql.connector


app = Flask(__name__)
app.secret_key = 'plzdonthackme'
db = mysql.connector.connect(host="localhost", user="root", passwd="", database="todo")
cursor = db.cursor()


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/signup', methods=['POST'])
def signup():
    email = request.form['email']
    sql = f"SELECT id from users where email='{email}'"
    cursor.execute(sql)
    email_exists = cursor.fetchall()
    if email_exists:
        return redirect(url_for('index'))

    sql = "INSERT INTO users (email, pass) VALUES (%s, %s)"
    email = request.form['email']
    val = (email, request.form['password'])
    cursor.execute(sql, val)
    db.commit()
    session['email'] = email
    return render_template('signup.html')


@app.route('/login', methods=['POST'])
def login():
    sql = "SELECT email FROM users WHERE email=%s AND pass=%s LIMIT 1"
    val = (request.form['email'], request.form['password'])
    cursor.execute(sql, val)
    users = cursor.fetchall()
    if users:
        user_email = users[0][0]
        session['email'] = user_email
        return redirect(url_for('show_lists'))
    else:
        return redirect(url_for('index'))


@app.route('/logout')
def logout():
    session.pop('email', None)
    return redirect(url_for('index'))


@app.route('/lists')
def show_lists():
    if not 'email' in session:
        return redirect(url_for('index'))

    sql = f"SELECT id FROM users WHERE email='{session['email']}'"
    cursor.execute(sql)
    user_id = cursor.fetchall()[0][0]

    sql = f"SELECT id, name FROM lists WHERE user_id={user_id} AND deleted=0"
    cursor.execute(sql)
    lists = cursor.fetchall() or []
    # lists = [{'email': list[1], 'id': list[0]} for list in lists]

    return render_template('lists.html', lists=lists)


@app.route('/lists', methods=['POST'])
def create_list():
    if not 'email' in session:
        return redirect(url_for('index'))

    sql = f"SELECT id FROM users WHERE email='{session['email']}'"
    cursor.execute(sql)
    user_id = cursor.fetchall()[0][0]

    name = request.form['name']
    sql = f"INSERT INTO lists (name, user_id) VALUES ('{name}', {user_id})"
    cursor.execute(sql)
    db.commit()

    return redirect(url_for('show_lists'))


@app.route('/lists/<id>')
def show_list(id):
    if not 'email' in session:
        return redirect(url_for('index'))

    sql = f"SELECT id FROM users WHERE email='{session['email']}'"
    cursor.execute(sql)
    user_id = cursor.fetchall()[0][0]

    sql = f"SELECT id, name FROM lists WHERE user_id={user_id} AND id={id}"
    cursor.execute(sql)
    task_list = cursor.fetchall()[0]

    sql = f"SELECT id, name, checked, description, due_date FROM tasks WHERE list_id={id} AND deleted=0"
    cursor.execute(sql)
    tasks = cursor.fetchall()
    # tasks = [list(task) for task in tasks]
    completed = [task for task in tasks if task[2]]
    incompleted = [task for task in tasks if not task[2]]

    return render_template('list.html', task_list=task_list, incompleted=incompleted, completed=completed)


@app.route('/lists/<id>/delete', methods=["POST"])
def delete_list(id):
    if not 'email' in session:
        return redirect(url_for('index'))

    sql = f"SELECT id FROM users WHERE email='{session['email']}'"
    cursor.execute(sql)
    user_id = cursor.fetchall()[0][0]

    sql = f"UPDATE lists SET deleted=1 WHERE id={id}"
    # sql = f"DELETE FROM lists WHERE id={id}"
    cursor.execute(sql)
    db.commit()

    return redirect(url_for('show_lists'))


@app.route('/tasks', methods=['POST'])
def create_task():
    if not 'email' in session:
        return redirect(url_for('index'))

    sql = f"SELECT id FROM users WHERE email='{session['email']}'"
    cursor.execute(sql)
    user_id = cursor.fetchall()[0][0]

    name = request.form['name']
    description = request.form['description']
    due_date = request.form['due_date']
    due_date = f"'{due_date}'" if due_date else 'NULL'

    list_id = request.form['list_id']
    sql = f"INSERT INTO tasks (name, list_id, description, due_date) VALUES ('{name}', {list_id}, '{description}', {due_date})"
    cursor.execute(sql)
    db.commit()

    return redirect(url_for('show_list', id=list_id))


@app.route('/tasks/<id>/check', methods=['POST'])
def check_task(id):
    if not 'email' in session:
        return redirect(url_for('index'))

    sql = f"SELECT id FROM users WHERE email='{session['email']}'"
    cursor.execute(sql)
    user_id = cursor.fetchall()[0][0]

    sql = f"UPDATE tasks SET checked=1 WHERE id={id}"
    cursor.execute(sql)
    db.commit()

    list_id = request.form['list_id']
    return redirect(url_for('show_list', id=list_id) )


@app.route('/tasks/<id>/uncheck', methods=['POST'])
def uncheck_task(id):
    if not 'email' in session:
        return redirect(url_for('index'))

    sql = f"SELECT id FROM users WHERE email='{session['email']}'"
    cursor.execute(sql)
    user_id = cursor.fetchall()[0][0]

    sql = f"UPDATE tasks SET checked=0 WHERE id={id}"
    cursor.execute(sql)
    db.commit()

    list_id = request.form['list_id']
    return redirect(url_for('show_list', id=list_id) )


@app.route('/tasks/<id>/delete', methods=["POST"])
def delete_task(id):
    if not 'email' in session:
        return redirect(url_for('index'))

    sql = f"SELECT id FROM users WHERE email='{session['email']}'"
    cursor.execute(sql)
    user_id = cursor.fetchall()[0][0]

    sql = f"UPDATE tasks SET deleted=1 WHERE id={id}"
    # sql = f"DELETE FROM tasks WHERE id={id}"
    cursor.execute(sql)
    db.commit()

    list_id = request.form['list_id']
    return redirect(url_for('show_list', id=list_id) )
