import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12

Rectangle {
    visible: true
    width: 500
    height: 500


    // Get History Data from Wikipedia
    function updateHistoryData() {   
        var xhr = new XMLHttpRequest()
        var today = new Date()
        var day = today.getDate()
        var month = today.getMonth() + 1 // Months are zero-based
        var year = today.getFullYear()

        var dateString = year + "/" + (month < 10 ? "0" + month : month) + "/"
                + (day < 10 ? "0" + day : day)

        var apiUrl = "https://polar-headland-44538.herokuapp.com/https://api.wikimedia.org/feed/v1/wikipedia/en/featured/2023/04/24/" + dateString
        function populateHistoryModel(jsonData) {
            historyDataModel.clear()

            // Add top 5 events on this day
            for (var i = 0; i < 5; i++) {
                var eventData = jsonData[i]
                var newItem = {
                "year": eventData.year,
                "text": eventData.text
                };
        
                if (eventData.pages && eventData.pages[0] && eventData.pages[0].thumbnail && eventData.pages[0].thumbnail.source) {
                    newItem.image = eventData.pages[0].thumbnail.source;
                }
                historyDataModel.append(newItem)
            }

            //API call handling
            xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            var jsonData = JSON.parse(xhr.responseText);
                            populateHistoryModel(jsonData.selected);
                        } else {
                            console.log("Error loading history data: " + xhr.status);
                        }
                    }
                }
                
                xhr.open("GET", apiUrl);
                xhr.send();

        }
        
        populateHistoryModel(jsonData)

        // Get Weather Data from worldweatheronline
        var currentHour = today.getHours();

        var apiWeatherUrl = `"https://polar-headland-44538.herokuapp.com/http://api.worldweatheronline.com/premium/v1/past-weather.ashx?key=${apiKey}&q=Boston&format=json&date=${date}`

        function populateWeatherModel(weatherData) {

            var hourData = weatherData[hourly][currentHour]
            var year = new Date(hourData.date).getFullString
            var newItem = {
                "year": year,
                "temperature": hourData.tempF,
                "image": hourData.weatherIconUrl[0].value
            }
            weatherDataModel.append(newItem)
        }

            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        var jsonData = JSON.parse(xhr.responseText);
                        populateWeatherModel(jsonData.weather[0]);
                    } else {
                        console.log("Error loading weather data: " + xhr.status);
                    }
            }
        }

            // Retrieves weather data from current, 5, 10, 15, 20 years ago
            for (var i = 0; i < 5; i++) {
                dateString = year + "/" + (month < 10 ? "0" + month : month) + "/"
                + (day < 10 ? "0" + day : day)
                apiWeatherUrl = `http://api.worldweatheronline.com/premium/v1/past-weather.ashx?key=${apiKey}&q=Boston&format=json&date=${dateString}`
                xhr.open("GET", apiUrl);
                xhr.send();
                year -= 5
            }

        populateWeatherModel(weatherData)

    }

    Component.onCompleted: {
        updateHistoryData()
    }

    ListModel {
        id: historyDataModel
    }

    ListModel {
        id: weatherDataModel
    }

    Rectangle {
        id: backbackground
        width: 480
        height: 272
        z: 0
        color: "#4c4c4c"


        Image {
               id: myImage
               anchors.fill: parent
               source: "file:/root/galaxy.jpg"
               fillMode: Image.PreserveAspectCrop
           }

        Rectangle {
            id: background
            width: 470
            height: 262
            radius: 0
            x: 5
            y: 5
            z: 1
            color: "#818785"
            opacity: 0.8





            ColumnLayout {
                //arrange elements in column
                anchors.fill: parent


                spacing: 5

                RowLayout {
                    //this is top titles
                    //arrange elements in row
                    Layout.alignment:Qt.AlignHCenter
                    spacing:30

                    Rectangle{
                        id:bigTitle
                        width:250
                        height:60
                        color:"transparent"


                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            id: titleText
                            text: "  DAILY Info"
                            lineHeight: 0.65
                            font.pixelSize: 30
                            font.bold: true
                            font.italic: true
                            color: "#e942b4"

                        }

                        Text {
                            id: titleTextOutline
                            text: titleText.text
                            font.pixelSize: titleText.font.pixelSize
                            font.bold: titleText.font.bold
                            font.italic: titleText.font.italic
                            lineHeight:titleText.lineHeight
                            color: "#85ffe3"
                            anchors.horizontalCenter: titleText.horizontalCenter
                            anchors.verticalCenter: titleText.verticalCenter
                            anchors.horizontalCenterOffset: 1
                            anchors.verticalCenterOffset: 1
                            //anchors.centerIn: titleText
                            //anchors.left: titleText
                            //anchors.top: titleText
                            //anchors.leftMargin: 5
                            //anchors.topMargin: 5
                            opacity: 0.5
                        }
                    }



                    ColumnLayout {



                        Column {
                            Text {
                                anchors.left:parent.left
                                anchors.top:parent.top
                                anchors.topMargin: 7
                                id: todaysDate
                                font.bold: true
                                font.pointSize: 15
                                color: "#9542e9"
                                text: {
                                    var today = new Date()
                                    var day = today.getDate()
                                    var month = today.getMonth() + 1
                                    var year = today.getFullYear()
                                    return day + "/" + month + "/" + year
                                }
                            }

                            Text {
                                id: todaysDateOutline
                                text: todaysDate.text
                                font.pixelSize: todaysDate.font.pixelSize
                                font.bold: todaysDate.font.bold
                                font.italic: todaysDate.font.italic
                                lineHeight:todaysDate.lineHeight
                                color: "#85ffe3"
                                anchors.horizontalCenter: todaysDate.horizontalCenter
                                anchors.verticalCenter: todaysDate.verticalCenter
                                anchors.horizontalCenterOffset: 1
                                anchors.verticalCenterOffset: 1
                                opacity: 0.5
                            }



                            Text {
                                anchors.top:parent.top
                                anchors.topMargin: 30
                                anchors.left:parent.left
                                anchors.leftMargin: 10

                                id: currentTime
                                font.bold: true
                                font.pointSize: 15
                                color: "#9542e9"
                                text: Qt.formatTime(new Date(), "hh:mm:ss")
                                Timer {
                                    interval: 1000
                                    running: true
                                    repeat: true
                                    onTriggered: currentTime.text = Qt.formatTime(
                                                     new Date(), "hh:mm:ss")
                                }
                            }

                            Text {
                                id: currentTimeOutline
                                text: currentTime.text
                                font.pixelSize: currentTime.font.pixelSize
                                font.bold: currentTime.font.bold
                                font.italic: currentTime.font.italic
                                lineHeight:currentTime.lineHeight
                                color: "#85ffe3"
                                anchors.horizontalCenter: currentTime.horizontalCenter
                                anchors.verticalCenter: currentTime.verticalCenter
                                anchors.horizontalCenterOffset: 1
                                anchors.verticalCenterOffset: 1
                                opacity: 0.5
                            }
                        }
                    }
                }
                Row {
                    //this is button
                    Layout.alignment:Qt.AlignHCenter
                    spacing: 20
                    // prevButton
                    Rectangle {
                        id: prevButton
                        width: 80
                        height: 30
                        color: "#CCC"
                        border.color: "black"
                        border.width: 2
                        radius:3

                        Text {
                            text: "Prev"
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("Custom button clicked")
                                if (historyListView.contentY > 160) {
                                    historyListView.contentY -= 160
                                } else {
                                    historyListView.contentY = 0
                                }
                            }
                        }
                    }

                    // Toggle Button
                    Rectangle {
                        id: changeMode
                        width: 80
                        height: 30
                        color: "#CCC"
                        border.color: "black"
                        border.width: 2
                        radius:3

                        Text {
                            text: "Mode"
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                historyListView.visible = !historyListView.visible;
                                weatherReportListView.visible=!weatherReportListView.visible;
                                nextButton.visible=!nextButton.visible;
                                prevButton.visible=!prevButton.visible;

                            }
                        }
                    }
                    // nextButton
                    Rectangle {
                        id: nextButton
                        width: 80
                        height: 30
                        color: "#CCC"
                        border.color: "black"
                        border.width: 2
                        radius:3

                        Text {
                            text: "Next"
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                console.log("Custom button clicked")

                                if (historyListView.contentY < historyListView.contentHeight
                                        - historyListView.height - 160) {
                                    historyListView.contentY += 160
                                } else {
                                    historyListView.contentY = historyListView.contentHeight
                                            - historyListView.height
                                }
                            }
                        }
                    }

                }
                Rectangle {
                    //this is list of weather report, and list of historyListView .
                    //weather report
                    id: listBackground
                    width: 470
                    height: 160
                    x: 10
                    z: 2
                    color: "#ffffff"

                    //list of weather report
                    ListView {
                        id:  weatherReportListView
                        visible: false

                        anchors.fill: parent
                        clip: true //insure the size of listview
                        model: weatherDataModel //define dataset
                        delegate: Item {
                            //how to show each item
                            width:  weatherReportListView.width
                            height: 80

                            Rectangle {
                                anchors.fill: parent
                                color: index % 2 == 0 ? "#EEE" : "#FFF"
                            }

                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                //anchors.fill: parent
                                spacing: 15
                                Text {
                                    anchors.top: parent.top
                                    anchors.topMargin: 30 // Change this value to move the Text element up or down
                                    text: model.year
                                    font.bold: true
                                    width: parent.width * 0.1
                                }

                                Text {
                                    text: model.temperature
                                    wrapMode: Text.WordWrap
                                    width: parent.width * 0.6
                                }

                                Image {
                                    visible: model.image !== undefined // show if image exist
                                    source: model.image
                                    width: 100
                                    height: 80
                                    fillMode: Image.PreserveAspectFit
                                }
                            }
                        }
                    }
                    //list of history
                    ListView {
                        id: historyListView

                        anchors.fill: parent
                        clip: true //insure the size of listview
                        model: historyDataModel //define dataset
                        delegate: Item {
                            //how to show each item
                            width: historyListView.width
                            height: 80

                            Rectangle {
                                anchors.fill: parent
                                color: index % 2 == 0 ? "#EEE" : "#FFF"
                            }

                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                //anchors.fill: parent
                                spacing: 15
                                Text {
                                    anchors.top: parent.top
                                    anchors.topMargin: 30 // Change this value to move the Text element up or down
                                    text: model.year
                                    font.bold: true
                                    width: parent.width * 0.1
                                }

                                Text {
                                    text: model.text
                                    wrapMode: Text.WordWrap
                                    width: parent.width * 0.6
                                    font.pointSize:9
                                }

                                Image {
                                    visible: model.image !== undefined // show if image exist
                                    source: model.image
                                    width: 100
                                    height: 80
                                    fillMode: Image.PreserveAspectFit
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}