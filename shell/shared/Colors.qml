pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import QtCore

Singleton {
    property var colors: {}
    property bool isLoaded: false
    
    FileView {
        id: dataFile
        path: StandardPaths.writableLocation(StandardPaths.GenericCacheLocation) + "/iris/Colors.json"
        blockLoading: false
        printErrors: true
        watchChanges: true
        onFileChanged: reload()
        onLoaded: { 
            colors = JSON.parse(text().trim()) 
            isLoaded = true
        }
    }
}