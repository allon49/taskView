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


var tasksColumnComponent
var columnTasksComponent
var taskColumnElements
var taskDetails

function init() {

    console.log("init")

    tasksColumnComponent = Qt.createComponent("qrc:/myListElement.qml");
//    taskColumnElements = tasksColumnComponent.createObject(
//                   items.root,
//                   {
//                       "header": "testHeader",
//                       "tasks": [
//                        Quick.ListElement {
//                            alphaName: "A"
//                        },
//                        Quick.ListElement {
//                            alphaName: "B"
//                        }],
//                       "footer": "testFooter"
//                   });
//    items.tasksModel.append(taskColumnElements)

//    columnTasksComponent = Qt.createComponent("qrc:/myListElement.qml");
//    taskDetails = columnTasksComponent.createObject(
//                   items.root,                              //?not sure we attach it to root if we want it to be destroyed
//                   {
//                       "name": "task name"
//                   });
   // items.tasksModel.get(0).tasks.append(taskDetails)

//    items.tasksModel.get(0).tasks.append({alphaName: "C"})




}




