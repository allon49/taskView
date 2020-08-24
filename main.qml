// When moving columns their position is not updated in visualModel. Columns take their original positions back when model is used.
// Placeholder appears under task at beginning of dragging task
// No task Placeholder shifts vertical listview scrollbar because it is not part of the task listview
// When dragging left tasks are placed under right task (because of column z order)

import QtQuick 2.12
import QtQuick.Controls 2.12
import gcompris_tasks 1.0

import "tache.js" as Activity


ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1000
    height: 1000
    
    property int taskWidth: 300
    property int taskHeight: 100

    function app()
    {
        return   applicationWindow;
    }


    // Add here the QML items you need to access in javascript
    QtObject {
        id: items
    }

    Component.onCompleted: {
        Activity.start(items)
        Activity.init()
    }


    TaskBoard {
        id: taskBoard

        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width - actionBar.width
    }

    Rectangle {
        id: actionBar

        anchors.top: parent.top
        anchors.right: parent.right
        width: 250
        height: parent.height
        color: "darkblue"

        Column {

            anchors.fill: parent
            spacing: 2

            Button {
                id: loadTaskDataFromFile

                width: parent.width
                text: qsTr("Loading task data file")
                onClicked: applicationWindow.readDocument()
            }
            Button {
                id: addNewColumnRectangle

                width: parent.width
                text: qsTr("Click here to add a new column")
                onClicked: taskBoard.addNewColumn()
            }
        }
    }


    function readDocument() {
        io.source = "Data.qml"

        console.log("io.source: " + io.source)

        io.read()
        console.log("io.text: " + io.text)
        taskBoard.taskBoardData = JSON.parse(io.text)

        console.log(JSON.stringify(taskBoard.taskBoardData, null, 4))

    }

//    function saveDocument() {
//        var data = taskData

//        //console.log("data: " + data)
//        //io.source = "/home/home/charruau/test.json"
//      //  io.text = JSON.stringify(data, null, 4)
//        console.log("--")
//        console.log(JSON.stringify(data))

//        var datamodel = []
//        for (var i = 0; i < taskData.count; ++i)
//        {
//            datamodel.push(taskData.get(i))
//            console.log(taskData.get(i))
//            console.log("--")
//            console.log(taskData.get(i).count)
//        }


//        console.log(JSON.stringify(datamodel))

//        //io.write()
//    }


    FileIO {
        id: io
    }

}





