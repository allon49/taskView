import QtQuick 2.0

import "tache.js" as Activity


DropArea {
    id: taskItem

    property bool taskHovered: false
    property string defaultColor : "red"
    property string hoveredColor : "grey"
    property int taskColumnIndex
    property string taskDescription : ""

    width: taskWidth
    height: taskColumn.height

    Column {
        id: taskColumn

        height: implicitHeight
        width: taskWidth
        spacing: 10


        Rectangle {
            id: dropRectangle

            width: parent.width
            height: taskHeight
            color: taskItem.defaultColor

            Text {
                anchors.fill: parent
                text: taskDescription
            }
        }

        Rectangle {
            id: bottomPlaceHolder

            visible: taskItem.containsDrag// && (dragTarget.drag.y > dropRectangle.height / 2)
            width: parent.width
            height: taskHeight
            color: "grey"

            Text {
                anchors.fill: parent
                text: "bottom placeholder"
            }

        }
    }
}



