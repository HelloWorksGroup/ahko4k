# ahko4k

> tested with Autohotkey 2.0-beta.12 on Windows 11

ahko4k is a quick launcher for windows.

## Screenshots

![](./assets/screenshot1.jpg)


![](./assets/screenshot2.jpg)

## Setup

![](./assets/setup.png)

right click the `ahko` tray icon, and then click the `Setup`

![](./assets/setupui.png)

## Usage

ahko4k scans two levels of directories in the watch folder. The number of objects per directory level is limited to 4. This means that a maximum of 4x4 = 16objects can be listed.  

### icon

Icons can be obtained automatically. And you can set it by your own.  
Folder icons can be set by placing a png image with the name `_icon.png` in the folder.  
Item's icon can be set by placing a png image with the same name as the item. For example, put `abc.lnk` and `abc.png` in the same folder, the icon of `abc.lnk` would be set to `abc.png`.

## Template

Created with ahk autoupdate [template](https://github.com/Nigh/ahk-autoupdate-template/generate)

