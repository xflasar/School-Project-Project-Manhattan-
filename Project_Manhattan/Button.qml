import QtQuick 2.0

Rectangle {
    property string buttonText: "Default text"
    width: 150
    height: 35
    property string picturePath: "resources/images/bg-button-dark.jpg"

    Text {
        id: buttonLabel
        text: buttonText
        font.pointSize: 15
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.centerIn: parent
        anchors.fill: parent
        color: "white"
        z: 2
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            console.log("Click")
        }
        onEntered: {
            picturePath = "resources/images/bg-button-medium.jpg"
        }
        onExited: {
            picturePath = "resources/images/bg-button-dark.jpg"
        }
    }

    Image {
        id: buttonBackground
        width: parent.width
        height: parent.height
        fillMode: Image.Stretch
        source: picturePath
    }
}
