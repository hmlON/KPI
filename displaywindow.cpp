#include "displaywindow.h"
#include "ui_displaywindow.h"
#include "database.h"

DisplayWindow::DisplayWindow(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::DisplayWindow)
{
    ui->setupUi(this);

    DataBase db;
    db.connectionOpen();

    QSqlQuery query;
    query.prepare("select firstName,lastName,passport,numberOfDays,settlementDate,roomNumber,roomType from clients");
    query.exec();

    QSqlQueryModel * model = new QSqlQueryModel();
    model->setQuery(query);
    model->QSqlQueryModel::setHeaderData(0, Qt::Horizontal, "Имя");
    model->QSqlQueryModel::setHeaderData(1, Qt::Horizontal, "Фамилия");
    model->QSqlQueryModel::setHeaderData(2, Qt::Horizontal, "Паспорт");
    model->QSqlQueryModel::setHeaderData(3, Qt::Horizontal, "Количество дней");
    model->QSqlQueryModel::setHeaderData(4, Qt::Horizontal, "Дата посления");
    model->QSqlQueryModel::setHeaderData(5, Qt::Horizontal, "№ комнаты");
    model->QSqlQueryModel::setHeaderData(6, Qt::Horizontal, "Тип комнаты");
    ui->tableView->setModel(model);
    ui->tableView->resizeColumnToContents(3);
    ui->tableView->resizeColumnToContents(4);

    db.connectionClose();
}

DisplayWindow::~DisplayWindow()
{
    delete ui;
}
