import QtQuick 2.0

Rectangle {
    property int col: 4
    property int row: 4
    radius: 3;

    anchors {
        right: parent.right; rightMargin: 5
        left: parent.left; leftMargin: 5
        bottom: parent.bottom; bottomMargin: 5
        top: parent.top; topMargin: 100
    }
    color: "#bbada0"

    Grid {
        id: grid
        anchors.fill: parent;
        columns: col;
        rows: row;
        Repeater {
            model: grid.columns * grid.rows;

            Rectangle {
                width: grid.width / grid.columns;
                height: grid.height / grid.rows;
                color: "transparent";
                Rectangle {
                    color: "#ccc0b2"
                    radius: 3
                    anchors {
                        right: parent.right; rightMargin: 5
                        left: parent.left; leftMargin: 5
                        bottom: parent.bottom; bottomMargin: 5
                        top: parent.top; topMargin: 5
                    }
                }
            }
        }
    }
}
