/// Configuration class for all API endpoints used in the application
///
/// This class contains all the URLs for different API endpoints used throughout the app.
/// It supports both local development and production environments.
class AppUrl {
  // Development environment configuration
  // static var localIp = '192.168.29.41';

  /// Base URL for the API server
  static var baseUrl = 'http://192.168.1.30:8080';

  /// Authentication endpoints
  static var loginEndPint = '$baseUrl/auth/login'; // User login
  static var signUpEndPint = '$baseUrl/auth/signup'; // User registration
  static var wallet = '$baseUrl/auth/wallet'; // Wallet management
  static var accounts = '$baseUrl/auth'; // User account management

  /// Contest management endpoints
  static var listContest = '$baseUrl/contests'; // List all contests

  /// Player management endpoints
  static var getPlayers = '$baseUrl/players/match'; // Get players for a match

  /// Team management endpoints
  static var createTeam = '$baseUrl/teams'; // Create a new team
  static var reduceAmount = '$baseUrl/auth/deduct'; // Deduct amount from wallet
  static var viewTeam = '$baseUrl/teams/combined'; // View team details

  /// Points system endpoints
  static var getPoints = '$baseUrl/points'; // Get points for players/teams
}
