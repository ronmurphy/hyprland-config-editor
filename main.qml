import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Window 2.15

ApplicationWindow {
    id: mainWindow
    width: 1000
    height: 700
    visible: true
    title: "Hyprland Config Editor"
    
    property var configFiles: []
    property string hyprConfigPath: ""
    
    Component.onCompleted: {
        console.log("Hyprland Config Editor starting...")
        configDetector.detectConfigs()
    }
    
    // Main layout
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        
        // Header
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            color: "#2a2a2a"
            radius: 8
            
            RowLayout {
                anchors.fill: parent
                anchors.margins: 15
                
                Text {
                    text: "Hyprland Config Editor"
                    color: "#ffffff"
                    font.pointSize: 16
                    font.bold: true
                }
                
                Item { Layout.fillWidth: true }
                
                Text {
                    id: statusText
                    text: "Detecting configs..."
                    color: "#cccccc"
                    font.pointSize: 10
                }
            }
        }
        
        // Config detection area
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "#1e1e1e"
            radius: 8
            
            ScrollView {
                anchors.fill: parent
                anchors.margins: 15
                
                Column {
                    width: parent.width
                    spacing: 10
                    
                    Text {
                        text: "Detected Configuration Files:"
                        color: "#ffffff"
                        font.pointSize: 14
                        font.bold: true
                    }
                    
                    Repeater {
                        id: configRepeater
                        model: mainWindow.configFiles
                        
                        Rectangle {
                            width: parent.width
                            height: 40
                            color: "#333333"
                            radius: 4
                            
                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                
                                Text {
                                    text: modelData.name
                                    color: "#ffffff"
                                    font.pointSize: 12
                                }
                                
                                Text {
                                    text: modelData.path
                                    color: "#888888"
                                    font.pointSize: 10
                                    Layout.fillWidth: true
                                }
                                
                                Text {
                                    text: modelData.exists ? "✓" : "✗"
                                    color: modelData.exists ? "#00ff00" : "#ff0000"
                                    font.pointSize: 14
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Config detection component
    ConfigDetector {
        id: configDetector
        onConfigsDetected: function(configs, basePath) {
            mainWindow.configFiles = configs
            mainWindow.hyprConfigPath = basePath
            statusText.text = `Found ${configs.length} config files in ${basePath}`
            console.log("Configs detected:", JSON.stringify(configs, null, 2))
        }
    }
}