#ifndef TANK_H
#define TANK_H

#include <iostream>
#include <string>
#include <position.h>
#include <QJsonObject> // save,load

class Tank
{
     QString m_owner;
     int m_health = 100;
     Position m_pos;
     bool m_destroyed = false;

public:
    Tank(QString owner, Position pos);
    void moveTo(Position pos);
    bool shootAt(Tank* tank);
    Position getPos();
    QString getOwner();
    int getHealth();
    bool getDestroyed();
    void setNewPos(int x, int y);

    // save and load
    void read(const QJsonObject &json);
    void write(QJsonObject &json) const;

};

#endif // TANK_H
