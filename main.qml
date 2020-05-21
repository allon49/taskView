import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.1

import "tache.js" as Activity


ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1000
    height: 1000
    
    Component.onCompleted: Activity.startUp();
    
    property string tempTaskValue : ""


    property int taskWidth: 250
    property int taskHeight: 100

    function app()
    {
        return   applicationWindow;
    }

    property alias taskRepeater : taskRepeater


    Rectangle {
        id: root

        width: taskWidth * 3
        height: 1000

        Row {
            id: tasksRow
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

                        spacing: 20

                        width: parent.width
                        //height: Activity.tasks[taskColumnRectangleIndex].length * 50 < 500 ? Activity.tasks[taskColumnRectangleIndex].length * 50 : 500

                        height: 800

                        property int dragItemIndex: -1

                        model: modelData

                        delegate: taskComponent
                    }



                    Component {
                        id: taskComponent

                        Task {
                            taskColumnIndex: taskColumnRectangleIndex
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

        TaskMobile {
            id: movingTask

            z: 10

            anchors.top: tasksRow.top
            anchors.left: tasksRow.right

            width: taskWidth
            height: taskHeight

            color: "blue"
            //text: "moving task"

        }
    }

    function handleDrop(drag)
    {
        repeater.itemAt(drag.source.dragRectTaskColumnIndex).model = []
    }
}
