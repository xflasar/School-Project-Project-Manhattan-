import QtQuick 2.0

Rectangle {
    id: quit
    width: 200
    height: 150
    anchors.centerIn: parent
    border.color: "white"
    border.width: 2
    visible: false

    Text {
        id: quitText
        text: qsTr("Are you sure?")
        color: "white"
        font.pointSize:15
        font.bold: true
        anchors.left: parent.left
        anchors.leftMargin: 32
        anchors.top: parent.top
        anchors.topMargin: 15
        z:1
    }



    Button {
        id: yesButton
        buttonText: "Yep"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 22
        anchors.topMargin: 50
        z:1
        MouseArea {
            anchors.fill: parent
            onClicked: Qt.quit()
        }
    }

    Button {
        id: cancelButton
        buttonText: "Cancel"
        anchors.top: yesButton.bottom
        anchors.left: parent.left
        anchors.topMargin: 10
        anchors.leftMargin: 22
        z:1
        MouseArea {
            anchors.fill: parent
            onClicked: quit.visible = false
        }
    }

    Image {
        id: buttonBackground
        width: parent.width
        height: parent.height
        fillMode: Image.Stretch
        source: "resources/images/bg-button-quit.jpg"
        z: 0
    }
}
