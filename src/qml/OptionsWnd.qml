import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.1

Rectangle {
    id: optionsWnd

    property alias animShow: animShow
    property alias animHide: animHide
    property alias boardSize: sliderBoardSize.value

    signal apply;

    width: 380
    height: 380
    radius: 3
    color: "#bcada0"

    anchors {
        right: parent.right; rightMargin: 5
        left: parent.left; leftMargin: 5
        bottom: parent.bottom; bottomMargin: 5
        top: parent.top; topMargin: 100
    }
    NumberAnimation {
        id: animShow
        target: optionsWnd
        properties: "opacity"
        from: 0.0
        to: 1.0
        duration: 300
    }

    NumberAnimation {
        id: animHide
        target: optionsWnd
        properties: "opacity"
        from: 1.0
        to: 0.0
        duration: 300
    }

    Rectangle {
        x: 0
        y: 323
        width: 250
        height: 49
        color: "transparent"
        anchors.horizontalCenter: parent.horizontalCenter

        CustomBtn {
            id: btnApply
            x: 8
            y: 10
            label: "Apply"

            onClicked: {
                optionsWnd.animHide.start();
                optionsWnd.apply();
            }
        }

        CustomBtn {
            id: btnCancel
            x: 132
            y: 10
            label: "Cancel"

            onClicked: optionsWnd.animHide.start();
        }
    }

    Rectangle {
        id: rectangle1
        x: 8
        y: 8
        width: 259
        height: 37
        color: "transparent"

        Slider {
            id: sliderBoardSize
            x: 8
            y: 8
            width: 157
            height: 22
            stepSize: 1
            minimumValue: 0
            maximumValue: 5
            tickmarksEnabled: false

            onValueChanged: {
                var sum = 4 + value;
                labelSlider.text = sum + "x" + sum;
            }
        }

        Label {
            id: labelSlider
            x: 188
            y: 5
            color: "#ffffff"
            text: qsTr("4x4")
            font.bold: true
            font.pointSize: 23
            font.family: "Tahoma"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
