import QtQuick 2.0

Rectangle {
    id: saved
    width: 330
    height: 100
    anchors.centerIn: parent
    border.color: "white"
    border.width: 2
    visible: false

    Text {
        id: savedText
        text: qsTr("Game successfully saved")
        color: "white"
        font.pointSize:15
        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 45
        anchors.top: parent.top
        anchors.topMargin: 14
        z:1
    }

    Button {
        id: okButton
        buttonText: "Ok"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 90
        anchors.topMargin: 52
        z:1
        MouseArea {
            anchors.fill: parent
            onClicked: saved.visible = false
        }
    }

    Image {
        id: buttonBackground
        width: parent.width
        height: parent.height
        fillMode: Image.Stretch
        source: "resources/images/bg-button-saved.jpg"
        z: 0
    }
}
