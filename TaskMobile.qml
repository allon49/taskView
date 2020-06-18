import QtQuick 2.0

Item {
    id: taskMobileItem


    property string color : "red"
    property string text : "default Text"

    width: 64
    height: 64

    MouseArea {
        id: mouseArea

        width: 64; height: 64
        anchors.centerIn: parent


        drag.target: dragTaskRect

        onReleased: {
            dragTaskRect.Drag.drop()
            parent = dragTaskRect.Drag.target !== null ? dragTaskRect.Drag.target : taskMobileItem
            console.log("id of the item to drag: " + dragTaskRect.Drag.target)

        }


        Rectangle {
            id: dragTaskRect

            width: 64
            height: 64

            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            color: "pink" //taskMobileItem.color

            Drag.keys: [ "red" ]
            Drag.active: mouseArea.drag.active
            Drag.hotSpot.x: 32
            Drag.hotSpot.y: 32

            Text {
                anchors.centerIn: parent
                text: taskMobileItem.text
            }

            states: State {
                when: mouseArea.drag.active
                ParentChange { target: dragTaskRect; parent: taskMobileItem }
                AnchorChanges {
                    target: dragTaskRect
                    anchors.horizontalCenter: undefined
                    anchors.verticalCenter: undefined
                }
            }
         }
    }
}
