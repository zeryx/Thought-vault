import QtQuick 2.3
import QtQuick.Controls 1.3
import QtGraphicalEffects 1.0
import "assets" as Assets

Rectangle{
    id:root
    property alias listView: thoughtList
    z:-1
    Assets.Search{
        id: search
        width: root.width
        height: 25
        textPromptInfo: "Search"
        z:12
    }
    ListView
    {
        boundsBehavior: ListView.StopAtBounds
        id: thoughtList
        model: thoughtModel
        width: root.width
        height: root.height-search.height-addThoughtLoader.height-10
        delegate: thoughtDelegate
        spacing: 2
        focus: true
        z:0
    }

    Loader{
        id: addThoughtLoader
        width: parent.width
        height: 50
        anchors.bottom: parent.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
        sourceComponent: addThoughtButtonComp
        visible: status == Loader.Ready
        Behavior on visible{
            NumberAnimation {
                property: "opacity";
                from:!visible; to: visible;
                duration: 200;
                easing.type: Easing.InOutQuad }}
    }

    Component{
        id: addThoughtButtonComp
        Assets.Clickable{
            id: addThoughtButton
            width: addThoughtLoader.width
            height: addThoughtLoader.height
            color: "green"
            Text{
                id: addThoughtText
                text: qsTr("new thought")
            }
            onClicked: {
                    addThoughtLoader.height=400

//                addThoughtLoader.visible = false
                addThoughtLoader.sourceComponent = addThoughtWidgetComp
//                addThoughtLoader.visible = true
            }

        }
    }

    Component{
        id: addThoughtWidgetComp
        Rectangle{
            id: newTitleBox
            width: addThoughtLoader.width
            height: 25
            Text{
                anchors.fill: newTitleBox
                id: newTitlePrompt
                width: parent.width
                height: parent.height
                text: qsTr("thought title")
                color: "grey"
                font.family: "abel"
            }
            TextInput{
                id: newTitleInput
                 anchors.fill: parent
                 activeFocusOnPress: false
                 z:1
                 Component.onCompleted: newTitleInput.text = ""
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(!newTitleInput.activeFocus){
                        newTitleInput.forceActiveFocus();
                    }else{
                        newTitleInput.focus=false;
                    }
                }
            }
        }
    }

    Component{
        id: thoughtDelegate
        Rectangle{
            id: delRectangle
            height: thoughtTitle+thoughtTags+5
            width: thoughtList.width
            border.width: 2
            border.color: myListView.currentIndex === index ? Qt.lighter("#0781D9") : "transparent"
            Rectangle{id: background; anchors.fill: parent; color: Qt.lighter(Qt.lighter("#5caa15")); z:0}
            BusyIndicator{
                z:1
                id: loadingIndicator
                anchors.centerIn: portrait
            }

            MouseArea{
                id: thoughDelegateMouseArea
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked:{
                    if(mouse.button === Qt.LeftButton)
                        myListView.currentIndex = index
                    else if(mouse.button === Qt.RightButton)
                    {
                        rightclickMenu.passItem(model)
                        rightclickMenu.popup()
                    }
                }
                onDoubleClicked: {
                    if(mouse.button === Qt.LeftButton){
                        rightclickMenu.passItem(model)
                        viewItem.trigger()
                    }
                }
            }

            Text{
                id: thoughtTitle
                text:{ qsTr(model.title)}
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
            }
            Text{
                id: thoughtTags
                text:{ qsTr(model.tags)}
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
            }

        }
    }
}


