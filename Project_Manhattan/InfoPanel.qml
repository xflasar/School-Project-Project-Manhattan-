import QtQuick 2.0

Rectangle {
    id: infoPanel
    width: 200
    height: parent.height
    anchors.left: gridMap.right
    anchors.top: parent.top
    color: "black"
    property string tankHealth: " "
    property string tank_owner: " "
    property string info_shot: " "

    Column{
        id: infoCol
        height: parent.height * 0.8
        anchors.centerIn: parent
        spacing: 10
        z: 2

        TankInfo {
            id: selectedTank
            tankOwner: tank_owner
            health: tankHealth
        }

        Rectangle {
            id: infoMessages
            width: 150
            height: 50

            Text {
                text: "Info: " + info_shot
                font.pointSize: 15
                color: "white"
                z: 3
                anchors.leftMargin: 10
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.top: parent.top
            }

            Image {
                width: parent.width
                height: parent.height
                fillMode: Image.PreserveAspectCrop
                source: "resources/images/bg-button-quit.jpg"
                z: 0
            }
        }


    }

    Image {
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
        source: "resources/images/background_basic.png"
        z: 0
    }
}
