// to do
// - when dragged from a left column tasks elements are under droparea
// - create signals to fill datatasks
// - create optional button to add column. This can be also triggered by a signal
// - insert placeholder (when no task) within tasks listview in order to avoid shifting it down



import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.1
import QtQuick.Dialogs 1.3

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


    ListElement {
        id: taskElement

        property var color
        property var image
        property var description
        property var title

        title: "New column First task title"
        description: "First task description"
        image: "First task image"
        color: "red"
    }



    Rectangle {
        id: root

        width: parent.width
        height: parent.height

        ListModel {
            id: taskData

//            ListElement {

//                headerTitle: "Header Title 1"
//                tasks: [
//                    ListElement {
//                        title: "Column 1 First task title"
//                        description: "Column 1 First task description"
//                        image: "Column 1 First task image"
//                        color: "red"
//                    },
//                    ListElement {
//                        title: "Column 1 second task title"
//                        description: "Column 1 second task description"
//                        image: "Column 1 second task image"
//                        color: "red"
//                    }
//                ]
//            }


//            ListElement {

//                headerTitle: "Header Title 2"
//                tasks: [
//                    ListElement {
//                        title: "Column 2 First task title"
//                        description: "Column 2 First task description"
//                        image: "Column 2 First task image"
//                        color: "red"
//                    }
//                ]
//            }

//            ListElement {

//                headerTitle: "Header Title 3"
//                tasks: [

//                ]
//            }

        }


        DelegateModel {
            id: visualModel

            //model: taskData
            delegate: TasksColumn {}
        }

        ListView {
            id: tasksColumns

            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width
            height: parent.height
            spacing: 4
            cacheBuffer: 50
            model: visualModel
            orientation: ListView.Horizontal

            ScrollBar.horizontal: ScrollBar {
                id: tasksColumnsScrollbar
                policy: ScrollBar.AlwaysOn
                height: 30
            }
        }

        ColumnHeader {
            id: headerAddNewColumn

            anchors.top: parent.top
            anchors.right: root.right

            width: taskWidth
            height: 50

            text: qsTr("Click here to add a new column")
            color: "lightgreen"

            MouseArea {
                id: headerAddNewColumnMouseArea

                anchors.fill: parent
                onClicked: {
                    console.log("Insert a new column")

                    taskData.insert(0, {"headerTitle": "Header Title n", "tasks": []})
                }
            }
        }


        ColumnHeader {
            id: loadTaskData

            anchors.top: headerAddNewColumn.bottom
            anchors.right: root.right

            anchors.topMargin : 5

            width: taskWidth
            height: 50

            text: qsTr("Loading task data file")
            color: "lightgreen"

            MouseArea {
                id: loadTaskDataMouseArea

                anchors.fill: parent
                onClicked: {
                    console.log("Open task file")

                    root.readDocument()

                }
            }
        }

        function readDocument() {
            //io.source = "/home/charruau/Development/taskView/Data.qml"
            io.source = "Data.qml"

            console.log("io.source: " + io.source)

            io.read()
            console.log("io.text: " + io.text)
            visualModel.model = JSON.parse(io.text)
//var taskData2 = JSON.parse('{"result":true, "count":42}')

            console.log(JSON.stringify(visualModel.model, null, 4))


        }

        function saveDocument() {
            var data = taskData

            //console.log("data: " + data)
            //io.source = "/home/home/charruau/test.json"
          //  io.text = JSON.stringify(data, null, 4)
            console.log("--")
            console.log(JSON.stringify(data))

            var datamodel = []
            for (var i = 0; i < taskData.count; ++i)
            {
                datamodel.push(taskData.get(i))
                console.log(taskData.get(i))
                console.log("--")
                console.log(taskData.get(i).count)
            }


            console.log(JSON.stringify(datamodel))






            //io.write()
        }

//        FileDialog {
//            id: openDialog
//            onAccepted: {
//                root.saveDocument()
//            }
//        }

        FileIO {
            id: io
        }



    }
}





