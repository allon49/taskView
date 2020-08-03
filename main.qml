import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.1

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

            ListElement {

                headerTitle: "Header Title 1"
                tasks: [
                    ListElement {
                        title: "Column 1 First task title"
                        description: "Column 1 First task description"
                        image: "Column 1 First task image"
                        color: "red"
                    },
                    ListElement {
                        title: "Column 1 second task title"
                        description: "Column 1 second task description"
                        image: "Column 1 second task image"
                        color: "red"
                    }
                ]
            }


            ListElement {

                headerTitle: "Header Title 2"
                tasks: [
                    ListElement {
                        title: "Column 2 First task title"
                        description: "Column 2 First task description"
                        image: "Column 2 First task image"
                        color: "red"
                    }
                ]
            }

            ListElement {

                headerTitle: "Header Title 3"
                tasks: [

                ]
            }

        }


        DelegateModel {
            id: visualModel

            model: taskData
            delegate: TasksColumn {}
        }






        ListView {
            id: tasksColumns

            anchors.left: parent.left
            anchors.top: parent.top
            width: parent.width
            spacing: 4
            cacheBuffer: 50
            model: visualModel
            orientation: ListView.Horizontal


//                // taskColumnRectangle includes tasks header, a placeHolder if there is no task, n tasks and an insert header and footer button to add additional tasks
//                Rectangle {
//                    id: tasksColumnRectangle

//                    width: taskWidth
//                    height: root.height
//                    border.width: 1
//                    color: "yellow"

//                    property int taskColumnRectangleIndex: index


//                    Rectangle {
//                        id: headerRectangle

//                        anchors.top: parent.top
//                        anchors.left: parent.left

//                        width: taskWidth
//                        height: 50

//                        color: "lightgreen"

//                        Text {
//                            id: headerText

//                            anchors.horizontalCenter: parent.horizontalCenter
//                            anchors.verticalCenter: parent.verticalCenter

//                            text: qsTr("Title " + taskData.get(index).headerTitle)
//                        }
//                    }

//                    TasksColumnContent {
//                        id: taskColumnContent

//                        anchors.top: headerRectangle.bottom
//                        anchors.bottom: parent.bottom
//                        anchors.left: headerRectangle.left
//                    }
//                }
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
    }
}





