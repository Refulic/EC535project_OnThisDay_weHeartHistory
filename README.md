# Beaglebone Historical Events Display App

The Beaglebone Historical Events Display App is an innovative project designed to provide users with a visually appealing and engaging way to explore past historical events and weather data that occurred on the current day. The application runs on a Beaglebone board and leverages the power of embedded Linux, APIs from Wikipedia, and QML to present historical events with brief introductions and images.

## Features

- Real-time display of current time and date
- Fetches historical events and weather data from APIs
- Visually appealing and interactive user interface using QML
- Efficient and low-resource performance using embedded Linux
- Customizable display options for user preferences

## System Components

1. **Network communication**: Accessing data from external sources, such as the Wikipedia API, using AJAX for asynchronous requests and implementing a reverse proxy with Heroku to overcome CORS limitations.
2. **LCD configuration**: Ensuring that user interface elements are displayed correctly and adapt to fixd beaglebone black screen size.
3. **User interface and interaction**: Creating an engaging and easy-to-use interface, allowing users to interact with the Display App through buttons to navigate between historical events and switch between display modes.
4. **Embedded Linux**: Providing a low-resource and efficient platform for the Display App, ensuring that the app runs smoothly on the Beaglebone board.
5. **Data modeling and processing**: Using ListModels to handle and organize the historical and weather data fetched from the APIs.

## Usage

1. Set up a Beaglebone board with embedded Linux.
2. Clone this repository onto the Beaglebone board.
3. Run the application using qml.

## Contributors

- Sean Tan: 50% (API and Network)
- Li Mingda: 50% (QT Graphics)


## Disclaimer

This project is for educational purposes only. The authors are not responsible for any misuse or copyright violations.
