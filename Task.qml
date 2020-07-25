import QtQuick 2.0

import "tache.js" as Activity


Item {
    id: taskItem

    property bool taskHovered: false
    property string defaultColor : "red"
    property string hoveredColor : "grey"
    property int taskColumnIndex
    property int taskIndex

    property string taskDescription : ""

    width: taskWidth
    height: taskColumn.height

    DropArea {
        id: taskItemDropArea
        anchors.fill: parent

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            drag.target: taskColumn

            onReleased: {

                parent = taskColumn.Drag.target !== null ? taskColumn.Drag.target : taskItem
                console.log("id of the item to drag: " + taskColumn.Drag.target)
                taskColumn.Drag.drop()
                taskColumn.x = 0
                taskColumn.y = 0



            }

            Column {
                id: taskColumn

                property int taskColumnIndex
                property int taskIndex

                taskColumnIndex: taskItem.taskColumnIndex
                taskIndex: taskItem.taskIndex

                height: implicitHeight
                width: taskWidth
                spacing: 10

                Drag.active: mouseArea.drag.active
                Drag.hotSpot.x: 32
                Drag.hotSpot.y: 32

                Rectangle {
                    id: dropRectangle

                    width: parent.width
                    height: taskHeight
                    color: taskItem.defaultColor

                    Text {
                        anchors.fill: parent
                        text: taskDescription
                    }

                    states: State {
                        when: mouseArea.drag.active
                        ParentChange { target: taskColumn; parent: taskItem }
                        AnchorChanges {
                            target: taskColumn
                            anchors.horizontalCenter: undefined
                            anchors.verticalCenter: undefined
                        }
                    }
                }

                Rectangle {
                    id: bottomPlaceHolder

                    visible: taskItemDropArea.containsDrag
                    width: parent.width
                    height: taskHeight
                    color: !bottomPlaceHolderDropArea.containsDrag ? "grey" : "green"

                    Text {
                        anchors.fill: parent
                        text: "bottom placeholder"
                    }

                    DropArea {
                        id: bottomPlaceHolderDropArea

                        anchors.fill: parent

                        onDropped: {
                            taskData.get(taskColumnIndex).tasks.insert(index+1, taskData.get(drag.source.taskColumnIndex).tasks.get(drag.source.taskIndex))
                            taskData.get(drag.source.taskColumnIndex).tasks.remove(drag.source.taskIndex, 1)

                            console.log("ddd")
                            console.log(drag.source.taskColumnIndex)
                            console.log(drag.source.taskIndex)

                            console.log("fffffffffffffffffff" + bottomPlaceHolderDropArea)
                        }
                    }
                }
            }
        }
    }
}


