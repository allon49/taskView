import QtQuick 2.0


Rectangle {
    id: columnHeader

    property alias text: columnHeaderText.text

    Text {
        id: columnHeaderText

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
