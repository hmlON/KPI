#include "searchwindow.h"
#include "ui_searchwindow.h"
#include "database.h"

SearchWindow::SearchWindow(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::SearchWindow)
{
    ui->setupUi(this);
}

SearchWindow::~SearchWindow()
{
    delete ui;
}

void SearchWindow::on_searchBtn_clicked()
{
    DataBase db;
    db.connectionOpen();

    QSqlQuery query;
    QString searchText = ui->searchEdit->text();
    if(searchText == ""){
        query.prepare("select firstName,lastName,passport,numberOfDays,settlementDate,roomNumber,roomType from clients");
    } else if(ui->searchType->currentText() == "Номеру комнаты") {
        query.prepare("select firstName,lastName,passport,numberOfDays,settlementDate,roomNumber,roomType from clients where roomNumber=" + searchText);
    } else if(ui->searchType->currentText() == "Имени") {
        query.prepare("select firstName,lastName,passport,numberOfDays,settlementDate,roomNumber,roomType from clients where firstName like '%" + searchText + "%'");
    } else if(ui->searchType->currentText() == "Фамилии") {
        query.prepare("select firstName,lastName,passport,numberOfDays,settlementDate,roomNumber,roomType from clients where lastName like '%" + searchText + "%'");
    } else if(ui->searchType->currentText() == "Паспорту") {
        query.prepare("select firstName,lastName,passport,numberOfDays,settlementDate,roomNumber,roomType from clients where passport like '%" + searchText + "%'");
    }
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
