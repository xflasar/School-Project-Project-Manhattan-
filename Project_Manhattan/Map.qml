import QtQuick 2.0

Rectangle {
    property alias columnMap: mapColumn
    id: gridMap
    width: parent.height
    height: parent.height
    anchors.left: menu.right
    color: "black"

    Column {
        property alias  repeaterColumn: columnRepeater
        id: mapColumn
        Repeater{
            id: columnRepeater
            model: ProjectManhattan.getColumnCount()
            Row{
                property alias repeaterRow: rowRepeater
                id: mapRow
                property int x_pos: index
                Repeater{
                    id: rowRepeater
                    model: ProjectManhattan.getRowCount()
                    Tile{
                        x_cord: x_pos
                        y_cord: index


                    }
                }
            }
        }
    }
}
