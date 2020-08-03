import QtQuick 2.0

import "tache.js" as Activity

Item {

    width: parent.width
    height: 300

    property int taskColumnRectangleIndex: index

    //upfront insert task button
    Rectangle {
        id: insertTaskUpFrontRectangle

        anchors.top: parent.top
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


    // tasks
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

    //bottom insert task button
    Rectangle {
        id: insertTaskAtBottomRectangle

        anchors.left: parent.left
        anchors.bottom: parent.bottom

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
