import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.1

import "tache.js" as Activity


ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1000
    height: 1000


    property int taskWidth: 200
    property int taskHeight: 200

    function app()
    {
        return   applicationWindow;
    }
    property alias repeater : taskRepeater
    Rectangle {
        id: root

        width: taskWidth * 3
        height: 1000

        Row {

            spacing: 10

            Repeater {
                id: taskRepeater



                model: Activity.tasks

                Rectangle {
                    id: taskColumnRectangle

                    width: taskWidth
                    height: 1000
                    border.width: 1
                    color: "yellow"

                    property int taskColumnRectangleIndex: index

                    Rectangle {
                        id: headerRectangle

                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: taskWidth
                        height: 50

                        Text {
                            id: headerText

                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            text: qsTr("Title")
                        }
                    }


                    ListView {
                        id: tasksListView

                        anchors.top: headerRectangle.bottom
                        anchors.left: parent.left

                        width: parent.width
                        height: Activity.tasks[taskColumnRectangleIndex].length * 50 < 500 ? Activity.tasks[taskColumnRectangleIndex].length * 50 : 500





                        property int dragItemIndex: -1

                        model: modelData

                        delegate: Item {
                            id: delegateItem

                            width: taskWidth
                            height: taskHeight

                            DropArea {
                                id: dropArea

                                property bool entered: false

                                anchors.fill: parent
                                onDropped: {
                                    print(index)
                                    console.log(drag.source)
                                    print("taskRepeater: " + taskColumnRectangleIndex)
                                    print("drag.source.dragRectIndex: " + drag.source.dragRectIndex)
                                    print("drag.source.dragRectTaskColumnIndex: " + drag.source.dragRectTaskColumnIndex)

                                    var tmp = Activity.tasks
                                    tmp[taskColumnRectangleIndex].splice(index,0,Activity.tasks[drag.source.dragRectTaskColumnIndex][drag.source.dragRectIndex])
                                    tmp[drag.source.dragRectTaskColumnIndex].splice(drag.source.dragRectIndex,1)
                                    Activity.tasks = tmp

                                    taskRepeater.model = Activity.tasks
                                }


                                onEntered: {
                                   dragRect.color = "red"
                                    if (drag.source.dragRectTaskColumnIndex !== taskColumnRectangleIndex) {
                                        if (index !== 0) {
                                            delegateItem.height = 100
                                        }
                                    }



                              //     if (drag.source.dragRectIndex !== index || drag.source.dragRectTaskColumnIndex !== taskColumnRectangleIndex) {
                               //         delegateItem.height = 100
                               //    }
                                }

                                onExited: {
                                    delegateItem.height = 50
                                    dragRect.color = "salmon"

                                }
                            }

                            //Rectangle {
                            TacheForm {
                                id: dragRect

                                property alias dragRect: dragRect

                                property int dragRectIndex
                                property int dragRectTaskColumnIndex

                                dragRectIndex: index
                                dragRectTaskColumnIndex: taskColumnRectangle.taskColumnRectangleIndex

                                //width: root.width / 3
                                //height: 50
                         //       color: "salmon"
                         //       border.color: Qt.darker(color)

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
                                            tasksListView.dragItemIndex = index
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

                    Rectangle {
                        id: footerRectangle



                        anchors.top: tasksListView.bottom
                        anchors.left: parent.left
                        width: parent.width
                        height: 50

                        Text {
                            id: footerText

                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            text: qsTr("+")

                            MouseArea {
                                id: addTaskButton

                                anchors.fill: parent
                                onClicked: {
                                    var tmp = Activity.tasks
                                    tmp[taskColumnRectangleIndex].push("test")
                                    Activity.tasks = tmp

                                    console.log("rr")


                                    taskRepeater.model = Activity.tasks

                                }
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
