import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: mainWindow
    visible: true
    width: 840
    height: 360
    title: qsTr("Project Manhattan")

    Map{id: gridMap}

    Menu{id: menu}

    Quit{id: quit}

    Saved{id: saved}

    InfoPanel{id: infoPanel}

    color: "white"
}
