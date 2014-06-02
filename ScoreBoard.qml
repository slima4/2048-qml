import QtQuick 2.0
import "logic.js" as Logic

Rectangle {
    id: scoreBoard
    width: 380
    height: 100
    color: "#fbfaef"

    property int score: 0;
    property int bestScore: 0

    signal optionsClicked;

    Text {
        id: name
        x: 5
        y: 8
        color: "#766d65"
        text: qsTr("2048")
        font.family: "Verdana"
        font.bold: true
        font.pixelSize: 40
    }

    Rectangle {
        x: 150
        y: 0
        width: 110
        height: 48
        color: "#bcada0"
        radius: 3
        anchors.verticalCenter: name.verticalCenter

        Text {
            id: text1
            x: 0
            y: 0
            color: "#f2e7d9"
            text: qsTr("SCORE")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 5
            font.pixelSize: 12
        }

        Text {
            id: text
            x: 38
            color: "#ffffff"
            text: score
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 21
            font.family: "Verdana"
            font.bold: true
            font.pixelSize: 20
        }
    }

    Rectangle {
        x: 265
        y: 0
        width: 110
        height: 48
        color: "#bbada0"
        radius: 3
        anchors.verticalCenter: name.verticalCenter

        Text {
            id: text3
            x: 0
            y: 0
            color: "#f2e7d9"
            text: qsTr("BEST")
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 5
            font.pixelSize: 12
        }

        Text {
            id: bestScoreText
            x: 38
            color: "#ffffff"
            text: bestScore
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 21
            font.family: "Verdana"
            font.bold: true
            font.pixelSize: 20
        }
    }

    CustomBtn {
        id: btnNewGame
        x: 265
        y: 63
        label: qsTr("New Game")

        onClicked: {
            bestScore = Math.max(bestScore, score);
            Logic.restart();
        }
    }

    CustomBtn {
        id: btnOptions
        x: 150
        y: 63
        label: qsTr("Options");

        onClicked: scoreBoard.optionsClicked();
    }
}
