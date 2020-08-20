import QtQuick 2.0
import QtQml.Models 2.1
import QtQuick.Controls 2.12

Component {

    Rectangle {
        id: tasksColumn


        width: 200

        height: root.height - tasksColumnsScrollbar.height
        color: "lightgreen"

        property var componentIndex: DelegateModel.itemsIndex

        MouseArea {
            id: columnHeaderMouseArea

            property bool held: false

            anchors { left: parent.left; right: parent.right }
            height: content.height   //?change content to header something

            drag.target: held ? content : undefined
            drag.axis: Drag.XAxis

            onPressed: {

                held = true
                console.log("press")
            }


            onReleased: held = false

            onClicked: console.log("clicked yellow")

            onDoubleClicked: {
                console.log("double click")

            }

            Rectangle {
                id: content

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                width: columnHeaderMouseArea.width;
                height: column.implicitHeight + 4

                border.width: 1
                border.color: "lightsteelblue"

                color: columnHeaderMouseArea.held ? "lightsteelblue" : "white"
                Behavior on color { ColorAnimation { duration: 100 } }

                radius: 2

//                Drag.active: columnHeaderMouseArea.held
//                Drag.source: columnHeaderMouseArea

                Drag.active: headerMoveMouseArea.held2
                Drag.source: headerMoveMouseArea


                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2

                states: State {
                    //when: columnHeaderMouseArea.held
                    when: headerMoveMouseArea.held2


                    ParentChange { target: content; parent: root }
                    AnchorChanges {
                        target: content
                        anchors { horizontalCenter: undefined; verticalCenter: undefined }
                    }
                }

                Column {   //?maybe column not necessary here
                    id: column
                    anchors.fill: parent

                    Rectangle {
                        id: columnHeaderRect

                        width: parent.width
                        height: headerTitleTextEdit.implicitHeight + 4


                        Rectangle {
                            id: headerMoveRectangle

                            anchors.top: parent.top
                            anchors.right: parent.right
                            anchors.margins: 2


                            width: columnHeaderRect.width / 10
                            height: width

                            color: "blue"

                            Image {
                                anchors.fill: parent
                                anchors.margins: 2

                                source: "images/move_icon.svg"
                            }

                            MouseArea {
                                id: headerMoveMouseArea

                                property var indextest: componentIndex

                                property bool held2: false

                                anchors.fill: parent

                                drag.target: held2 ? content : undefined
                                drag.axis: Drag.XAxis


                                onPressed: {

                                    held2 = true
                                    console.log("component index: " + componentIndex)

                                }


                                 onReleased: held2 = false

                            }
                        }


                        Rectangle {
                            id: headerOptionRectangle

                            anchors.top: parent.top
                            anchors.right: headerMoveRectangle.left
                            anchors.margins: 2


                            width: columnHeaderRect.width / 10
                            height: width

                            color: "blue"

                            Image {
                                anchors.fill: parent
                                anchors.margins: 2

                                source: "images/ellipsis.svg"
                            }

                            MouseArea {

                                anchors.fill: parent


                                Menu {
                                    id: contextMenu
                                    MenuItem {
                                       text: "Move column left"
                                       onClicked: {
                                            console.log("Move column left")
                                            if (index > 0)
                                            {
                                                var tmpData = visualModel.model
                                                tmpData.splice(index-1, 0, tmpData.splice(index, 1)[0]);
                                                visualModel.model = tmpData
                                            }
                                       }
                                    }
                                    MenuItem {
                                        id: moveColumnRightMenuItem
                                        text: "Move column right"
//                                        visible: index === visualModel.model.count - 1 ? false : true  //? does not work find workaround
//                                        height: index === visualModel.model.count - 1 ? 0 : moveColumnRightMenuItem.height
                                        onClicked: {
                                            if (index < visualModel.model.length)
                                            {
                                                var tmpData = visualModel.model
                                                tmpData.splice(index+1, 0, tmpData.splice(index, 1)[0]);
                                                visualModel.model = tmpData
                                            }
                                        }
                                    }
                                    MenuItem {
                                        text: "Copy column"
                                        onClicked: {
                                            var tmpData = visualModel.model
                                            console.log("aa: " + tmpData)
                                            tmpData.splice(index+1,0,tmpData[index])
                                            console.log("bb: " + tmpData)
                                            visualModel.model = tmpData
                                        }
                                    }

                                    MenuSeparator { }

                                    MenuItem {
                                        text: qsTr("Delete column")
                                        onClicked: {
                                            var tmpData = visualModel.model
                                            tmpData.splice(index,1)
                                            visualModel.model = tmpData
                                        }
                                    }
                                }


                                onPressed: {
                                    parent.color = "green"
                                    contextMenu.popup()
                                }

                                onReleased: {
                                    parent.color = "blue"
                                }
                            }
                        }

                        TextEdit {
                            id: headerTitleTextEdit

                         //   readOnly: true
                           // activeFocusOnPress: false


                            anchors.left: columnHeaderRect.left
                            anchors.top: columnHeaderRect.top
                            width: columnHeaderRect.width - headerOptionRectangle.width
                            wrapMode: TextEdit.Wrap
                            font.pointSize: 12
                            text: modelData.headertitle
                        }
                    }
                }
            }

            DropArea {
                id: dropArea

                anchors { fill:parent; margins: 10 }

                onEntered: {
                    console.log("drag.source.parent.DelegateModel.itemsIndex " + drag.source.indextest)
                    console.log("columnHeaderMouseArea.parent.DelegateModel.itemsIndex " + columnHeaderMouseArea.parent.DelegateModel.itemsIndex)

                    visualModel.items.move(    //? why do the move does not move parent model?
                            drag.source.indextest,
                            columnHeaderMouseArea.parent.DelegateModel.itemsIndex)
                }
            }
        }


        TasksColumnContent {
            id: tasksColumnContent

            anchors.top: columnHeaderMouseArea.bottom
            anchors.left: columnHeaderMouseArea.left

            width: tasksColumn.width
            height: parent.height - columnHeaderMouseArea.height

            states: State {
                when: columnHeaderMouseArea.held

                ParentChange { target: tasksColumnContent; parent: root; x: content.x }
                AnchorChanges {
                    target: tasksColumnContent
                    anchors { horizontalCenter: undefined; verticalCenter: undefined }
                }

            }
        }
    }
}
