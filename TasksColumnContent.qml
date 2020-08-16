import QtQuick 2.0
import QtQuick.Controls 2.12

import "tache.js" as Activity

Item {

    width: parent.width
    height: parent.height

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
                var tmpData = visualModel.model
                tmpData[taskColumnRectangleIndex].tasks.push({"description": "task number: 0", "color":"red"})
                visualModel.model = tmpData
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

            visible: modelData.tasks.length === 0 ? true : false
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
            model: modelData.tasks
            delegate: taskComponent
            Component.onCompleted: { console.log("Index : " + index) }  //?
            ScrollBar.vertical: ScrollBar {
                id: tasksColumnContentScrollbar
                policy: ScrollBar.AlwaysOn
                width: 15
            }
        }


        Component {
            id: taskComponent

            Task {

                width: parent.width - tasksColumnContentScrollbar.width

                taskColumnIndex: taskColumnRectangleIndex
                taskIndex: index
                taskDescription: modelData.description
                taskHovered: taskHovered
                defaultColor: modelData.color
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
                taskData.get(taskColumnRectangleIndex).tasks.insert(taskData.get(taskColumnRectangleIndex).tasks.count, {"description": "task number: " + taskData.get(taskColumnRectangleIndex).tasks.count, /*"taskHovered": true*/ color:"red"})
            }
        }
    }


}
