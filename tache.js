.pragma library
.import QtQuick 2.6 as Quick
.import GCompris 1.0 as GCompris


var items

var tasks = [["tache bleue 1","tache bleue 2","tache bleue 3","tache bleue 4","tache bleue 5","tache bleue 6","tache bleue 7","tache bleue 8","tache bleue 9","tache bleue 10"],
         ["tache rouge 1","tache rouge 2","tache rouge 3"],
         ["tache verte 1","tache verte 2","tache verte 3","tache verte 4","tache verte 5","tache verte 6","tache verte 7","tache verte 8","tache verte 9","tache verte 10","tache verte 11"]]




function start(items_) {
    items = items_
}


var component
var currentTaskColumn

function init() {

    console.log("init")

    component = Qt.createComponent("qrc:/gcompris/src/activities/taskView/tasksInfo.qml");

    if (component.status === Quick.Component.Ready) {
        console.log("do")
        finishCreation();
    }
    else {
        console.log("wait")
        component.statusChanged.connect(finishCreation);
    }
}



function finishCreation() {
    if (component.status === Quick.Component.Ready) {
        currentTaskColumn = component.createObject(
                       items.root,
                       {
                           "header": "testHeader",
                           "tasks": "testTask",
                           "footer": "testFooter"
                       });
        if (currentTaskColumn === null) {
            // Error Handling
            console.log("Error creating object");
        }

        console.log("eee")


    } else if (component.status === Quick.Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }

    items.tasksModel.append(currentTaskColumn)

    items.taskRepeater.model = tasksModel

    console.log("rr")


}



//    for (var i = 0; i < tasks.length; i++) {
//        items.tasksModel.append(currentTaskColumn)

//        for (var j = 0; j < tasks[i].length; j++) {
//            console.log("---" + tasks[i][j])
//        }
//    }





