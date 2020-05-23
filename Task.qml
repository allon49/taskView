import QtQuick 2.0

import "tache.js" as Activity

Item {
    id: taskItem

    property string defaultColor : "red"
    property string hoveredColor : "grey"
    property int taskColumnIndex

    width: taskWidth
    height: taskHeight

    DropArea {
        id: dragTarget

        property bool entered: false

        width: parent.width
        height: parent.height

        onExited: {
            dropRectangle.color = defaultColor
            if (Activity.tasks[taskColumnIndex][index] === "inserted task") {
                Activity.tasks[taskColumnIndex].splice(index, 1)
                taskRepeater.model = Activity.tasks
            }
            console.log("exited")
        }

        onEntered: {

            console.log("taskRepeater.taskRepeaterIsBeingRendered: " + taskRepeater.taskRepeaterIsBeingRendered)

            if (!taskRepeater.taskRepeaterIsBeingRendered)

            {
                dropRectangle.color = hoveredColor
                dropRectangle.opacity = 0.1
                console.log("entered")

                console.log("task column index: " + taskColumnIndex)
                console.log("task index: " + index)

                if (Activity.tasks[taskColumnIndex][index] !== "inserted task") {
                    Activity.tasks[taskColumnIndex].splice(index, 0, "inserted task")
                    console.log(Activity.tasks[0][0])
                    taskRepeater.taskRepeaterIsBeingRendered = true
                    taskRepeater.model = Activity.tasks

                }
            }
        }

        onDropped: {
            dropRectangle.color = "black"
            console.log("dropped")

            Activity.tasks[taskColumnIndex].splice(index, 0, "inserted task")
            taskRepeater.model = Activity.tasks

        }

        Rectangle {
            id: dropRectangle

            width: parent.width
            height: parent.height

            anchors.fill: parent

            color: taskItem.defaultColor

            Text {
                anchors.fill: parent

                text: modelData
            }
        }
    }
}
