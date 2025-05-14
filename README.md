# TeamX

**TeamX** is a full-stack Fantasy Sports Application that lets users create virtual teams, join contests, track real-time match data, and compete for leaderboard positions. The app is built with Flutter (mobile/web), a Spring Boot microservices backend, Kafka for real-time event streaming, and MongoDB for data storage. Secure payments are handled via a mock payment gateway with OTP verification.

---

## Features

### User & Authentication
- Secure login and signup (OAuth2/JWT)
- User profile management
- Passwordless OTP-based authentication for payments

### Fantasy Gameplay
- Browse upcoming matches and tournaments
- Create and manage fantasy teams
- Join contests and leagues
- Real-time points and leaderboard updates
- Detailed player stats and match analytics

### Real-Time & Data
- Live match updates via Kafka event streaming
- Real-time contest and player performance tracking
- External sports data integration (Sports Data API)

### Payments
- Add funds to wallet with OTP verification (Mock Payment Gateway)
- Join paid contests and manage wallet balance
- Transaction history and secure payment flows

### Admin & Moderation
- Admin dashboard for tournament and contest management
- User moderation tools

### Tech Stack

#### Frontend
- Flutter (mobile/web)
- Provider for state management

#### Backend
- Spring Boot microservices (API Gateway, Auth, User, Team, Tournament, Payment, Leaderboard)
- Kafka for event streaming and real-time updates
- Python Kafka consumer/producer for direct DB updates

#### Databases
- MongoDB for users, players, tournaments, and points

#### Infrastructure
- Kafka Cluster for event streaming
- Integration with external Sports Data API

---

## Architecture Overview

- **Client:** Flutter app communicates with backend via API Gateway.
- **Authentication:** OAuth2/JWT for secure access.
- **Backend:** Spring Boot microservices for all business logic.
- **Real-Time:** Kafka for live match and contest updates.
- **Payments:** Mock Payment Gateway with OTP sent to UI.
- **Data:** MongoDB for all persistent storage.
- **No cache layer:** Real-time updates handled via Kafka.

---

## Getting Started

1. **Clone the repository**
2. **Install dependencies**
   ```sh
   flutter pub get
   ```
3. **Run the app**
   ```sh
   flutter run
   ```
4. **Backend & Kafka**
   - Start Spring Boot services and Kafka cluster as per backend documentation.
   - Ensure MongoDB is running and accessible.

---

## Folder Structure

- `lib/` - Flutter app source code
- `lib/view/` - UI screens and widgets
- `lib/model/` - Data models
- `lib/utils/` - Utility classes and helpers
- `lib/res/` - Resources (styles, colors, URLs)
- `assets/` - Images, fonts, and animations

---

## Contributing

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Create a new Pull Request

---

## License

This project is for educational purposes.

---

## Credits

- [Flutter](https://flutter.dev/)
- [Spring Boot](https://spring.io/projects/spring-boot)
- [Kafka](https://kafka.apache.org/)
- [MongoDB](https://www.mongodb.com/)