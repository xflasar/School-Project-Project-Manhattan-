import QtQuick 2.0

Rectangle {
    id: menu
    width: 280
    height: parent.height
    anchors.left: parent.left
    anchors.top: parent.top
    color: "black"

    Column{
        height: parent.height * 0.75
        anchors.centerIn: parent
        spacing: 10
        z: 2

        Button {
            buttonText: "Start Game"           
            MouseArea{
                anchors.fill: parent
                onClicked: {

                    //  Sets all variables and populate map with random generated tanks for both playes
                    console.log("Clicked")
                    ProjectManhattan.startGame()

                    // Sets the Image visibility to true if there is Tank with owner on the tile
                    for(var i = 0; i < gridMap.columnMap.repeaterColumn.count; i++){
                        for(var j = 0; j < gridMap.columnMap.repeaterColumn.count; j++){
                            console.log("Count item: " + gridMap.columnMap.repeaterColumn.itemAt(i).repeaterRow.itemAt(j).imageTile.visible)
                            if(ProjectManhattan.getTile(i,j)){
                                gridMap.columnMap.repeaterColumn.itemAt(i).repeaterRow.itemAt(j).imageTile.visible = true
                                if(ProjectManhattan.getOwner(i,j) === "Player") gridMap.columnMap.repeaterColumn.itemAt(i).repeaterRow.itemAt(j).picPath = "qrc:/resources/images/tank_player.jpg"
                                else gridMap.columnMap.repeaterColumn.itemAt(i).repeaterRow.itemAt(j).picPath = "qrc:/resources/images/tank_enemy.jpg"
                            }
                            else{
                                gridMap.columnMap.repeaterColumn.itemAt(i).repeaterRow.itemAt(j).imageTile.visible = false
                            }

                            console.log("Count item: " + gridMap.columnMap.repeaterColumn.itemAt(i).repeaterRow.itemAt(j).imageTile.visible)
                        }
                    }
                }
            }
        }


        Button {           
            buttonText: "Move"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    ProjectManhattan.setCommand("Move")
                    console.log(ProjectManhattan.getCommand())
                }
            }

        }

        Button {
            buttonText: "Shoot"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    ProjectManhattan.setCommand("Shoot")
                    console.log(ProjectManhattan.getCommand())
                }
            }
        }

        Button {
            buttonText: "Save"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Save Clicked")
                    ProjectManhattan.saveGame()
                    saved.visible = true
                }
            }
        }

        Button {
            buttonText: "Load"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Load Clicked")
                    ProjectManhattan.loadGame()

                    for(var i = 0; i < gridMap.columnMap.repeaterColumn.count; i++){
                        for(var j = 0; j < gridMap.columnMap.repeaterColumn.count; j++){
                            console.log("Count item: " + gridMap.columnMap.repeaterColumn.itemAt(i).repeaterRow.itemAt(j).imageTile.visible)
                            if(ProjectManhattan.getTile(i,j)){
                                gridMap.columnMap.repeaterColumn.itemAt(i).repeaterRow.itemAt(j).imageTile.visible = true
                                if(ProjectManhattan.getOwner(i,j) === "Player") gridMap.columnMap.repeaterColumn.itemAt(i).repeaterRow.itemAt(j).picPath = "qrc:/resources/images/tank_player.jpg"
                                else gridMap.columnMap.repeaterColumn.itemAt(i).repeaterRow.itemAt(j).picPath = "qrc:/resources/images/tank_enemy.jpg"
                            }
                            else{
                                gridMap.columnMap.repeaterColumn.itemAt(i).repeaterRow.itemAt(j).imageTile.visible = false
                            }

                            console.log("Count item: " + gridMap.columnMap.repeaterColumn.itemAt(i).repeaterRow.itemAt(j).imageTile.visible)
                        }
                    }
                }
            }
        }

        Button {
            buttonText: "Quit"
            MouseArea {
                anchors.fill: parent
                onClicked: quit.visible = true
            }
        }
    }

    Image {
        id: buttonBackground
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
        source: "resources/images/background_basic.png"
        z: 0
    }
}
