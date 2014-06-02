import QtQuick 2.0

Rectangle {
    id: button
    width: 110
    height: 29
    color: "#8c7963"
    radius: 3

    signal clicked;
    property string label: "";

    Text {
        x: 18
        y: 6
        color: "#fbeee0"
        text: label
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.bold: true
        font.family: "Verdana"
        font.pixelSize: 14
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: button.clicked();
    }
}
