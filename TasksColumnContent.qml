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
                tmpData[taskColumnRectangleIndex].tasks.splice(0,0,{"description": "task number: 0", "color":"red", "title": "Task title"})
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
                    var tmpData = visualModel.model
                    tmpData[taskColumnRectangleIndex].tasks.splice(index+1, 0,tmpData[drag.source.taskColumnIndex].tasks[drag.source.taskIndex])  //? should taskColumnRectangleIndex be replaced by taskColumnIndex
                    tmpData[drag.source.taskColumnIndex].tasks.splice(drag.source.taskIndex, 1)
                    visualModel.model = tmpData

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
                taskTitle: modelData.title
                taskDescription: modelData.description
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
                var tmpData = visualModel.model
                tmpData[taskColumnRectangleIndex].tasks.push({"description": "task number: 0", "color":"red", "title": "Task title"})
                visualModel.model = tmpData
            }
        }
    }


}
