#include "tank.h"

Tank::Tank(QString owner, Position pos)
{
    m_owner = owner;
    m_pos = pos;
    m_health = 100;
    m_destroyed = false;
}
Position Tank::getPos(){
    return m_pos;
}

QString Tank::getOwner(){
    return m_owner;
}

int Tank::getHealth(){
    return m_health;
}

bool Tank::getDestroyed(){
    return m_destroyed;
}

void Tank::setNewPos(int x, int y){
    m_pos = {x,y};
}

bool Tank::shootAt(Tank* tank){
    double randNum = (double)rand() / ((double)RAND_MAX);
    if(randNum <= 0.2){
        tank->m_health = 0;
    }
    else if(0.2 < randNum >= 0.7){
        if(randNum*100 < 0){
            randNum = randNum * (-1);
        }
        tank->m_health = tank->m_health - (randNum*100);
    }
    if(tank->m_health <= 0){
        tank->m_health = 0;
        tank->m_destroyed = true;
    }
    return tank->m_destroyed;
}

void Tank::read(const QJsonObject &json){
    if (json.contains("owner") && json["owner"].isString())
        m_owner = json["owner"].toString();

    if (json.contains("health") && json["health"].isDouble())
        m_health = json["health"].toInt();

    if (json.contains("positionX") && json["positionX"].isDouble() && json.contains("positionY") && json["positionY"].isDouble()){
        int posX = json["positionX"].toInt();
        int posY = json["positionY"].toInt();
        m_pos = {posX, posY};
    }

    if (json.contains("destroyed") && json["destroyed"].isBool())
        m_destroyed = json["destroyed"].toBool();
}

void Tank::write(QJsonObject &json) const {
    json["owner"] = m_owner;
    json["health"] = m_health;
    json["positionX"] = m_pos.x;
    json["positionY"] = m_pos.y;
    json["destroyed"] = m_destroyed;
}
