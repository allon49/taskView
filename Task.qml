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

        onExited: {
            dropRectangle.color = defaultColor

            if (taskItem.defaultColor !== "blue") {
                taskData.get(taskColumnIndex).tasks.remove(index-1,1)
            }

            console.log("exited")
        }



        onEntered: {

            console.log("task hovered status: " + taskItem.taskHovered)


            dropRectangle.color = hoveredColor


            console.log("taskItem.color: " + taskItem.defaultColor)


            if (taskItem.defaultColor === "blue") {     //? This part make no sens!!! What I can achieve with a color (blue) I can not do it with a boolean (taskHovered)!
                console.log("task hovered, do not insert")
            } else {
                console.log("task not entered yet, insert")
                taskData.get(taskColumnIndex).tasks.insert(index, {"description": "red", "taskHovered": true, color:"blue"})
                taskData.get(taskColumnIndex).tasks.set(index, {"taskHovered": true})
            }



            if (!taskRepeater.taskRepeaterIsBeingRendered)

            {
//                dropRectangle.color = hoveredColor
//                dropRectangle.opacity = 0.1
//                console.log("entered")

//                console.log("task column index: " + taskColumnIndex)
//                console.log("task index: " + index)


                //taskData.get(taskColumnIndex).tasks.append({description = "tets"})

//                if (taskItem.taskHovered === false) {
//                    taskData.get(taskColumnIndex).tasks.insert(index, {"description": "mon test"})
//                    taskItem.taskHovered = true
//                }




                //fruitModel.insert(2, {"cost": 5.95, "name":"Pizza"})


//                if (Activity.tasks[taskColumnIndex][index] !== "inserted task") {
//                    Activity.tasks[taskColumnIndex].splice(index, 0, "inserted task")
//                    console.log(Activity.tasks[0][0])
//                    taskRepeater.taskRepeaterIsBeingRendered = true
//                    taskRepeater.model = Activity.tasks

//                }
            }
        }

        onDropped: {
            dropRectangle.color = "black"
            console.log("dropped")


            taskData.get(taskColumnIndex).tasks.insert(index, {"description": "red", "taskHovered": true, color:"blue"})

//            if (taskItem.taskHovered === false) {
//                taskData.get(taskColumnIndex).tasks.insert(index, {"description": "mon test"})
//                taskItem.taskHovered = true
//            }



//            Activity.tasks[taskColumnIndex].splice(index, 0, "inserted task")
//            taskRepeater.model = Activity.tasks

        }

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
