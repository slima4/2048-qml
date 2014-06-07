.pragma library

var columns = 4;
var rows = 4;

var arrGrid = [];
var arrCells = [];
var baseObj = null;
var moveCount = 0;
var moving = false;

var colors = { "": "white", "2":"#eee4da", "4":"#ece0c8", "8":"#f2b179", "16":"#f59563", "32":"#f57c5f", "64":"#f95c3b",
                "128":"#edce71", "256":"#eecc61", "512":"#ebc850", "1024":"#edc53f" }//, "2048":"#eec22e", "4096":"#3d3a33", "8192":"#3d3a33", "16384":"#3d3a33" }

var fontSize = { 0:1, 1:45, 2:40, 3:35, 4:30 }

function init(col, row, parent)
{
    columns = col;
    rows = row;
    baseObj = parent;

    for (var i = 0; i < rows; ++i) {
        arrCells[i] = [];
        for (var j = 0; j < columns; ++j) {
            arrCells[i][j] = 0;
        }
    }

    restart();
}

function cleanCells() {

    for (var i = 0; i < arrCells.length; ++i) {
        for (var j = 0; j < arrCells[i].length; ++j) {
            if (arrCells[i][j] !== 0) {
                arrCells[i][j].destroy();
            }
        }
    }

    for (var i = 0; i < rows; ++i) {
        arrCells[i] = [];
        for (var j = 0; j < columns; ++j) {
            arrCells[i][j] = 0;
        }
    }
}

function restart() {
    baseObj.scoreBoard.score = 0;

    cleanCells();

    for (var i = 0; i < rows; ++i) {
        arrGrid[i] = []
        for (var j = 0; j < columns; ++j) {
            arrGrid[i][j] = 0;
        }
    }

    rndBlock();
    rndBlock();

    moving = false;
    baseObj.gameOverWnd.opacity = 0.0
    baseObj.gameOverWnd.visible = false;
}

function isNextStep() {
    for (var i = 0; i < rows; ++i) {
        for (var j = 0; j < columns - 1; ++j) {
            if (arrGrid[i][j] === arrGrid[i][j+1])
                return true;
        }
    }

    for (var i = 0; i < rows - 1; ++i) {
        for (var j = 0; j < columns; ++j) {
            if (arrGrid[i][j] === arrGrid[i+1][j])
                return true;
        }
    }

    return false;
}

function gameOver() {
    moving = true;
    baseObj.scoreBoard.bestScore = Math.max(baseObj.scoreBoard.score, baseObj.scoreBoard.bestScore);
    baseObj.gameOverWnd.visible = true;
    baseObj.gameOverWnd.animateOpacity.start();
    console.log("game over")
}

function rndBlock()
{
    var x, y;
    var emptyBlock = [];

    for (var i = 0; i < rows; ++i) {
        for (var j = 0; j < columns; ++j) {
            if(arrGrid[i][j] === 0) {
                emptyBlock.push([i,j]);
            }
        }
    }

    if (emptyBlock.length) {
        var cell = emptyBlock[Math.floor(Math.random() * emptyBlock.length)];
        var value = Math.floor(Math.random() < 0.9 ? 2 : 4);
        create(cell[0], cell[1], value, true);
    }

    if (emptyBlock.length <= 1) {
        if (!isNextStep())
            gameOver();
    }

}

//console.log("[" + row + ":" + col + "][" + row2 + ":" + col2 + "]");

function moveObj(row, col, row2, col2) {
    var cell1 = arrGrid[row][col];
    var cell2 = arrGrid[row2][col2];

    if ((cell1 !== 0 && cell2 !== 0) && cell1 !== cell2)
        return false;

    arrCells[row][col].animMove = true;

    if ( (cell1 !== 0 && cell1 === cell2) ||
         (cell1 !== 0 && cell2 === 0) )
    {
        arrGrid[row][col] = 0;
        arrCells[row][col].x = arrCells[row][col].width * col2;
        arrCells[row][col].y = arrCells[row][col].height * row2;
        moving = true;
        ++moveCount;
    }

    if (cell1 !== 0 && cell1 === cell2) {
        arrGrid[row2][col2] *= 2;
        baseObj.scoreBoard.score += arrGrid[row2][col2];
        return false;
    }

    if (cell1 !== 0 && cell2 === 0) {
        arrGrid[row2][col2] = cell1;
        return true;
    }
    return true;
}

function onAnimEnd()
{
    --moveCount;
    if (moveCount != 0)
        return;

    cleanCells();

    for (var i = 0; i < rows; ++i) {
        for (var j = 0; j < columns; ++j) {
            if (arrGrid[i][j] !== 0)
                create(i, j, arrGrid[i][j], false);
        }
    }
    moving = false;
    rndBlock();
}

function move(direction)
{
    if(moving)
        return;

    if (direction === Qt.Key_Left || direction=== Qt.Key_Up) {
        for (var i = 0; i < rows; ++i) {
            for (var j = 0; j < columns; ++j) {
                for (var f = j+1; f < rows; ++f ) {
                    if (direction === Qt.Key_Left) {
                        if (!moveObj(i, f, i, j))
                            break;
                    } else {
                        if(!moveObj(f, i, j, i))
                            break;
                    }
                }
            }
        }
    }

    if (direction === Qt.Key_Right || direction === Qt.Key_Down) {
        for (var i = 0; i < rows; ++i) {
            for (var j = columns - 1; j >= 0; --j) {
                for (var f = j-1; f >= 0; --f ) {
                    if (direction === Qt.Key_Right) {
                        if (!moveObj(i, f, i, j))
                            break;
                    } else {
                        if (!moveObj(f, i, j, i))
                            break;
                    }
                }
            }
        }
    }
}

function create(row, col, value, respaun)
{
    var component = Qt.createComponent("Cell.qml");
    var object = component.createObject(baseObj.board);

    object.value = value;
    object.animSize = respaun;
    object.x = object.width * col;
    object.y = object.height * row;
    object.size = Qt.size(baseObj.board.width / rows - 10, baseObj.board.height / columns - 10);

    arrGrid[row][col] = object.value;
    arrCells[row][col] = object;
}















