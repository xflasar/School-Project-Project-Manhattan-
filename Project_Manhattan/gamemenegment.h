#ifndef GAMEMENEGMENT_H
#define GAMEMENEGMENT_H

#include <QObject>
#include <QFile>
#include <QJsonObject>
#include <QJsonDocument>
#include <QDataStream>
#include <QTextStream>
#include <QJsonArray>
#include <tank.h>

class GameMenegment
{
public:
    GameMenegment();

    Tank tank() const;
    QVector<QVector<Tank>> map() const;

    bool loadGame();
    bool saveGame() const;

    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

    void appendTank(Tank* tankObj);

    void readTankVector(const QJsonObject &json);
    void writeTankVector(QJsonObject &json) const;

    QVector<Tank*> getTankList();
private:
    QVector<Tank*> m_tankList;
};

#endif // GAMEMENEGMENT_H
