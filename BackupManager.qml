import QtQuick 2.15
import Quickshell.Io

QtObject {
    id: root

    signal backupCreated(string originalPath, string backupPath)
    signal backupFailed(string filePath, string error)

    property string backupDir: ""

    Component.onCompleted: {
        setupBackupDirectory()
    }

    function setupBackupDirectory() {
        // Hardcode path for now - we'll make this dynamic later
        backupDir = "/home/brad/.local/share/hyprland-config-editor/backups"

        // Create backup directory if it doesn't exist
        try {
            var process = Process.create({
                executable: "mkdir",
                arguments: ["-p", backupDir]
            })
            process.wait()
            console.log("Backup directory ready:", backupDir)
        } catch (e) {
            console.log("Failed to create backup directory:", e)
        }
    }

    function createBackup(filePath, description) {
        if (!filePath || !checkFileExists(filePath)) {
            backupFailed(filePath, "File does not exist")
            return false
        }

        var timestamp = new Date().toISOString().replace(/[:.]/g, "-")
        var fileName = filePath.split("/").pop()
        var backupFileName = `${fileName}.${timestamp}.${description || "backup"}`
        var backupPath = backupDir + "/" + backupFileName

        try {
            var process = Process.create({
                executable: "cp",
                arguments: [filePath, backupPath]
            })
            process.wait()

            if (process.exitCode === 0) {
                console.log(`✓ Backup created: ${backupPath}`)
                backupCreated(filePath, backupPath)
                return true
            } else {
                var error = process.readStderr()
                console.log(`✗ Backup failed: ${error}`)
                backupFailed(filePath, error)
                return false
            }
        } catch (e) {
            console.log("Backup error:", e)
            backupFailed(filePath, e.toString())
            return false
        }
    }

    function createFullBackup(configPaths, description) {
        console.log("Creating mock full backup...")
        var successCount = 0
        var totalCount = 0

        for (var i = 0; i < configPaths.length; i++) {
            var config = configPaths[i]
            if (config.exists) {
                totalCount++
                if (createBackup(config.path, description || "full-backup")) {
                    successCount++
                }
            }
        }

        console.log(`Mock full backup complete: ${successCount}/${totalCount} files backed up`)
        return successCount === totalCount
    }

    function checkFileExists(filePath) {
        try {
            var process = Process.create({
                executable: "test",
                arguments: ["-f", filePath]
            })
            process.wait()
            return process.exitCode === 0
        } catch (e) {
            return false
        }
    }

    function listBackups() {
        console.log("Mock: Would list backups from:", backupDir)
        return "Mock backup listing - implementation pending"
    }
}
