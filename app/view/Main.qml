import QtQuick

Window {
  id: window
  width: 640
  height: 480
  visible: true
  title: qsTr("Hello World")

  Rectangle {
    width: 100
    height: 100
    color: "red"
  }

  Rectangle {
    width: 100
    height: 100
    color: "green"
    x: 100
  }
}
