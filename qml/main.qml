import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQml.Models 2.1
import QtQml 2.2
import QtGraphicalEffects 1.0
ApplicationWindow {
    id: rootApplicationWindow
    visible: true
    minimumWidth: 400
    minimumHeight: 480
    color:themePrimary
    property color themeSecondary: Qt.darker("grey")
    property color themePrimary: "white"
    title: qsTr("ThoughtVault")
    Rectangle{
        id: banner
        height:65
        anchors.top: parent.top
        width: parent.width
        color: themeSecondary
        z: 10
        Text{
            id: bannerTextLayout
            anchors.horizontalCenter: banner.horizontalCenter
            anchors.verticalCenter: banner.verticalCenter
            width: shyftText.width+wrkText.width
            height:shyftText.height+wrkText.height
            Text{
                id: shyftText
                anchors.verticalCenter: bannerTextLayout.verticalCenter
                color:"#ffffff"
                text: "Thought"
                font.pointSize:40
                font.family:"Abel"

            }

            Text{
                id: wrkText
                anchors.verticalCenter: bannerTextLayout.verticalCenter
                anchors.left: shyftText.right
                color: "#5caa15"
                text:" Vault"
                font.pointSize:40
                font.family:"Abel"
            }
        }
    }
    SearchColumn{
        id: searchColumn
        anchors.top: banner.bottom
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: 400
    }

    Item{
        id: thoughtLoader
        objectName: "thoughtLoader"
        height: rootApplicationWindow.height
        width: 0
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: searchColumn.right
    }
}
