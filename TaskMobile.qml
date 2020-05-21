import QtQuick 2.0

Item {
    id: taskMobileItem

    anchors.bottomMargin: 50



    //        width: 64; height: 64

//        MouseArea {
//            id: mouseArea

//            width: 64; height: 64
//            anchors.centerIn: parent

//            drag.target: tile

//            onReleased: parent = tile.Drag.target !== null ? tile.Drag.target : root

//            Rectangle {
//                id: tile

//                width: 64; height: 64
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.horizontalCenter: parent.horizontalCenter

//                color: "red"


//                //Drag.keys: [ colorKey ]
//                Drag.active: mouseArea.drag.active
//                Drag.hotSpot.x: 32
//                Drag.hotSpot.y: 32
//                states: State {
//                    when: mouseArea.drag.active
//                    ParentChange { target: tile; parent: root }
//                    AnchorChanges { target: tile; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
//                }

//            }
//        }



//    DropArea {
//        id: dragTarget

//        property string colorKey
//        property alias dropProxy: dragTarget

//        width: 64; height: 64
//        //keys: [ colorKey ]

//        Rectangle {
//            id: dropRectangle

//            anchors.fill: parent
//            //color: colorKey

//            states: [
//                State {
//                    when: dragTarget.containsDrag
//                    PropertyChanges {
//                        target: dropRectangle
//                        color: "grey"
//                    }
//                }
//            ]
//        }
//    }


//}


    property string color : "red"
    property string text : "default Text"

    width: parent.width
    height: parent.height + 50
    DropArea {
        id: dragTarget

        property bool entered: false


        width: parent.width
        height: parent.width + 50

        anchors.fill: parent


        Rectangle {
            id: dropRectangle

            width: parent.width
            height: parent.height

            color: "red"


            anchors.top: parent.top
            anchors.left: parent.left
            anchors.bottomMargin: 50

//            states: [
//                State {
//                    when: dragTarget.containsDrag
//                    PropertyChanges {
//                        target: dropRectangle
//                        color: "grey"
//                    }
//                }
//            ]
        }


        onExited: {
            dragTaskRect.color = "salmon"
            console.log("exited")
        }

        onEntered: {
            dragTaskRect.color = "green"
            console.log("ffffffffff")
//            if (drag.source.dragTaskRectTaskColumnIndex !== taskColumnRectangleIndex) {
//                if (index !== 0) {
//                    //delegateItem.height = taskHeight
//                }
//            }
        }



    //                                anchors.fill: parent
    //                                onDropped: {
    //                                    print(index)
    //                                    console.log(drag.source)
    //                                    print("taskRepeater: " + taskColumnRectangleIndex)
    //                                    print("drag.source.dragTaskRectIndex: " + drag.source.dragTaskRectIndex)
    //                                    print("drag.source.dragTaskRectTaskColumnIndex: " + drag.source.dragTaskRectTaskColumnIndex)

    //                                    var tmp = Activity.tasks
    //                                    tmp[taskColumnRectangleIndex].splice(index,0,Activity.tasks[drag.source.dragTaskRectTaskColumnIndex][drag.source.dragTaskRectIndex])
    //                                    tmp[drag.source.dragTaskRectTaskColumnIndex].splice(drag.source.dragTaskRectIndex,1)
    //                                    Activity.tasks = tmp

    //                                    taskRepeater.model = Activity.tasks
    //                                }




    //                                onExited: {
    //                                    //delegateItem.height = taskHeight
    //                                    dragTaskRect.taskRectangle.color = "blue"
    //                                }
    }


    Rectangle {
        id: dragTaskRect

   //     property alias dragTaskRect: dragTaskRect

        property int dragTaskRectIndex
//        property int dragTaskRectTaskColumnIndex

        //dragTaskRectIndex: index
//        dragTaskRectTaskColumnIndex: taskColumnRectangle.taskColumnRectangleIndex

        width: taskMobileItem.width
        height: taskMobileItem.height

        color: "pink" //taskMobileItem.color

        Text {
            anchors.centerIn: parent
            text: taskMobileItem.text
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent

            drag.target: dragTaskRect

            onReleased: {
                parent.Drag.drop()
            }

                //                if (dragTaskRect.Drag.target) {
//                    dragTaskRect.parent = tile.Drag.target
//                    dragTaskRect.anchors.centerIn = root.parent
//                }
//            }

//            drag.onActiveChanged: {
//                if (mouseArea.drag.active) {
//                    print("index:", index)
//                    print("yy")
//              //      tasksListView.dragItemIndex = index
//                }
//                else {
//                 dragTaskRect.Drag.drop()
//                }
//            }
        }

        states: [
        State {
            when: dragTaskRect.Drag.active
            ParentChange {
                target: dragTaskRect
                parent: root
            }

            AnchorChanges {
                target: dragTaskRect
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
            }
        }
        ]

        Drag.active: mouseArea.drag.active
        Drag.hotSpot.x: dragTaskRect.width / 2
        Drag.hotSpot.y: dragTaskRect.height / 2
    }




    //Rectangle {
    //                            Tache {
    //                                id: dragTaskRect

    //                                property alias dragTaskRect: dragTaskRect

    //                                property int dragTaskRectIndex
    //                                property int dragTaskRectTaskColumnIndex

    //                                dragTaskRectIndex: index
    //                                dragTaskRectTaskColumnIndex: taskColumnRectangle.taskColumnRectangleIndex

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

    //                                    drag.target: dragTaskRect


    //                                    onReleased: {
    //                                        if (dragTaskRect.Drag.target) {
    //                                            dragTaskRect.parent = tile.Drag.target
    //                                            dragTaskRect.anchors.centerIn = root.parent
    //                                        }
    //                                    }


    ////                                    onReleased: {
    ////                                        var originalTaskParent = dragTaskRect.parent
    ////                                        var originalTaskAnchors = dragTaskRect.parent
    ////                                        if (dragTaskRect.Drag.target) {
    ////                                            console.log("tile drag target:" + dragTaskRect.Drag.target)
    ////                                            root.parent = dragTaskRect.Drag.target
    ////                                            root.anchors.centerIn = root.parent
    ////                                        }
    ////                                        elsdropRectanglee {
    ////                                            console.log("no tile drag target")
    ////                                            dragTaskRect.parent = originalTaskParent
    ////                                            dragTaskRect.anchors.centerIn = originalTaskAnchors
    ////                                        }
    ////                                    }



    //                                    drag.onActiveChanged: {
    //                                        if (mouseArea.drag.active) {
    //                                            print("index:", index)
    //                                            tasksListView.dragItemIndex = index
    //                                        }
    //                                        else {
    //                                         dragTaskRect.Drag.drop()
    //                                        }
    //                                    }
    //                                }

    //                                states: [
    //                                State {
    //                                    when: dragTaskRect.Drag.active
    //                                    ParentChange {
    //                                        target: dragTaskRect
    //                                        parent: root
    //                                    }

    //                                    AnchorChanges {
    //                                        target: dragTaskRect
    //                                        anchors.horizontalCenter: undefined
    //                                        anchors.verticalCenter: undefined
    //                                    }
    //                                }
    //                                ]

    //                                Drag.active: mouseArea.drag.active
    //                                Drag.hotSpot.x: dragTaskRect.width / 2
    //                                Drag.hotSpot.y: dragTaskRect.height / 2
    //                            }

}
