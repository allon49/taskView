import QtQuick 2.4

Item {
    id: element
    width: 200
    height: 220
    property alias element: element
    property alias taskRectangle: taskRectangle
    property alias taskTextEdit: taskTextEdit

    Rectangle {
        id: taskRectangle
        width: parent.width
        height: parent.height + actionsRectangle.height
        color: "#d0da72"
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 0
        border.color: "#f2e6e6"
        border.width: 1


        Rectangle {
            id: actionsRectangle
            x: 300
            y: -40
            width: 90
            height: 20
            color: "#e75858"
            radius: 3
            border.width: 5
            anchors.right: parent.right
            anchors.bottom: parent.top

            MouseArea {
                id: editRectangle
                width: 30
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.topMargin: 0

                Text {
                    id: editTextSymbol
                    text: qsTr("Text")
                    font.pixelSize: 12
                }
            }

            MouseArea {
                id: removeRectangle
                width: 30
                anchors.top: parent.top
                anchors.leftMargin: 30
                anchors.bottom: parent.bottom
                anchors.left: parent.left

                Text {
                    id: removeTextSymbol
                    text: qsTr("Text")
                    font.pixelSize: 12
                }
            }

            MouseArea {
                id: optionsRectangle
                width: 30
                height: 20
                anchors.left: removeRectangle.right
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.topMargin: 0

                Text {
                    id: optionsTextSymbol
                    text: qsTr("Text")
                    font.pixelSize: 12
                }
            }
        }

        Rectangle {
            id: rectangle1
            x: 0
            y: 0
            width: 200
            height: 20
            color: "#d7d3b0"
            border.color: "#e75858"

            TextInput {
                id: taskTitleTextInput
                x: 10
                y: 0
                width: parent.width
                height: 20
                text: qsTr("Title")
                selectionColor: "#00000000"
                anchors.leftMargin: 10
                transformOrigin: Item.Center
                anchors.rightMargin: 10
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: parent.top
                cursorVisible: true
                font.pixelSize: 12
            }

            TextEdit {
                id: taskTextEdit
                x: 10
                y: 20
                width: parent.width
                text: qsTr("Enter your text")
                anchors.rightMargin: 2
                anchors.bottomMargin: -62
                anchors.leftMargin: -2
                anchors.topMargin: 62
                selectionColor: "#e75858"
                anchors.top: taskTitleTextInput.bottom
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.left: taskTitleTextInput.left
                font.pixelSize: 12
            }
        }
    }
}

/*##^##
Designer {
    D{i:3;anchors_height:100}D{i:5;anchors_height:100;anchors_x:0;anchors_y:0}D{i:7;anchors_height:100}
D{i:10;anchors_height:200;anchors_x:0;anchors_y:15}D{i:11;anchors_height:20;anchors_width:80;anchors_x:0;anchors_y:0}
D{i:1;anchors_x:0;anchors_y:20}
}
##^##*/
