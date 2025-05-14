class AppUrl {
  // static var localIp = '192.168.29.41';
  // static var awsIp = 'api.playaway.in';

  static var baseUrl = 'http://192.168.1.30:8080';
  // static var wsUrl = 'ws://$localIp:8080/ws/updates/';
  // static var paymentUrl = 'http://$localIp:9000/payment';
  // static var kycUrl = 'http://$localIp:9000/kyc';

  // static var baseUrl = 'https://$awsIp/myapi';
  // static var paymentUrl = 'https://$awsIp/payment';
  // static var kycUrl = 'https://$awsIp/kyc';
  // static var wsUrl = 'wss://$awsIp/ws/updates/';

  // Auth
  static var loginEndPint = '$baseUrl/auth/login';
  static var signUpEndPint = '$baseUrl/auth/signup';
  static var wallet = '$baseUrl/auth/wallet';
  static var accounts = '$baseUrl/auth';

  // Contests
  static var listContest = '$baseUrl/contests';

  //Get Players
  static var getPlayers = '$baseUrl/players/match';

  //Create Team
  static var createTeam = '$baseUrl/teams';
  static var reduceAmount = '$baseUrl/auth/deduct';
  static var viewTeam = '$baseUrl/teams/combined';

  // Points
  static var getPoints = '$baseUrl/points';
}
