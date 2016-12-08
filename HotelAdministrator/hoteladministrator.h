#ifndef HOTELADMINISTRATOR_H
#define HOTELADMINISTRATOR_H

#include <QWidget>
#include "settlementwindow.h"
#include "searchwindow.h"
#include "displaywindow.h"
#include "evictionwindow.h"

namespace Ui {
class HotelAdministrator;
}

class HotelAdministrator : public QWidget
{
    Q_OBJECT

public:
    explicit HotelAdministrator(QWidget *parent = 0);
    ~HotelAdministrator();

private slots:
    void on_settlementBtn_clicked();

    void on_evictionBtn_clicked();

    void on_searchBtn_clicked();

    void on_displayBtn_clicked();

private:
    Ui::HotelAdministrator *ui;
    SettlementWindow *settlementWindow;
    SearchWindow *searchWindow;
    DisplayWindow *displayWindow;
    EvictionWindow *evictionWindow;
};

#endif // HOTELADMINISTRATOR_H
