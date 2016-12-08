#ifndef SETTLEMENTWINDOW_H
#define SETTLEMENTWINDOW_H

#include <QDialog>

namespace Ui {
class SettlementWindow;
}

class SettlementWindow : public QDialog
{
    Q_OBJECT

public:
    explicit SettlementWindow(QWidget *parent = 0);
    ~SettlementWindow();

private slots:
    void on_addBtn_clicked();

    void on_cancelBtn_clicked();

private:
    Ui::SettlementWindow *ui;
    QString firstName, lastName, settlementDate, roomType, passport;
    int numberOfDays, roomNumber;
};

#endif // SETTLEMENTWINDOW_H
