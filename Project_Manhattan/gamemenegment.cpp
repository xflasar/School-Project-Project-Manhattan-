#include "gamemenegment.h"

GameMenegment::GameMenegment()
{

}

bool GameMenegment::loadGame(){
    QTextStream(stdout) << "LoadGame() CALLED";
    QFile loadFile(QStringLiteral("save.json"));

    if (!loadFile.open(QIODevice::ReadOnly)) {
        qWarning("Couldn't open save file.");
        return false;
    }

    QByteArray saveData = loadFile.readAll();

    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));

    read(loadDoc.object());

    return true;
}

bool GameMenegment::saveGame() const {
      QTextStream(stdout) << "SaveGame() CALLED ";
      QFile saveFile(QStringLiteral("save.json"));

      if (!saveFile.open(QIODevice::WriteOnly)) {
              qWarning("Couldn't open save file.");
              return false;
      }

      QJsonObject gameObject;
      write(gameObject);
      QJsonDocument saveDoc(gameObject);
      saveFile.write(saveDoc.toJson());

      return true;
}

void GameMenegment::read(const QJsonObject &json) {
    if (json.contains("tanks") && json["tanks"].isArray()) {
            QJsonArray tankArray = json["tanks"].toArray();
            m_tankList.clear();
            m_tankList.reserve(tankArray.size());
            for (int tankIndex = 0; tankIndex < tankArray.size(); ++tankIndex) {
                QJsonObject tankObject = tankArray[tankIndex].toObject();
                Tank* tank = new Tank("", {0,0});
                tank->read(tankObject);
                m_tankList.append(tank);
            }
        }
}

void GameMenegment::write(QJsonObject &json) const {
    QJsonArray tankArray;
        for (const Tank* tank : m_tankList) {
            QJsonObject tankObject;
            tank->write(tankObject);
            tankArray.append(tankObject);
        }
        json["tanks"] = tankArray;
}


void GameMenegment::appendTank(Tank* tankObj){
    m_tankList.append(tankObj);
}

void GameMenegment::readTankVector(const QJsonObject &json){
    if (json.contains("tanks") && json["tanks"].isArray()) {
        QJsonArray tankArray = json["tanks"].toArray();
        m_tankList.clear();
        m_tankList.reserve(tankArray.size());
        for (int tankIndex = 0; tankIndex < tankArray.size(); ++tankIndex) {
            QJsonObject tankObject = tankArray[tankIndex].toObject();
            Tank* tank;
            tank->read(tankObject);
            m_tankList.append(tank);
        }
    }
}

void GameMenegment::writeTankVector(QJsonObject &json) const {
    QJsonArray tankArray;
       for (const Tank* tank : m_tankList) {
           QJsonObject tankObject;
           tank->write(tankObject);
           tankArray.append(tankObject);
       }
       json["tanks"] = tankArray;
}

QVector<Tank*> GameMenegment::getTankList(){
    return m_tankList;
}
