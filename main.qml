import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.1

import "tache.js" as Activity


ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1000
    height: 1000
    
    
    property int taskWidth: 250
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


//    ListElement {
//        id: defaultTaskColumnListElement

//        property string headerTitle
//        property list<taskElement> tasks

//        headerTitle: "Give a title to your column"
//        tasks: [
//            ListElement {

//                property var color
//                property var image
//                property var description
//                property var title

//                title: "New column First task title"
//                description: "First task description"
//                image: "First task image"
//                color: "red"
//            },
//            ListElement {

//                property var color
//                property var image
//                property var description
//                property var title

//                title: "New column second task title"
//                description: "second task description"
//                image: "second task image"
//                color: "red"
//            }
//        ]
//    }


    Rectangle {
        id: root

        width: taskWidth * 3
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


        //tasksRow and its repeater create n tasks columns, n being the number of elements (level 1) in Activity.tasks array
        Row {
            id: tasksColumnRows
            spacing: 10

            Repeater {
                id: taskRepeater

                model: taskData

                // taskColumnRectangle includes tasks header, a placeHolder if there is no task, n tasks and an insert header and footer button to add additional tasks
                Rectangle {
                    id: tasksColumnRectangle

                    width: taskWidth
                    height: root.height
                    border.width: 1
                    color: "yellow"

                    property int taskColumnRectangleIndex: index


                    Rectangle {
                        id: headerRectangle

                        anchors.top: parent.top
                        anchors.left: parent.left

                        width: taskWidth
                        height: 50

                        color: "lightgreen"

                        Text {
                            id: headerText

                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            text: qsTr("Title " + taskData.get(index).headerTitle)
                        }
                    }


                    //insert (upfront) task button
                    Rectangle {
                        id: insertTaskUpFrontRectangle

                        anchors.top: headerRectangle.bottom
                        anchors.left: parent.left

                        width: parent.width
                        height: 50
                        color: "lightsteelblue"

                        Text {
                            id: insertUpFrontText

                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            text: qsTr("+")

                            color: "red"
                        }

                        MouseArea {
                            id: upFrontAddTaskButton

                            anchors.fill: parent
                            onClicked: {
                                var tmp = Activity.tasks
                                tmp[taskColumnRectangleIndex].push("test")  //?
                                Activity.tasks = tmp

                                taskData.get(taskColumnRectangleIndex).tasks.insert(0, {"description": "task number: 0", /*"taskHovered": true*/ color:"red"})

                                console.log("rr")
                            }
                        }
                    }

                    Column {
                        id: taskColumnRectangle

                        anchors.top: insertTaskUpFrontRectangle.bottom
                        anchors.bottom: insertTaskAtBottomRectangle.top
                        anchors.left: parent.left
                        width: parent.width

                        //placeholder if no task in the listview
                        Rectangle {
                            id: noTaskPlaceHolder

                            visible: taskData.get(taskColumnRectangleIndex).tasks.count === 0 ? true : false
                            width: parent.width
                            height: taskHeight
                            color: !bottomPlaceHolderDropArea.containsDrag ? "grey" : "green"

                            Text {
                                anchors.fill: parent
                                text: "front placeholder"
                            }

                            DropArea {
                                id: bottomPlaceHolderDropArea

                                anchors.fill: parent

                                onDropped: {
                                    taskData.get(taskColumnRectangleIndex).tasks.insert(0, taskData.get(drag.source.taskColumnIndex).tasks.get(drag.source.taskIndex))
                                    taskData.get(drag.source.taskColumnIndex).tasks.remove(drag.source.taskIndex, 1)

                                    console.log("ddd")
                                    console.log(drag.source.taskColumnIndex)
                                    console.log(drag.source.taskIndex)

                                    console.log("fffffffffffffffffff" + bottomPlaceHolderDropArea)
                                }
                            }
                        }



                        //listView displaying all the tasks contained in each Activity.tasks array level
                        ListView {
                            id: tasksListView

                            spacing: 20

                            width: parent.width

                            height: parent.height

                            model: taskData.get(index).tasks

                            delegate: taskComponent

                            Component.onCompleted: { console.log("Index : " + index) }
                        }


                        //at the moment a simple DropArea linked to a rectangle but will be replaced by Tache.qml in the future to be able to contain task informations and goals
                        Component {
                            id: taskComponent

                            Task {

                                taskColumnIndex: taskColumnRectangleIndex
                                taskIndex: index
                                taskDescription: description
                                taskHovered: taskHovered
                                defaultColor: color
                            }
                        }
                    }

                    //footer with the + caption
                    Rectangle {
                        id: insertTaskAtBottomRectangle

                        anchors.left: parent.left
                        anchors.bottom: tasksColumnRectangle.bottom

                        width: parent.width
                        height: 50
                        color: "lightsteelblue"

                        Text {
                            id: insertBottomText

                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            text: qsTr("+")

                        }

                        MouseArea {
                            id: bottomAddTaskButton

                            anchors.fill: parent
                            onClicked: {
                                var tmp = Activity.tasks
                                tmp[taskColumnRectangleIndex].push("test")
                                Activity.tasks = tmp

                                taskData.get(taskColumnRectangleIndex).tasks.insert(taskData.get(taskColumnRectangleIndex).tasks.count, {"description": "task number: " + taskData.get(taskColumnRectangleIndex).tasks.count, /*"taskHovered": true*/ color:"red"})

                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id: headerAddNewColumn

            anchors.top: parent.top
            anchors.left: tasksColumnRows.right

            anchors.leftMargin: 10

            width: taskWidth
            height: 50

            color: "lightgreen"

            Text {
                id: headerText

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                text: qsTr("Click here to add a new column")
            }

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
