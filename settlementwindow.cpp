#include "settlementwindow.h"
#include "ui_settlementwindow.h"
#include "hoteladmin_global.h"
#include <QDateTime>
#include "database.h"
#include <QMessageBox>
#include <QDebug>

SettlementWindow::SettlementWindow(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::SettlementWindow)
    {
        ui->setupUi(this);
        ui->settlementDateEdit->setDate(QDate::currentDate());
    }

SettlementWindow::~SettlementWindow()
{
    delete ui;
}

void SettlementWindow::on_addBtn_clicked()
{
    firstName = ui->firstNameEdit->text();
    lastName = ui->lastNameEdit->text();
    passport = ui->passportEdit->text();
    settlementDate = ui->settlementDateEdit->date().toString();
    bool ok1, ok2;
    numberOfDays = ui->numberOfDaysEdit->text().toInt(&ok1);
    roomNumber = ui->roomNumberEdit->text().toInt(&ok2);
    roomType = ui->roomTypeEdit->currentText();

    if((firstName == "")||(lastName == "")||(ok1 == false)||(ok2 == false)){
        QMessageBox::warning(this, "Ошибка ввода!", "Неправильно введены некоторые праметры!");
    } else {
        DataBase db;
        db.connectionOpen();

        QSqlQuery query;
//        query.prepare("insert into clients (firstName,lastName,passport,numberOfDays,settlementDate,roomNumber,roomType) values ('"+firstName+"','"+lastName+"','"+passport+"',"+numberOfDays+",'"+settlementDate+"',"+roomNumber+",'"+roomType+"')");
//        qDebug() << "insert into clients (firstName,lastName,passport,numberOfDays,settlementDate,roomNumber,roomType) values ('"+firstName+"','"+lastName+"','"+passport+"',"+QString::number(numberOfDays)+",'"+settlementDate+"',"+QString::number(roomNumber)+",'"+roomType+"')";
        query.prepare("insert into clients (firstName,lastName,passport,numberOfDays,settlementDate,roomNumber,roomType) values (:firstName, :lastName, :passport, :numberOfDays, :settlementDate, :roomNumber, :roomType)");
        qDebug() << "insert into clients (firstName,lastName,passport,numberOfDays,settlementDate,roomNumber,roomType) values (:firstName, :lastName, :passport, :numberOfDays, :settlementDate, :roomNumber, :roomType)";
        query.bindValue(":firstName", firstName);
        query.bindValue(":lastName", lastName);
        query.bindValue(":passport", passport);
        query.bindValue(":numberOfDays", numberOfDays); //QString::number(
        query.bindValue(":settlementDate", settlementDate);
        query.bindValue(":roomNumber", roomNumber);
        query.bindValue(":roomType", roomType);
        if(query.exec())
        {
            QMessageBox::information(this, "Успех!", "Клиент успешно добавлен!");
        } else {
            QMessageBox::warning(this, "Ошибка!", query.lastError().text());
        }

        db.connectionClose();
        this->close();
    }
}

void SettlementWindow::on_cancelBtn_clicked()
{
    this->close();
}
