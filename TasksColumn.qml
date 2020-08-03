import QtQuick 2.0
import QtQml.Models 2.1

Component {
    id: dragDelegate2

    Rectangle {
        id: tasksColumn


        width: 200

        height: dragArea.height

        color: "green"

        MouseArea {
            id: dragArea

            property bool held: false

            anchors { left: parent.left; right: parent.right }
            height: content.height

            drag.target: held ? content : undefined
            drag.axis: Drag.XAxis

            onPressed: held = true
            onReleased: held = false

            Rectangle {
                id: content

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                width: dragArea.width;
                height: column.implicitHeight + 4

                border.width: 1
                border.color: "lightsteelblue"

                color: dragArea.held ? "lightsteelblue" : "white"
                Behavior on color { ColorAnimation { duration: 100 } }

                radius: 2

                Drag.active: dragArea.held
                Drag.source: dragArea
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2

                states: State {
                    when: dragArea.held

                    ParentChange { target: content; parent: root }
                    AnchorChanges {
                        target: content
                        anchors { horizontalCenter: undefined; verticalCenter: undefined }
                    }
                }

                Column {
                    id: column
                    anchors { fill: parent; margins: 2 }

                    Rectangle {
                        id: columnHeaderRect

                        width: parent.width
                        height: dateText.implicitHeight + 4

                        Text {
                            id: dateText
                            text: "test" //"date + " " + index
                        }
                    }
                }
            }

            DropArea {
                id: dropArea

                anchors { fill:parent; margins: 10 }

                onEntered: {
                    console.log("drag.source.parent.DelegateModel.itemsIndex " + drag.source.parent.DelegateModel.itemsIndex)
                    console.log("dragArea.parent.DelegateModel.itemsIndex " + dragArea.parent.DelegateModel.itemsIndex)

                    visualModel.items.move(
                            drag.source.parent.DelegateModel.itemsIndex,
                            dragArea.parent.DelegateModel.itemsIndex)
                }
            }

        }


        TasksColumnContent {
            anchors.top: dragArea.bottom
            anchors.left: dragArea.left

        }


//        Rectangle {
//            id: taskRectangle

//            anchors.top: dragArea.bottom
//            anchors.left: dragArea.left

//            width: dragArea.width
//            height: 60

//            Text { text: "My Tasks : " + index + " " + dragArea.held }

//            states: State {
//                when: dragArea.held

//                ParentChange { target: taskRectangle; parent: root; x: content.x }
//                AnchorChanges {
//                    target: taskRectangle
//                    anchors { horizontalCenter: undefined; verticalCenter: undefined }
//                }

//            }
//            color: "lightblue"
//        }
    }
}
