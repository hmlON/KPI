@app.route('/lists/<id>')
def delete_list():
    if not 'email' in session:
        return redirect(url_for('index'))

    sql = f"SELECT id FROM users WHERE email='{session['email']}'"
    cursor.execute(sql)
    user_id = cursor.fetchall()[0][0]

    sql = f"DELETE FROM lists WHERE user_id={user_id} AND id={id}"
    cursor.execute(sql)
    db.commit()

    return redirect(url_for('show_lists'))