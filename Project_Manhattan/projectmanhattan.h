#ifndef PROJECTMANHATTAN_H
#define PROJECTMANHATTAN_H

#include <QObject>
#include <QVector>
#include <QDebug>
#include <math.h>
#include <tank.h>
#include <time.h>
#include <iostream>
#include <string>
#include <gamemenegment.h>

class projectmanhattan : public QObject
{
    Q_OBJECT
    int mapSizeM = 10;
    int mapSizeN = 10;
    Tank* selectedTank = nullptr;
    QString currCommand = "Select";
    QVector<QVector<Tank*>> m_map;
    GameMenegment* m_management;

private:
    int playerTanksCount = 0;
    int enemyTanksCount = 0;
public:
    explicit projectmanhattan(QObject *parent = nullptr);
    QVector<QVector<Tank*>> initMap(QVector<QVector<Tank*>> map);
    QVector<QVector<Tank*>> initializeStartUp(QVector<QVector<Tank*>> map);

    //  Movement
    Q_INVOKABLE bool ableToMove(int x, int y);
    Q_INVOKABLE void moveTank(int x, int y);

    //  Commands
    Q_INVOKABLE int getCommand();
    Q_INVOKABLE void setCommand(QString str);
    Q_INVOKABLE void selectTank(int x, int y);
    Q_INVOKABLE bool shootTank(int x, int y);
    Q_INVOKABLE QVector<int> getSelectedTankPos();
    Q_INVOKABLE QString getSelectedTankOwner();
    Q_INVOKABLE void deselectSelectedTank();
    Q_INVOKABLE bool getSelectedTankIsEmpty();

    //  Probably not needed
    Q_INVOKABLE int getColumnCount();
    Q_INVOKABLE int getRowCount();

    //Debug
    Q_INVOKABLE void getInfoTile(int x, int y);
    Q_INVOKABLE bool getTile(int x, int y);
    Q_INVOKABLE Tank* getTank(int x, int y);

    //  Main methods
    Q_INVOKABLE void startGame();
    Q_INVOKABLE void loadGame();
    Q_INVOKABLE void saveGame();
    void gameEnd();

    // usefull for save & load
    void fillTankVector();
    void fetchTankVector();
    void putTankToMap(Position pos, Tank* tank);

    Q_INVOKABLE QString getOwner(int x, int y);
    Q_INVOKABLE QString getHealth(int x, int y);

signals:

public slots:
};

#endif // PROJECTMANHATTAN_H
