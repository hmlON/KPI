#include "hoteladministrator.h"
#include "ui_hoteladministrator.h"
#include "settlementwindow.h"
#include "searchwindow.h"

HotelAdministrator::HotelAdministrator(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::HotelAdministrator)
{
    ui->setupUi(this);
}

HotelAdministrator::~HotelAdministrator()
{
    delete ui;
}

void HotelAdministrator::on_settlementBtn_clicked()
{
    settlementWindow = new SettlementWindow();
    settlementWindow->show();
}

void HotelAdministrator::on_evictionBtn_clicked()
{
    evictionWindow = new EvictionWindow();
    evictionWindow->show();
}

void HotelAdministrator::on_searchBtn_clicked()
{
    searchWindow = new SearchWindow();
    searchWindow->show();
}

void HotelAdministrator::on_displayBtn_clicked()
{
    displayWindow = new DisplayWindow();
    displayWindow->show();
}
