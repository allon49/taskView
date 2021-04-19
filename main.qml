// Placeholder appears under task at beginning of dragging task
// No task Placeholder shifts vertical listview scrollbar because it is not part of the task listview
// When dragging left tasks are placed under right task (because of column z order)
// To move the task columns we need to have a move icon as I do not manage to sue propagate properly to be able to move when pressed and to focus on textedit when double click
// drop problem when size of the task is changed by adding text


import QtQuick 2.12
import QtQuick.Controls 2.12
import gcompris_tasks 1.0
import QtQuick.Dialogs 1.3
import "tache.js" as Activity


ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1000
    height: 1000
    
    property int taskWidth: 200
    property int taskHeight: 100

    function app()
    {
        return applicationWindow;
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        nameFilters: ["*.json"]
        selectMultiple: false
        onAccepted: {
            applicationWindow.readDocument(fileDialog.fileUrl)
        }

    }

    // Add here the QML items you need to access in javascript
    QtObject {
        id: items
    }

    Component.onCompleted: {
        Activity.start(items)
        Activity.init()
        applicationWindow.readDocument("qrc:/Data.json")
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
                onClicked: fileDialog.open()
            }
            Button {
                id: addNewColumnRectangle

                width: parent.width
                text: qsTr("Click here to add a new column")
                onClicked: taskBoard.addNewColumn()
            }
        }
    }


    function readDocument(url) {
        io.source = url

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





