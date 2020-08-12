import QtQuick 2.0
import QtQml.Models 2.1

Component {

    Rectangle {
        id: tasksColumn


        width: 200

        height: root.height - tasksColumnsScrollbar.height
        color: "lightgreen"

        MouseArea {
            id: columnHeaderMouseArea

            property bool held: false

            anchors { left: parent.left; right: parent.right }
            height: content.height   //?change content to header something

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
                width: columnHeaderMouseArea.width;
                height: column.implicitHeight + 4

                border.width: 1
                border.color: "lightsteelblue"

                color: columnHeaderMouseArea.held ? "lightsteelblue" : "white"
                Behavior on color { ColorAnimation { duration: 100 } }

                radius: 2

                Drag.active: columnHeaderMouseArea.held
                Drag.source: columnHeaderMouseArea
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2

                states: State {
                    when: columnHeaderMouseArea.held

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
                            text: modelData.headertitle
                        }
                    }
                }
            }

            DropArea {
                id: dropArea

                anchors { fill:parent; margins: 10 }

                onEntered: {
                    console.log("drag.source.parent.DelegateModel.itemsIndex " + drag.source.parent.DelegateModel.itemsIndex)
                    console.log("columnHeaderMouseArea.parent.DelegateModel.itemsIndex " + columnHeaderMouseArea.parent.DelegateModel.itemsIndex)

                    visualModel.items.move(
                            drag.source.parent.DelegateModel.itemsIndex,
                            columnHeaderMouseArea.parent.DelegateModel.itemsIndex)
                }
            }

        }


        TasksColumnContent {
            id: tasksColumnContent

            anchors.top: columnHeaderMouseArea.bottom
            anchors.left: columnHeaderMouseArea.left

            width: tasksColumn.width
            height: parent.height - columnHeaderMouseArea.height

            states: State {
                when: columnHeaderMouseArea.held

                ParentChange { target: tasksColumnContent; parent: root; x: content.x }
                AnchorChanges {
                    target: tasksColumnContent
                    anchors { horizontalCenter: undefined; verticalCenter: undefined }
                }

            }


        }
    }
}
