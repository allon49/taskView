import QtQuick 2.0
import QtQml.Models 2.1
import QtQuick.Controls 2.12


//    ListElement {
//        id: taskElement

//        property var color
//        property var image
//        property var description
//        property var title

//        title: "New column First task title"
//        description: "First task description"
//        image: "First task image"
//        color: "red"
//    }


Rectangle {
    id: taskBoard

    property alias taskBoardData: visualModel.model

    width: parent.width
    height: parent.height

    ListModel {
        id: taskData
    }

    DelegateModel {
        id: visualModel

        delegate: TasksColumn {}
    }

    function addNewColumn() {
        console.log("Insert a new column")
        var data = visualModel.model
        data.splice(0,0,{"headertitle": "Header Title n", "tasks": []})
        visualModel.model = data
    }

    ListView {
        id: tasksColumns

        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        spacing: 4
        cacheBuffer: 50
        model: visualModel
        orientation: ListView.Horizontal

        ScrollBar.horizontal: ScrollBar {
            id: tasksColumnsScrollbar
            policy: ScrollBar.AlwaysOn
            height: 30
        }
    }
}
