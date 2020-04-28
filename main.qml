import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.1

import "tache.js" as Activity

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480

    function app()

    {
        return   applicationWindow;
    }
    property alias repeater : taskRepeater
    Rectangle {
        id: root

        width: 400
        height: 400

        Row {
            Repeater {
                id: taskRepeater

                model: Activity.tasks

                Rectangle {
                    id: taskColumnRectangle

                    width: root.width / 3
                    height: 1000
                    border.width: 1
                    color: "yellow"

                    property int taskColumnRectangleIndex: index
                    property alias model : listView.model

                    ListView {
                        id: listView

                        width: parent.width
                        height: parent.height

                        property int dragItemIndex: -1

                        model: modelData

                        delegate: Item {
                            id: delegateItem

                            width: root.width / 3
                            height: 50

                            DropArea {
                                id: dropArea

                                anchors.fill: parent
                                onDropped:
                                {


                                    print(index)
                                    console.log(drag.source)
                                    print("taskRepeater: " + taskColumnRectangleIndex)
                                    print("drag.source.dragRectIndex: " + drag.source.dragRectIndex)
                                    print("drag.source.dragRectTaskColumnIndex: " + drag.source.dragRectTaskColumnIndex)


                                    var tmp = Activity.tasks
                                    tmp[taskColumnRectangleIndex].splice(index,0,Activity.tasks[drag.source.dragRectTaskColumnIndex][drag.source.dragRectIndex])
                                    Activity.tasks = tmp
                                    console.log(Activity.tasks)



                                //    handleDrop(drag)
                                }
                                onEntered: dragRect.color = "red"
                                onExited: dragRect.color = "yellow"
                            }

                            Rectangle {
                                id: dragRect

                                property int dragRectIndex
                                property int dragRectTaskColumnIndex

                                dragRectIndex: index
                                dragRectTaskColumnIndex: taskColumnRectangle.taskColumnRectangleIndex

                                width: root.width / 3
                                height: 50
                                color: "salmon"
                                border.color: Qt.darker(color)

                                Text {
                                    anchors.centerIn: parent
                                    text: modelData
                                }

                                MouseArea {
                                    id: mouseArea
                                    anchors.fill: parent
                                    drag.target: dragRect

                                    drag.onActiveChanged: {
                                        if (mouseArea.drag.active) {
                                            print("index:", index)
                                            listView.dragItemIndex = index
                                        }
                                        dragRect.Drag.drop()
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
                            }
                        }
                    }
                }
            }
        }
    }

    function handleDrop(drag)
    {
        repeater.itemAt(drag.source.dragRectTaskColumnIndex).model = []
    }
}
