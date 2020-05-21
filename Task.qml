import QtQuick 2.0

import "tache.js" as Activity

Item {
    id: taskItem


    property alias taskItem: taskItem

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
            console.log("exited")
        }

        onEntered: {
            dropRectangle.color = hoveredColor
            console.log("entered")

            console.log("task column index: " + taskColumnIndex)
            console.log("task index: " + index)

            //Activity.tasks[taskColumnIndex][index] = "test"
Activity.tasks[0][0] = "test"

            taskRepeater.model = Activity.tasks

            console.log("Activity.tasks: " + Activity.tasks)


//            if (drag.source.dragRectTaskColumnIndex !== taskColumnRectangleIndex) {
//                if (index !== 0) {
//                    //delegateItem.height = taskHeight
//                }
//            }
        }

        onDropped: {
            dropRectangle.color = "black"
            console.log("dropped")

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

//            states: [
//                State {
//                    when: dragTarget.containsDrag
//                    PropertyChanges {
//                        target: dropRectangle
//                        color: hoveredColor
//                    }
//                }
//            ]
        }



    //                                anchors.fill: parent
    //                                onDropped: {
    //                                    print(index)
    //                                    console.log(drag.source)
    //                                    print("taskRepeater: " + taskColumnRectangleIndex)
    //                                    print("drag.source.dragRectIndex: " + drag.source.dragRectIndex)
    //                                    print("drag.source.dragRectTaskColumnIndex: " + drag.source.dragRectTaskColumnIndex)

    //                                    var tmp = Activity.tasks
    //                                    tmp[taskColumnRectangleIndex].splice(index,0,Activity.tasks[drag.source.dragRectTaskColumnIndex][drag.source.dragRectIndex])
    //                                    tmp[drag.source.dragRectTaskColumnIndex].splice(drag.source.dragRectIndex,1)
    //                                    Activity.tasks = tmp

    //                                    taskRepeater.model = Activity.tasks
    //                                }


    //                                onEntered: {
    //                                   dragRect.taskRectangle.color = "red"
    //                                    if (drag.source.dragRectTaskColumnIndex !== taskColumnRectangleIndex) {
    //                                        if (index !== 0) {
    //                                            //delegateItem.height = taskHeight
    //                                        }
    //                                    }

    //                              //     if (drag.source.dragRectIndex !== index || drag.source.dragRectTaskColumnIndex !== taskColumnRectangleIndex) {
    //                               //         delegateItem.height = 100
    //                               //    }
    //                                }

    //                                onExited: {
    //                                    //delegateItem.height = taskHeight
    //                                    dragRect.taskRectangle.color = "blue"
    //                                }
    }


 /*   Rectangle {
        id: dragRect

        property alias dragRect: dragRect

        property int dragRectIndex
        property int dragRectTaskColumnIndex

        dragRectIndex: index
        dragRectTaskColumnIndex: taskColumnRectangle.taskColumnRectangleIndex

        width: root.width / 3
        height: 300
        color: "salmon"
    //       border.color: Qt.darker(color)

        Text {
            anchors.centerIn: parent
            text: modelData.toString()
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent

            drag.target: dragRect


            onReleased: {
                if (dragRect.Drag.target) {
                    dragRect.parent = tile.Drag.target
                    dragRect.anchors.centerIn = root.parent
                }
            }

            drag.onActiveChanged: {
                if (mouseArea.drag.active) {
                    print("index:", index)
                    tasksListView.dragItemIndex = index
                }
                else {
                 dragRect.Drag.drop()
                }
            }
        }

        states: [
        State {
            when: dragRect.Drag.active
            ParentChange {
                target: dragRect
                parent: root
            }

            AnchorChanges {
                target: dragRect
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
            }
        }
        ]

        Drag.active: mouseArea.drag.active
        Drag.hotSpot.x: dragRect.width / 2
        Drag.hotSpot.y: dragRect.height / 2
    }*/




    //Rectangle {
    //                            Tache {
    //                                id: dragRect

    //                                property alias dragRect: dragRect

    //                                property int dragRectIndex
    //                                property int dragRectTaskColumnIndex

    //                                dragRectIndex: index
    //                                dragRectTaskColumnIndex: taskColumnRectangle.taskColumnRectangleIndex

    //                                //width: root.width / 3
    //                                //height: 50
    //                         //       color: "salmon"
    //                         //       border.color: Qt.darker(color)

    //                                Text {
    //                                    anchors.centerIn: parent
    //                                    text: modelData
    //                                }

    //                                MouseArea {
    //                                    id: mouseArea
    //                                    anchors.fill: parent

    //                                    drag.target: dragRect


    //                                    onReleased: {
    //                                        if (dragRect.Drag.target) {
    //                                            dragRect.parent = tile.Drag.target
    //                                            dragRect.anchors.centerIn = root.parent
    //                                        }
    //                                    }


    ////                                    onReleased: {
    ////                                        var originalTaskParent = dragRect.parent
    ////                                        var originalTaskAnchors = dragRect.parent
    ////                                        if (dragRect.Drag.target) {
    ////                                            console.log("tile drag target:" + dragRect.Drag.target)
    ////                                            root.parent = dragRect.Drag.target
    ////                                            root.anchors.centerIn = root.parent
    ////                                        }
    ////                                        else {
    ////                                            console.log("no tile drag target")
    ////                                            dragRect.parent = originalTaskParent
    ////                                            dragRect.anchors.centerIn = originalTaskAnchors
    ////                                        }
    ////                                    }



    //                                    drag.onActiveChanged: {
    //                                        if (mouseArea.drag.active) {
    //                                            print("index:", index)
    //                                            tasksListView.dragItemIndex = index
    //                                        }
    //                                        else {
    //                                         dragRect.Drag.drop()
    //                                        }
    //                                    }
    //                                }

    //                                states: [
    //                                State {
    //                                    when: dragRect.Drag.active
    //                                    ParentChange {
    //                                        target: dragRect
    //                                        parent: root
    //                                    }

    //                                    AnchorChanges {
    //                                        target: dragRect
    //                                        anchors.horizontalCenter: undefined
    //                                        anchors.verticalCenter: undefined
    //                                    }
    //                                }
    //                                ]

    //                                Drag.active: mouseArea.drag.active
    //                                Drag.hotSpot.x: dragRect.width / 2
    //                                Drag.hotSpot.y: dragRect.height / 2
    //                            }
}
