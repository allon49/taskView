import QtQuick 2.0

import "tache.js" as Activity


DropArea {
    id: taskItem

    property bool taskHovered: false
    property string defaultColor : "red"
    property string hoveredColor : "grey"
    property int taskColumnIndex
    property int taskIndex

    property string taskDescription : ""

    width: taskWidth
    height: taskColumn.height


    MouseArea {



        anchors.fill: parent

        id: mouseArea

        drag.target: taskColumn

        onPressed: {
//            dragTaskRect.Drag.drop()
//            parent = dragTaskRect.Drag.target !== null ? dragTaskRect.Drag.target : taskMobileItem
            //console.log("id of the item to drag: " + dragTaskRect.Drag.target)


        }



        onReleased: {

            taskColumn.Drag.drop()
//            parent = dragTaskRect.Drag.target !== null ? dragTaskRect.Drag.target : taskMobileItem
            //console.log("id of the item to drag: " + dragTaskRect.Drag.target)

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

                visible: taskItem.containsDrag// && (dragTarget.drag.y > dropRectangle.height / 2)
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

                        taskData.get(taskColumnIndex).tasks.insert(index+1, {"description": "red", /*"taskHovered": true*/ color:"red"})
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



