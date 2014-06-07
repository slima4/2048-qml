import QtQuick 2.0
import "logic.js" as Logic

Rectangle {
    id: gameOverRect
    width: 380
    height: 380
    radius: 3;
    visible: false;
    opacity: 0.0
    color: "#bbada0"

    property alias animateOpacity: animateOpacity

    anchors {
        right: parent.right; rightMargin: 5
        left: parent.left; leftMargin: 5
        bottom: parent.bottom; bottomMargin: 5
        top: parent.top; topMargin: 100
    }

    Text {
        id: text1
        x: 0
        y: 110
        width: 380
        height: 66
        color: "#766d65"
        text: qsTr("Game Over!")
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        font.family: "Verdana"
        font.pixelSize: 49
    }

    Rectangle {
        id: rectangle2
        x: 90
        y: 200
        width: 200
        height: 43
        color: "#8c7963"
        radius: 3
        clip: false

        Text {
            x: 87
            y: 14
            color: "#e2e1d6"
            text: qsTr("Try again")
            font.bold: true
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 21
        }
        MouseArea {
            anchors.fill: parent;
            onClicked: Logic.restart();
        }
    }

    NumberAnimation {
        id: animateOpacity
        target: gameOverRect
        properties: "opacity"
        from: 0.00
        to: 0.80
        duration: 1000
   }
}
