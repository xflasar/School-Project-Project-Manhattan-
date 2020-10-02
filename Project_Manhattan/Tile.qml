import QtQuick 2.0

Rectangle {
    property alias imageTile: background
    property int y_cord: 0
    property int x_cord: 0
    property string picPath: "qrc:/resources/images/tank.jpg"
    id: tile
    width: (gridMap.width - 1)/10
    height: (gridMap.height - 1)/10
    border.width: 1
    border.color: "black"
    color: "grey"


    Image {
        id: background
        visible: false
        width: parent.width * 0.9
        height: parent.height * 0.9
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectCrop
        source: picPath
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {          
            switch(ProjectManhattan.getCommand())
            {
            case 1:
                if(ProjectManhattan.ableToMove(x_cord, y_cord)){
                    gridMap.columnMap.repeaterColumn.itemAt(ProjectManhattan.getSelectedTankPos()[0]).repeaterRow.itemAt(ProjectManhattan.getSelectedTankPos()[1]).imageTile.visible = false
                    ProjectManhattan.moveTank(x_cord, y_cord)
                    gridMap.columnMap.repeaterColumn.itemAt(x_cord).repeaterRow.itemAt(y_cord).imageTile.visible = true
                    if(ProjectManhattan.getOwner(x_cord,y_cord) === "Player") gridMap.columnMap.repeaterColumn.itemAt(x_cord).repeaterRow.itemAt(y_cord).picPath = "qrc:/resources/images/tank_player.jpg"
                    else gridMap.columnMap.repeaterColumn.itemAt(x_cord).repeaterRow.itemAt(y_cord).picPath = "qrc:/resources/images/tank_enemy.jpg"
                    console.log(ProjectManhattan.getCommand() + " Moved")
                    ProjectManhattan.setCommand("Select")
                    infoPanel.info_shot = "moved"
                }
                else{
                    console.log("The wanted tile is not empty or is too far away( you can move only 1 tile in any direction!)")
                }

                break
            case 2:
                ProjectManhattan.getInfoTile(x_cord, y_cord)
                if(ProjectManhattan.getTile(x_cord, y_cord)){

                    if(!ProjectManhattan.getSelectedTankIsEmpty()){
                        if(ProjectManhattan.getSelectedTankOwner() == "Player") {
                            gridMap.columnMap.repeaterColumn.itemAt(ProjectManhattan.getSelectedTankPos()[0]).repeaterRow.itemAt(ProjectManhattan.getSelectedTankPos()[1]).picPath = "qrc:/resources/images/tank_player.jpg"
                        }
                        else if(ProjectManhattan.getSelectedTankOwner() == "Enemy")
                        {
                            gridMap.columnMap.repeaterColumn.itemAt(ProjectManhattan.getSelectedTankPos()[0]).repeaterRow.itemAt(ProjectManhattan.getSelectedTankPos()[1]).picPath = "qrc:/resources/images/tank_enemy.jpg"
                        }
                   }

                    ProjectManhattan.selectTank(x_cord, y_cord)
                    console.log(ProjectManhattan.getCommand() + " SelectedTank")

                    if(ProjectManhattan.getOwner(x_cord,y_cord) === "Player")
                    {
                        tile.picPath = "qrc:/resources/images/tank_selected_player.jpg"
                    }
                    else if(ProjectManhattan.getOwner(x_cord,y_cord) === "Enemy")
                    {
                        tile.picPath = "qrc:/resources/images/tank_selected_enemy.jpg"
                    }

                    infoPanel.tankHealth = ProjectManhattan.getHealth(x_cord, y_cord)
                    infoPanel.tank_owner = ProjectManhattan.getOwner(x_cord, y_cord)
                    infoPanel.info_shot = "selected"
                }
                else{
                    console.log("Tile is empty or there is a destroyed tank!")
                    infoPanel.info_shot = "empty tile"

                    if(!ProjectManhattan.getSelectedTankIsEmpty()){
                        if(ProjectManhattan.getSelectedTankOwner() == "Player") {
                            gridMap.columnMap.repeaterColumn.itemAt(ProjectManhattan.getSelectedTankPos()[0]).repeaterRow.itemAt(ProjectManhattan.getSelectedTankPos()[1]).picPath = "qrc:/resources/images/tank_player.jpg"
                        }
                        else if(ProjectManhattan.getSelectedTankOwner() == "Enemy")
                        {
                            gridMap.columnMap.repeaterColumn.itemAt(ProjectManhattan.getSelectedTankPos()[0]).repeaterRow.itemAt(ProjectManhattan.getSelectedTankPos()[1]).picPath = "qrc:/resources/images/tank_enemy.jpg"
                        }

                        ProjectManhattan.deselectSelectedTank()
                    }
                }
                break
            case 3:
                if(ProjectManhattan.shootTank(x_cord, y_cord) === true){
                    tile.picPath = "qrc:/resources/images/tank_destroyed.jpg"
                    infoPanel.tankHealth = "0"
                    infoPanel.tank_owner = "Destroyed"
                }
                ProjectManhattan.setCommand("Select")
                infoPanel.info_shot = "shooted"
                break
            }


            //  Debug
            /*ProjectManhattan.getInfoTile(x_cord, y_cord);
            console.log("Clicked on tile number: " + "Cords: " + x_cord + "," + y_cord)*/
        }


        onEntered: {
            border.color = "lightgrey"
            border.width = 2
        }
        onExited: {
            border.color = "black"
            border.width = 1
        }
    }
}
