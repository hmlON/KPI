#ifndef EVICTIONWINDOW_H
#define EVICTIONWINDOW_H

#include <QWidget>

namespace Ui {
class EvictionWindow;
}

class EvictionWindow : public QWidget
{
    Q_OBJECT

public:
    explicit EvictionWindow(QWidget *parent = 0);
    ~EvictionWindow();

private slots:
    void on_searchBtn_clicked();

    void on_showAllBtn_clicked();

    void on_deleteBtn_clicked();

private:
    Ui::EvictionWindow *ui;
};

#endif // EVICTIONWINDOW_H
