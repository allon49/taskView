import QtQuick 2.0

Item {
    id: taskMobileItem

    anchors.bottomMargin: 50

    property string color : "red"
    property string text : "default Text"

    width: parent.width
    height: parent.height + 50


    Rectangle {
        id: dragTaskRect

        property int dragTaskRectIndex

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
}
