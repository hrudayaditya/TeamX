# TeamX - Fantasy Sports Application

A strategy-based online sports game wherein you can create a virtual team of real players playing in real life matches, track their performances and earn points based on player performances. The primary goal of the application is to engage sports fans by giving them a virtual stake in games and offering the thrill of team management and competition.

## Features

### User Authentication
The application implements a robust authentication system that ensures secure access to user accounts. Users can create new accounts with email verification and password protection. The system includes:
- Secure login and signup system with email validation
- Password strength requirements and validation
- Admin authentication with special privileges
- Secure storage of user credentials and session data using Flutter Secure Storage
- Session management with JWT tokens
- Automatic logout functionality

### Contest Management
The contest management system allows users to participate in various fantasy sports competitions:
- View and join various contests with different entry fees and prize pools
- Filter contests by type (free/paid) to find suitable competitions
- View detailed contest information including:
  - Prize pool distribution
  - Entry fee requirements
  - Total spots available
  - Number of spots filled
  - Match details and timing
- Track total number of available contests
- View contest history and results

### Team Creation
The team creation feature is the core of the fantasy sports experience:
- Create fantasy teams for specific matches
- Select players from different categories:
  - WK (Wicket Keeper)
  - BAT (Batsmen)
  - AR (All Rounders)
  - BOWL (Bowlers)
- Choose captain and vice-captain for bonus points
- Preview team before final submission
- Save team configurations for future reference
- Team validation to ensure all required positions are filled
- Player selection limits per category

### Wallet System
The wallet system manages all financial transactions within the application:
- Secure wallet management with balance tracking
- Add money functionality with OTP verification for security
- View current wallet balance
- Transaction history with detailed records
- Secure payment processing
- Balance updates in real-time
- Transaction status tracking

### Match Management
The match management system provides comprehensive information about ongoing and upcoming matches:
- View upcoming matches with detailed schedules
- Track match status and live results
- View team information and match details including:
  - Venue information
  - Team lineups
  - Match statistics
  - Player performances
- Access match statistics and analytics
- Real-time match updates

### Points System
The points system is designed to fairly evaluate player performances:
- Comprehensive fantasy points system based on player actions
- Track individual player performances
- View detailed points breakdown for each action
- Real-time points updates during matches
- Points calculation based on:
  - Batting performance
  - Bowling performance
  - Fielding contributions
  - Special achievements

### Admin Features
The admin panel provides comprehensive management capabilities:
- Special admin dashboard with system overview
- Contest management capabilities:
  - Create new contests
  - Modify existing contests
  - Monitor contest participation
- User management:
  - View user accounts
  - Manage user permissions
  - Handle user issues
- System monitoring:
  - Track system performance
  - Monitor user activities
  - Generate reports

## Testing

The application implements comprehensive testing across multiple levels:

### Unit Tests
- ViewModel testing for business logic
- Utility function testing
- Data model validation

### Widget Tests
- UI component testing
- Screen rendering verification
- User interaction testing
- Navigation flow testing

### Smoke Tests
- End-to-end functionality testing
- Critical path verification
- Error handling validation
- State management testing

### Integration Tests
- API integration testing
- Database operations testing
- Third-party service integration

The test suite ensures reliability and stability of the application through automated testing of all major features and components.   x

