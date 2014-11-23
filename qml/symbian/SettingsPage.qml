/*
 *  TAO Translator
 *  Copyright (C) 2013-2014  Oleksii Serdiuk <contacts[at]oleksii[dot]name>
 *
 *  $Id: $Format:%h %ai %an$ $
 *
 *  This file is part of TAO Translator.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License along
 *  with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 1.1
import com.nokia.symbian 1.1

Page {
    id: root

    property bool platformInverted: false

    Header {
        id: header
        text: qsTr("%1 Settings").arg("TAO Translator")
    }

    Flickable {
        id: scrollArea

        contentHeight: column.height + 2 * platformStyle.paddingMedium
        anchors {
            top: header.bottom
            left: parent.left
            bottom: parent.bottom
            right: parent.right
        }

        Column {
            id: column

            spacing: platformStyle.paddingMedium
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: platformStyle.paddingMedium
                leftMargin: platformStyle.paddingMedium
                rightMargin: platformStyle.paddingMedium
            }

            Item {
                height: childrenRect.height
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Column {
                    id: invertedThemeLabels

                    anchors {
                        left: parent.left
                        right: parent.right
                    }

                    ListItemText {
                        text: qsTr("Dark Theme")
                        role: "Title"
                        platformInverted: root.platformInverted
                    }
                    ListItemText {
                        text: qsTr("Use dark color scheme")
                        role: "SubTitle"
                        platformInverted: root.platformInverted
                    }
                }
                Switch {
                    checked: !appWindow.platformInverted
                    platformInverted: root.platformInverted
                    anchors {
                        right: parent.right
                        verticalCenter: invertedThemeLabels.verticalCenter
                    }

                    onClicked: {
                        appWindow.platformInverted = !checked;
                        translator.setSettingsValue("InvertedTheme", appWindow.platformInverted);
                    }
                }
            }
        }
    }

    ScrollDecorator {
        flickableItem: scrollArea
        platformInverted: root.platformInverted
    }

    Menu {
        id: menu
        platformInverted: root.platformInverted

        MenuLayout {
            MenuItem {
                text: qsTr("Send Feedback")
                platformInverted: root.platformInverted
                onClicked: {
                    Qt.openUrlExternally("mailto:contacts" + "@"
                                         + "oleksii.name?subject=TAO%20Translator%20Feedback"
                                         + "%20(Symbian)");
                }
            }
            MenuItem {
                text: qsTr("Check for Updates")
                platformInverted: root.platformInverted
                onClicked: {
                    pageStack.push(updateCheckerPageComponent);
                }
            }
            MenuItem {
                text: qsTr("About")
                platformInverted: root.platformInverted
                onClicked: pageStack.push(aboutPageComponent);
            }
        }
    }

    Component {
        id: aboutPageComponent
        AboutPage {
            platformInverted: root.platformInverted
        }
    }

    Component {
        id: updateCheckerPageComponent
        UpdateCheckerPage {
            platformInverted: root.platformInverted
        }
    }

    tools: ToolBarLayout {
        ToolButton {
            iconSource: "toolbar-back"
            platformInverted: root.platformInverted
            onClicked: pageStack.pop();
        }
        ToolButton {
            iconSource: "toolbar-menu"
            platformInverted: root.platformInverted
            onClicked: menu.open();
        }
    }
}