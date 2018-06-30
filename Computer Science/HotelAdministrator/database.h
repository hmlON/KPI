#include <QtSql>
#include <QFileInfo>
#include <QDebug>

#ifndef DATABASE_H
#define DATABASE_H

class DataBase
{
public:
    DataBase();
    QSqlDatabase db;
    bool connectionOpen() {
        db = QSqlDatabase::addDatabase("QSQLITE");
        db.setDatabaseName("/home/hmlon/QTProjects/HotelAdministrator/resourses/clients.sqlite");
        return db.open();
    }
    void connectionClose(){
        db.close();
        //db.removeDatabase(QSqlDatabase::defaultConnection);
    }
};

#endif // DATABASE_H
