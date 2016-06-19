#include "hoteladministrator.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    HotelAdministrator w;
    w.show();

    return a.exec();
}
