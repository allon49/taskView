import QtQuick 2.12




Column {
    id: taskContentColumn

//    property var computedTaskHeight: actionsRectangle.height + taskTitleTextEdit.height + taskDescriptionTextEdit.height + 15   //? why +15 no idea :( but otherwise the taskDescriptionTextEdit is not taken into account
    property var computedTaskHeight: actionsRectangle.height + dummyTextEdit.height + taskDescriptionTextEdit.height + 15   //? why +15 no idea :( but otherwise the taskDescriptionTextEdit is not taken into account


    property string taskDescription
    property string taskTitle

    width: parent.width
    spacing: 4

    anchors.top: parent.top
    anchors.left: parent.left

    Rectangle {
        id: actionsRectangle

        width: parent.width
        height: 20
        color: "#e75858"
        radius: 3

        MouseArea {
            id: editTitleMouseArea
            width: 30
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            anchors.right: parent.right

            Text {
                id: editTextSymbol
                text: qsTr("Edit")
                font.pixelSize: 12
            }    
        }

        MouseArea {
            id: removeTaskMouseArea
            width: 30
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 30
            anchors.right: editTitleMouseArea.left

            Text {
                id: removeTextSymbol
                text: qsTr("Remove")
                font.pixelSize: 12
            }

            onClicked: {
                var tmpData = visualModel.model
                tmpData[taskColumnIndex].tasks.splice(taskIndex,1)
                visualModel.model = tmpData
            }

        }

        MouseArea {
            id: optionsMouseArea
            width: 30
            height: 20
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 30
            anchors.right: removeTaskMouseArea.left


            Text {
                id: optionsTextSymbol
                text: qsTr("Options")
                font.pixelSize: 12
            }
        }
    }



    Item {
        width: parent.width
        height: 30

        Row {
            anchors.fill: parent
            Rectangle {
                id: textEditRectangle

                width: parent.width * 2/3
                height: parent.height
                color: "red"

                TextEdit {
                    id: dummyTextEdit

                    anchors.fill: parent
                    color: "green"
                    enabled: false
                    text: "test"

                    onEditingFinished: {
                        dummyTextEdit.enabled = false
                        textEditRectangle.color = "red"

                    }
                }
            }




            Rectangle {

                width: parent.width * 1/3
                height: parent.height
                color: "green"
                MouseArea {

                    anchors.fill: parent

                    onDoubleClicked: {
                        console.log("clicked blue")
                        dummyTextEdit.enabled = true
                        textEditRectangle.color = "yellow"
                    }
                }
            }

        }



    }

//    TextEdit {
//        id: taskTitleTextEdit

//        width: parent.width
//        wrapMode: TextEdit.Wrap
//        font.pointSize: 10
//        text: taskTitle
//        activeFocusOnPress: false



////        MouseArea {
////                anchors.fill: parent
////                //propagateComposedEvents: true
////                onClicked: {
////                    console.log("clicked blue")
////                    mouse.accepted = false
////                }

////                drag.target: taskColumn
////        }

//        onEditingFinished : {
//            console.log("taskTitleTextEdit.text: " + taskTitleTextEdit.text)

//            var tmpData = visualModel.model
//            console.log("tmpData[taskColumnIndex].tasks[taskIndex].title: " + tmpData[taskColumnIndex].tasks[taskIndex].title)
//            tmpData[taskColumnIndex].tasks[taskIndex].title = taskTitleTextEdit.text
//            visualModel.model = tmpData
//        }
//    }

    TextEdit {
        id: taskDescriptionTextEdit

        width: parent.width
        wrapMode: TextEdit.Wrap
        font.pointSize: 9
        text: taskDescription

        activeFocusOnPress: false

//        MouseArea {
//             anchors.fill: parent
//             onClicked: taskDescriptionTextEdit.forceActiveFocus(Qt.MouseFocusReason)
//             //propagateComposedEvents: true
//             visible: !taskDescriptionTextEdit.focus
//         }

        onEditingFinished : {
            var tmpData = visualModel.model
            console.log("tmpData[taskColumnIndex].tasks[taskIndex].description: " + tmpData[taskColumnIndex].tasks[taskIndex].description)
            tmpData[taskColumnIndex].tasks[taskIndex].description = taskDescriptionTextEdit.text
            visualModel.model = tmpData
        }
    }
}




