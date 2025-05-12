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

  // Contests
  static var listContest = '$baseUrl/contests';

  //Get Players
  static var getPlayers = '$baseUrl/players/match';

  //Create Team
  static var createTeam = '$baseUrl/teams';
  static var reduceAmount = '$baseUrl/auth/deduct';






  
  static var verifyTokenEndPoint = '$baseUrl/accounts/verify_token';
  static var updateDisplayOrderStatusEndPoint =
      '$baseUrl/accounts/update_display_order_status';
  static var submitFeedbackEndPoint = '$baseUrl/accounts/submit_feedback';


  static var registerApiEndPoint = '$baseUrl/accounts/register';

  static var matchListEndPoint = '$baseUrl/live_matches/all';
  static var matchEndPoint = '$baseUrl/live_matches/scorecard';
  static var tournamentSquadsEndPoint = '$baseUrl/tournament_squads';
  static var tournamentListEndPoint = '$baseUrl/tournaments';
  static var instrumentListEndPoint = '$baseUrl/instruments';
  static var instrumentListHomeEndPoint = '$baseUrl/instruments_home';
  static var instrumentEndPoint = '$baseUrl/instruments/refresh';
  static var portfolioListEndPoint = baseUrl + '/orders/open_positions';
  static var portfolioClosedListEndPoint = '$baseUrl/orders/closed_positions';
  static var portfolioClosedPagedListEndPoint =
      '$baseUrl/orders/closed_positions_paged';
  static var sendOrderEndPoint = '$baseUrl/orders/send_order';
  static var getOpenOrdersEndPoint = '$baseUrl/orders/open_orders';
  static var cancelOrderEndPoint = '$baseUrl/orders/cancel_order';
  static var cancelOrderInstEndPoint =
      '$baseUrl/orders/cancel_all_of_instrument';
  static var modifyOrderEndPoint = '$baseUrl/orders/modify_order';
  static var orderStatusEndPoint = '$baseUrl/orders/order_status';
  static var closePositionEndPoint = '$baseUrl/orders/close_position';
  static var profileInfoget = '$baseUrl/accounts/get_profile';
  static var profileInfopost = '$baseUrl/accounts/update_profile';
  static var getWalletDetails = '$baseUrl/accounts/get_wallet';
  static var redeemPromoBalance = '$baseUrl/accounts/redeem_promo_balance';
  static var getTransactionHistory =
      '$baseUrl/accounts/get_transaction_history';
  // static var addMoney = '$paymentUrl/add_money';
  // static var verifyPayment = '$paymentUrl/verify_payment';
  // static var withdrawMoney = '$paymentUrl/withdraw_money';
  // static var tdsDiscount = '$paymentUrl/tds_discount';
  static var getFaq = '$baseUrl/help/faqs';
  static var getCategories = '$baseUrl/help/question_categories';
  static var getChatRoom = '$baseUrl/help/chat_room';
  static var postSendMessage = '$baseUrl/help/send_message';
  static var postQuestionOfCategory = '$baseUrl/help/get_questions';
  static var getAllQuestions = '$baseUrl/help/get_all_questions';
  static var orderHistory = '$baseUrl/orders/get_order_history';
  static var orderHistoryPaged = '$baseUrl/orders/get_order_history_paged';
  static var getTradeHistoryInstEndPoint =
      '$baseUrl/orders/get_trade_history_inst';
  static var userStats = '$baseUrl/accounts/user_stats';
  static var openOrderInfo = '$baseUrl/orders/open_orders_list';
  static var tradeTransactionHistory =
      '$baseUrl/orders/get_trade_transaction_history';
  static var tradeTransactionHistoryPaged =
      '$baseUrl/orders/get_trade_transaction_history_paged';

  static var getLeaderboardDataEndPoint =
      '$baseUrl/accounts/get_referral_leaderboard';
  static var getLeaderboardUserEndPoint =
      '$baseUrl/accounts/get_user_referral_leaderboard';

  // HYPE
  static var getPostListEndPoint = '$baseUrl/hype/get_posts';
  static var getPostListPagedEndPoint = '$baseUrl/hype/get_posts_paged';
  static var getPostListCreatorEndPoint = '$baseUrl/hype/get_posts_of_creator';
  static var getPostListCreatorPagedEndPoint =
      '$baseUrl/hype/get_posts_of_creator_paged';
  static var getPostListFollowingEndPoint =
      '$baseUrl/hype/get_posts_of_following';
  static var createHypePost = '$baseUrl/hype/create_post';
  static var followCreator = '$baseUrl/hype/follow_creator';
  static var unfollowCreator = '$baseUrl/hype/unfollow_creator';
  static var reactPost = '$baseUrl/hype/react_post';
  static var getReactions = '$baseUrl/hype/get_reactions';
  static var getFollowing = '$baseUrl/hype/get_following';
  static var getCreatorDetails = '$baseUrl/hype/get_creator_details';
  static var getCreatorWinningsPaged =
      '$baseUrl/hype/get_creator_winnings_paged';
  static var deletePost = '$baseUrl/hype/delete_post';
  static var editCreatorDetails = '$baseUrl/hype/edit_creator_details';
  static var getPost = '$baseUrl/hype/get_post';

  // fantasy
  static var getFantasyContestList = '$baseUrl/fantasy/get_fantasy_contests';
  static var getFantasyPlayerList = '$baseUrl/fantasy/get_fantasy_players';
  static var createFantasyTeam = '$baseUrl/fantasy/create_fantasy_team';
  static var getMyFantasyTeams = '$baseUrl/fantasy/get_my_fantasy_teams';
  static var getMyFantasyContests = '$baseUrl/fantasy/get_my_fantasy_contests';
  static var joinFantasyContest = '$baseUrl/fantasy/join_fantasy_contest';
  static var fetchFantasyTeamPreview =
      '$baseUrl/fantasy/fetch_fantasy_team_preview';
  static var fetchFantasyTeamFromLink =
      '$baseUrl/fantasy/fetch_fantasy_team_from_link';

  static var getMyMatches = '$baseUrl/fantasy/get_my_matches';
  static var getOpenedContest = '$baseUrl/fantasy/get_opened_contest';
  static var getFantasyTransactionsPaged =
      '$baseUrl/fantasy/get_fantasy_transactions_paged';
  static var getPlayerFantasyPoints =
      '$baseUrl/fantasy/get_player_fantasy_points';
}
