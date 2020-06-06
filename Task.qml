import QtQuick 2.0

import "tache.js" as Activity

Item {
    id: taskItem

    property bool taskHovered: false
    property string defaultColor : "red"
    property string hoveredColor : "grey"
    property int taskColumnIndex
    property string taskDescription : ""


    width: taskWidth
    height: taskHeight

    DropArea {
        id: dragTarget

        property bool entered: false

        width: parent.width
        height: parent.height


        onEntered: {
            console.log("entered column index: " + taskColumnIndex)
            console.log("task form inserted flag: " + taskRepeater.itemAt(taskColumnIndex).tempTaskAreaInserted)

            if (taskRepeater.itemAt(taskColumnIndex).tempTaskAreaInserted === true) {
                console.log("temporary task already insterted -> move")
                taskData.get(taskColumnIndex).tasks.move(taskRepeater.itemAt(taskColumnIndex).previousIndex,index,1)

            } else {
                console.log("task enters for the first time -> insert")
                dropRectangle.color = hoveredColor
                taskData.get(taskColumnIndex).tasks.insert(index, {"description": "red", color:"blue"})
                taskRepeater.itemAt(taskColumnIndex).tempTaskAreaInserted = true
                taskRepeater.itemAt(taskColumnIndex).previousIndex = index
                //taskData.get(taskColumnIndex).tasks.set(index, {"taskHovered": true})
            }
        }

//        onDropped: {
//            console.log("dropped")
//            dropRectangle.color = "black"

//            taskData.get(taskColumnIndex).tasks.insert(index, {"description": "red", "taskHovered": true, color:"blue"})
//        }


        Rectangle {
            id: dropRectangle

            width: parent.width
            height: parent.height

            anchors.fill: parent

            color: taskItem.defaultColor

            Text {
                anchors.fill: parent

                text: taskItem.taskDescription
            }
        }
    }
}
