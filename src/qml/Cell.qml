import QtQuick 2.0

import "logic.js" as Logic

Rectangle {
    id: cell

    property alias value: lable.text;
    property size size: Qt.size(20,20);
    property bool animMoveEnable: false;
    property bool animResizeEnable: false

    width: parent.width / Logic.columns;
    height: parent.height / Logic.rows;
    color: "transparent"
    Rectangle {
        id: styleBtn

        width: size.width;
        height: size.height;
        color: Logic.colors[value];
        radius: 3
        anchors.centerIn: parent

        Text {
            id: lable
            color: value == "2" || value == "4" ? "#786f66" : "#f7f8f0"
            text: value
            style: Text.Normal
            font.family: "Tahoma"
            font.bold: true
            anchors.centerIn: parent
            font.pixelSize: Logic.fontSize[value.length]
            horizontalAlignment: Text.AlignHCenter
        }

        Behavior on width {
            enabled: animResizeEnable;
            NumberAnimation {
                duration: 100;
            }
        }

        Behavior on height {
            enabled: animResizeEnable;
            NumberAnimation {
                duration: 100;
            }
        }
    }
    Behavior on x {
        enabled: animMoveEnable;
        NumberAnimation {
            duration: 100;
        }
    }

    Behavior on y {
        enabled: animMoveEnable;
        NumberAnimation {
            duration: 100;
        }
    }
}
