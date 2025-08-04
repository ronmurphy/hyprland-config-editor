# Hyprland Config Editor

A smart GUI editor for Hyprland configuration files, built with Quickshell and QML. Designed specifically for end-4's dotfiles structure but extensible to other configurations.

## 🎯 Project Goals

- **Safe editing**: Automatic backups before any changes
- **Smart UI generation**: Parse config files and generate appropriate UI controls
- **File organization support**: Handle both single-file and split-file configurations
- **Real-time preview**: See changes immediately
- **Community focused**: Easy to integrate into existing dotfiles

## 🏗️ Current Status (Day 1)

### ✅ Completed
- [x] Basic project structure
- [x] Config file detection system
- [x] Safety backup system
- [x] Main application window
- [x] End-4 dotfiles structure support

### 🚧 In Progress
- [ ] Config file parsing
- [ ] UI component generation
- [ ] File editing capabilities

### 📋 Planned Features
- [ ] Gaps/borders editor
- [ ] Color picker integration
- [ ] Keybind editor
- [ ] Environment variables editor
- [ ] Autostart apps manager

## 🚀 Quick Start

### Prerequisites
- Quickshell installed (`yay -S quickshell-git`)
- Hyprland with existing configuration

### Running the Editor
```bash
# Make run script executable
chmod +x run.sh

# Launch the application
./run.sh
```

### Manual Launch
```bash
quickshell -c main.qml
```

## 📁 Project Structure

```
hyprland-config-editor/
├── main.qml              # Main application window
├── ConfigDetector.qml    # File detection logic
├── BackupManager.qml     # Safety backup system
├── run.sh               # Quick launch script
└── README.md            # This file
```

## 🛡️ Safety Features

- **Automatic backups**: Every config file is backed up before editing
- **Backup directory**: `~/.local/share/hyprland-config-editor/backups/`
- **Read-only mode**: Test parsing without making changes
- **Git integration**: Planned for version control

## 🎨 Supported Config Structure

Primarily targets end-4's dotfiles organization:
```
~/.config/hypr/
├── hyprland.conf         # Main config file
├── hyprland/            # Default configs
│   ├── general.conf
│   ├── env.conf
│   ├── execs.conf
│   ├── colors.conf
│   ├── keybinds.conf
│   └── rules.conf
└── custom/              # User overrides
    ├── general.conf
    ├── env.conf
    ├── execs.conf
    ├── keybinds.conf
    └── rules.conf
```

## 🐛 Debug Info

The application logs debug information to console. Run with:
```bash
quickshell -c main.qml 2>&1 | tee debug.log
```

## 🤝 Contributing

This is an active development project. Each day focuses on implementing one major feature:

- **Day 1**: Foundation and file detection ✅
- **Day 2**: General config editor (gaps, borders)
- **Day 3**: Color picker system
- **Day 4**: Keybind editor
- **Day 5**: Environment and autostart editors

## 📝 Development Notes

- Built with QML/JavaScript - no compilation needed
- Uses Quickshell's process execution for file operations
- Focuses on safety and user experience
- Designed to be integrated into existing dotfiles repos