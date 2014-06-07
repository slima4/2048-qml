import QtQuick 2.2
import QtQuick.Controls 1.1
import Qt.labs.settings 1.0

import "logic.js" as Logic

ApplicationWindow {
    id: window;
    visible: true
    width: 380
    height: 480
    minimumHeight: height;
    minimumWidth: width;
    maximumHeight: height;
    maximumWidth: width;
    title: qsTr("2048")
    color: "#fbf8ef";

    Settings {
        id: settigns;
        property alias columns: board.col;
        property alias rows: board.row;
        property alias bestScore: scoreBoard.bestScore;
        property alias boardSize: optionsWnd.boardSize
    }

    property alias board: board;
    property alias scoreBoard: scoreBoard;
    property alias gameOverWnd: gameOverWnd

    ScoreBoard {
        id: scoreBoard;

        onOptionsClicked: {
            if (optionsWnd.opacity === 0.0)
                optionsWnd.animShow.start();
            else
                optionsWnd.animHide.start();
        }

        Component.onCompleted: {
            optionsWnd.opacity = 0.0;
        }
    }

    Board {
        id: board
    }

    Rectangle{
        focus: true
        Keys.onPressed: {
            Logic.move(event.key);
            event.accepted = true;
        }
    }

    GameOverWnd {
        id: gameOverWnd;
    }

    OptionsWnd {
        id: optionsWnd;

        onApply: {
            var value = boardSize + 4;
            board.col = Logic.columns = value
            board.row = Logic.rows = value
            Logic.restart();
        }
    }

    Component.onCompleted: {
        Logic.init(board.col,board.row,window);
    }

    Component.onDestruction: {
        scoreBoard.bestScore = Math.max(scoreBoard.bestScore, scoreBoard.score);
    }
}
