import QtQuick 2.0

Rectangle {
    id: tankInfo
    width: 150
    height: 100
    property string tankOwner: "Default owner"
    property string health: "Default health"

    Text {
        id: selected_tank
        text: "Selected Tank"
        font.pointSize: 15
        color: "white"
        z: 3
        anchors.leftMargin: 10
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.top: parent.top
    }

    Text {
        id: infoOwner
        text: "Owner: " + tankOwner
        font.pointSize: 15
        color: "white"
        z: 3
        anchors.leftMargin: 10
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.top: selected_tank.bottom
    }

    Text {
        id: infoHealth
        anchors.top: infoOwner.bottom
        anchors.leftMargin: 10
        anchors.left: parent.left
        text: "health: " + health
        font.pointSize: 15
        color: "white"
        z: 3
    }

    Image {
        id: buttonBackground
        width: parent.width
        height: parent.height
        fillMode: Image.PreserveAspectCrop
        source: "resources/images/bg-button-quit.jpg"
        z: 0
    }

}
