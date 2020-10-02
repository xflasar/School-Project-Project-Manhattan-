#include "projectmanhattan.h"

projectmanhattan::projectmanhattan(QObject *parent) : QObject(parent)
{
    GameMenegment* management = new GameMenegment();
    m_management = management;
}

int projectmanhattan::getColumnCount(){
    return mapSizeM;
}

int projectmanhattan::getRowCount(){
    return mapSizeN;
}

void projectmanhattan::getInfoTile(int x, int y){

    qDebug() << m_map[x][y]->getOwner();
    qDebug() << m_map[x][y]->getHealth();
    qDebug() << m_map[x][y]->getDestroyed();

}
bool projectmanhattan::getTile(int x, int y){
    if(m_map[x][y]->getOwner() != "" && m_map[x][y]->getDestroyed() != true){
        return true;
    }
    return false;
}

int projectmanhattan::getCommand(){
    if(currCommand == "Move"){
        return 1;
    }
    if(currCommand == "Shoot")
    {
        return 3;
    }
    return 2;
}

QString projectmanhattan::getSelectedTankOwner(){
    return selectedTank->getOwner();
}

QVector<int> projectmanhattan::getSelectedTankPos(){
    QVector<int> vec = {selectedTank->getPos().x, selectedTank->getPos().y};
    return vec;
}

bool projectmanhattan::getSelectedTankIsEmpty(){
    if(selectedTank == nullptr){
        return  true;
    }
    return false;
}

void projectmanhattan::deselectSelectedTank(){
    selectedTank = nullptr;
}

void projectmanhattan::setCommand(QString str){
    currCommand = str;
}

void projectmanhattan::selectTank(int x, int y){
    selectedTank = m_map[x][y];
}
bool projectmanhattan::ableToMove(int x, int y){
    if((!getTile(x, y) && (m_map[getSelectedTankPos()[0]][getSelectedTankPos()[1]]->getDestroyed() != true) && ((-1 <= (getSelectedTankPos()[0] - x) && (getSelectedTankPos()[0] - x) <= 1) && (-1 <= (getSelectedTankPos()[1] - y) && (getSelectedTankPos()[1] - y) <= 1)))){
        return true;
    }
    return false;
}
void projectmanhattan::moveTank(int x, int y){
    if(selectedTank != nullptr){
        m_map[x][y] = selectedTank;
        m_map[selectedTank->getPos().x][selectedTank->getPos().y] = new Tank("",{selectedTank->getPos().x,selectedTank->getPos().y});
        m_map[x][y]->setNewPos(x,y);
        selectedTank = nullptr;
    }
    else{
        qDebug() << "You did not selected a tank to move!";

    }
}

void projectmanhattan::gameEnd(){
    if(playerTanksCount <= 0){
        // call Enemy Winner!!
        qDebug() << "Enemy Won!";
    }
    else if(enemyTanksCount <= 0){
        // call Player Winner
        qDebug() << "Player Won!";
    }
}

bool projectmanhattan::shootTank(int x, int y){
    if(m_map[x][y]->getDestroyed() != true){
        bool result = selectedTank->shootAt(getTank(x,y));
        if(result){
            if(m_map[x][y]->getOwner() == "Player"){
                playerTanksCount--;
            }
            else if(m_map[x][y]->getOwner() == "Enemy"){
                enemyTanksCount--;
            }
            if(playerTanksCount <= 0 || enemyTanksCount <= 0)
                gameEnd();
        }
        return result;
    }

    qDebug() << "Targeted tank is destroyed!";
    return false;
}

Tank* projectmanhattan::getTank(int x, int y){
    return m_map[x][y];
}

//  Main methods
void projectmanhattan::startGame(){
    m_map.clear();
    m_map = initMap(m_map);
    m_map = initializeStartUp(m_map);
}

void projectmanhattan::loadGame(){
    m_map.clear();
    playerTanksCount = 0;
    enemyTanksCount = 0;
    m_map = initMap(m_map);
    m_management->loadGame();
    fetchTankVector();
}

void projectmanhattan::saveGame(){
    fillTankVector();
    m_management->saveGame();
}


QVector<QVector<Tank*>> projectmanhattan::initMap(QVector<QVector<Tank*>> map){
    playerTanksCount = 0;
    enemyTanksCount = 0;
    for (int x = 0; x < 10; x++)
        {
            QVector<Tank*> v;
            for (int y = 0; y < 10; y++)
            {
                v.push_back(new Tank("", {x,y}));
            }
            map.push_back(v);
        }

        return map;
}

QVector<QVector<Tank*>> projectmanhattan::initializeStartUp(QVector<QVector<Tank*>> map){
    srand(time(NULL));
        for (int x = 0; x < 10; x++)
        {
            for (int y = 0; y < 10; y++)
            {
                if (y < 2)
                {
                    double randNum = (double)rand() / ((double)RAND_MAX);
                    if (randNum < 0.5f)
                    {
                        Tank* tank = new Tank("Player", {x, y});
                        map[x][y] =  tank;
                        playerTanksCount++;
                    }
                }
                else if (y > 7) {
                    double randNum = (double)rand() / ((double)RAND_MAX);
                    if (randNum < 0.5f)
                    {
                        Tank* tank = new Tank("Enemy", {x, y});
                        map[x][y] = tank;
                        enemyTanksCount++;
                    }
                }

            }
        }
        return map;
}

void projectmanhattan::fillTankVector(){
    for (int x=0; x<10; x++) {
        for (int y=0; y<10; y++){
           if (m_map[x][y]->getOwner() != "") m_management->appendTank(m_map[x][y]);
        }
    }
}

void projectmanhattan::fetchTankVector() {
    QVector<Tank*> tankVector = m_management->getTankList();
    for (int i=0; i<tankVector.size(); i++){
        putTankToMap(tankVector.at(i)->getPos(), tankVector.at(i));
    }
}

void projectmanhattan::putTankToMap(Position pos, Tank* tank){
    m_map[pos.x][pos.y] = tank;
    if(tank->getOwner() == "Player" && !tank->getDestroyed()){
        playerTanksCount++;
    }
    else if(tank->getOwner() == "Enemy" && !tank->getDestroyed()){
        enemyTanksCount++;
    }
}

QString projectmanhattan::getOwner(int x, int y) {
    return m_map[x][y]->getOwner();
}

QString projectmanhattan::getHealth(int x, int y) {
    return QString::number(m_map[x][y]->getHealth());
}
