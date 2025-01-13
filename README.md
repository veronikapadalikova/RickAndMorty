# Rick And Morty Characters iOS Application

Rick and Morty Characters is a sample iOS application showcasing my current coding skills. The application is written in **Swift** using the **SwiftUI** framework. Its main features include a list of characters with pagination, an API-powered search (also paginated), and a section for managing favorite characters.

---

## Architecture
- The application is implemented using the **MVVM (Model-View-ViewModel)** architecture pattern for a clear separation of concerns and improved testability.

---

## Structure
The project is structured into four key areas for maintainability and scalability:
- **Features**: Contains the `View`, `ViewModel`, and `Model` for each logical UI section.
- **Services**: Includes the `Network Services` subfolder, which implements the network model to simplify API requests.
- **Utilities**: Contains extensions used throughout the app.
- **Resources**: Contains fonts, font settings, color definitions, and other assets.
- Other files, such as the app entry point, are located in the root directory.

---

## API
- The application utilizes a REST API with **native async/await** for smooth and efficient asynchronous data fetching.

---

## Dependencies
- No external dependencies were used for this project, ensuring a fully native implementation.

---

## Highlights
- **Custom Components**: Includes reusable components such as the tab bar, paging rows, and image loading to demonstrate component-based design.
- **Theming**: Implements a custom design system with consistent use of fonts, colors, and styles.
- **Navigation**: Fully customizable navigation handling.

---

## Final Thoughts
The design of the application allows for much more functionality and features to be added in the future. However, for the purposes of demonstrating my coding abilities within a limited timeframe, this implementation achieves its goals effectively.

---

## Possible Future Enhancements
- Add unit tests and UI tests for greater code reliability.
- Integrate additional features, such as filtering characters by species or status.
- Implement caching for improved offline usability.

Thank you for checking out the **Rick And Morty Characters iOS Application**!
