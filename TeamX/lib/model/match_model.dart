/// Core data models for cricket match information and management
///
/// This file contains the following key classes:
/// 1. MatchListModel - Manages a collection of matches and their squads
/// 2. Squad - Represents a cricket team's squad information
/// 3. Player - Represents individual player statistics and details
/// 4. Team - Represents a cricket team with its players
/// 5. Innings - Represents match innings data
/// 6. Venue - Represents match venue information
/// 7. Matches - Main class representing a cricket match with all its details

/// Manages a collection of matches and their associated squads
class MatchListModel {
  late List<Matches> matches;
  late Map<int, Matches> matchesMap;
  late Map<int, Squad> tournamentSquads;

  MatchListModel(
      {this.matches = const [],
      this.matchesMap = const <int, Matches>{},
      this.tournamentSquads = const <int, Squad>{}});

  /// Creates a MatchListModel from JSON data
  ///
  /// Sorts matches by:
  /// 1. Status (active matches first)
  /// 2. Priority
  /// 3. Start time
  /// 4. Total volume
  MatchListModel.fromJson(List<dynamic> json,
      {Map<int, Squad> tournamentSquadsOld = const <int, Squad>{}}) {
    matches = <Matches>[];
    matchesMap = <int, Matches>{};
    tournamentSquads = tournamentSquadsOld;
    for (var v in json) {
      final match = Matches.fromJson(v);
      matches.add(match);
      matchesMap[match.mid] = match;
    }
    matches.sort((a, b) {
      // Compare by priority
      int statusComparisonA =
          a.status % 2; // 1 and 3 will result in 1, 2 and 4 will result in 0
      int statusComparisonB = b.status % 2;

      if (statusComparisonA != statusComparisonB) {
        return statusComparisonB.compareTo(statusComparisonA);
      }
      int priorityComparison = a.priority.compareTo(b.priority);
      if (priorityComparison != 0) {
        return priorityComparison;
      }

      // If totalVolumes are equal, compare by startTime
      int timeComparison = a.startTime.compareTo(b.startTime);
      if (timeComparison != 0) {
        return timeComparison;
      }

      // If priorities are equal, compare by totalVolume
      int volumeComparison = b.totalVolume.compareTo(a.totalVolume);
      return volumeComparison;
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (matches != null) {
      data['matches'] = matches!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  /// Updates a specific match in the collection
  void updateMatch(dynamic json) {
    final match = Matches.fromJson(json);
    matchesMap[match.mid] = match;
  }

  /// Updates tournament squads information
  void updateTournamentSquads(dynamic json) {
    tournamentSquads = <int, Squad>{};
    for (var element in json) {
      final int sid = element['sid'];
      final Squad team = Squad.fromJson(element);
      tournamentSquads[sid] = team;
    }
  }
}

/// Represents a cricket team's squad information
class Squad {
  late int sid; // Squad ID
  late String name; // Team name
  late String logo; // Team logo URL
  late String abbreviation; // Team abbreviation

  Squad({
    required this.sid,
    required this.name,
    required this.logo,
    required this.abbreviation,
  });

  // Named constructor to create a Squad object from a JSON map
  factory Squad.fromJson(Map<String, dynamic> json) {
    // print(json);
    return Squad(
      sid: json['sid'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
      abbreviation: json['abbreviation'] as String,
    );
  }

  // Convert the Squad object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'sid': sid,
      'name': name,
      'logo': logo,
      'abbreviation': abbreviation,
    };
  }
}

/// Represents individual player statistics and details
class Player {
  late int id; // Player ID
  late String name; // Player name
  late int matchId; // Associated match ID
  late int runs; // Runs scored
  late int balls; // Balls faced
  late int fours; // Number of fours
  late int sixes; // Number of sixes
  late int oversCompleted; // Overs bowled
  late int ballsBowled; // Balls bowled
  late int runsConceded; // Runs conceded
  late int wickets; // Wickets taken
  late bool playing; // Whether player is in playing XI
  late String howOut; // Dismissal information
  late int position; // Batting position

  Player({
    required this.id,
    this.name = "",
    required this.matchId,
    this.runs = 0,
    this.balls = 0,
    this.fours = 0,
    this.sixes = 0,
    this.oversCompleted = 0,
    this.ballsBowled = 0,
    this.runsConceded = 0,
    this.wickets = 0,
    this.playing = false,
    this.howOut = "",
    this.position = 12,
  });

  // Named constructor to create a Player object from a JSON map
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as int,
      name: json['name'] as String,
      matchId: json['matchId'] as int,
      runs: json['runs'] == null ? 0 : json['runs'] as int,
      balls: json['balls'] == null ? 0 : json['balls'] as int,
      fours: json['fours'] == null ? 0 : json['fours'] as int,
      sixes: json['sixes'] == null ? 0 : json['sixes'] as int,
      oversCompleted:
          json['overs_completed'] == null ? 0 : json['overs_completed'] as int,
      ballsBowled:
          json['balls_bowled'] == null ? 0 : json['balls_bowled'] as int,
      runsConceded:
          json['runs_conceded'] == null ? 0 : json['runs_conceded'] as int,
      wickets: json['wickets'] == null ? 0 : json['wickets'] as int,
      playing: json['playing'] == null ? false : json['playing'] as bool,
      howOut: json['how_out'] == null ? "" : json['how_out'] as String,
      position: json['batting_pos'] == null ? 12 : json['batting_pos'] as int,
    );
  }

  // toJson method to convert Player object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'matchId': matchId,
      'runs': runs,
      'balls': balls,
      'fours': fours,
      'sixes': sixes,
      'oversCompleted': oversCompleted,
      'ballsBowled': ballsBowled,
      'runsConceded': runsConceded,
      'playing': playing,
    };
  }
}

/// Represents a cricket team with its players
class Team {
  late int id; // Team ID
  late String name; // Team name
  late Map<int, Player> players; // Map of player ID to Player object
  late String logo; // Team logo URL
  late String abbreviation; // Team abbreviation

  Team({
    required this.id,
    required this.name,
    required this.players,
    this.logo = "",
    required this.abbreviation,
  });

  static Map<int, Player> parsePlayers(List<dynamic> json) {
    final Map<int, Player> playerMap = {};
    for (var element in json) {
      final int id = element['id'];
      final Player player = Player.fromJson(element);
      playerMap[id] = player;
    }
    return playerMap;
  }

  // Named constructor to create a Team object from a JSON map
  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] as int,
      name: json['name'] as String,
      players: parsePlayers(json['players']),
      logo: json['logo'] as String,
      abbreviation: json['abbreviation'] as String,
    );
  }

  // toJson method to convert Team object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'players': players
          .map((key, player) => MapEntry(key.toString(), player.toJson())),
      'logo': logo,
      'abbreviation': abbreviation,
    };
  }
}

/// Represents match innings data
class Innings {
  late int num; // Innings number (1 or 2)
  late int matchId; // Associated match ID
  int? battingTeamId; // ID of batting team
  int? bowlingTeamId; // ID of bowling team
  late int runs; // Total runs scored
  late int wickets; // Wickets fallen
  late int overs; // Overs completed
  late int balls; // Balls bowled

  Innings({
    required this.num,
    required this.matchId,
    this.battingTeamId,
    this.bowlingTeamId,
    this.runs = 0,
    this.wickets = 0,
    this.overs = 0,
    this.balls = 0,
  });

  // Named constructor to create an Innings object from a JSON map
  factory Innings.fromJson(Map<String, dynamic> json) {
    var output = Innings(
      num: json['num'] as int,
      matchId: json['match'] as int,
      battingTeamId: json['batting_team_id'] as int?,
      bowlingTeamId: json['bowling_team_id'] as int?,
      runs: json['runs'] as int,
      wickets: json['wickets'] as int,
      overs: json['overs'] as int,
      balls: json['balls'] as int,
    );
    return output;
  }

  // toJson method to convert Innings object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'num': num,
      'match_id': matchId,
      'batting_team': battingTeamId,
      'bowling_team': bowlingTeamId,
      'runs': runs,
      'wickets': wickets,
      'overs': overs,
      'balls': balls,
    };
  }
}

/// Represents match venue information
class Venue {
  late int id; // Venue ID
  late String name; // Venue name
  late String city; // City name
  late String country; // Country name

  // Constructor
  Venue({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
  });

  // Factory method to create a Venue object from a JSON map
  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['vid'] as int,
      name: json['name'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
    );
  }

  // Convert the Venue object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'country': country,
    };
  }
}

/// Main class representing a cricket match with all its details
class Matches {
  late int mid; // Match ID
  late String name; // Match name
  late String shortName; // Short match name
  late String subtitle; // Match subtitle
  late String startTime; // Match start time
  String? endTime; // Match end time
  int? matchType; // Type of match (T20, ODI, etc.)
  late Map<int, Team> teams; // Map of team ID to Team object
  int? winnerId; // ID of winning team
  int? toss; // Toss result
  late int inningsNo; // Current innings number
  Venue? venue; // Match venue
  late int status; // Match status
  late int gameState; // Current game state
  String? equation; // Required run rate equation
  String? result; // Match result
  String? winMargin; // Winning margin
  late String tournament; // Tournament name
  late String tournamentAbbr; // Tournament abbreviation
  late Innings innings1; // First innings data
  late Innings innings2; // Second innings data
  int? strikerId; // Current striker's ID
  int? nonStrikerId; // Current non-striker's ID
  int? bowlerId; // Current bowler's ID
  late int numInstruments; // Number of instruments
  late bool isPlayingXIPopulated; // Whether playing XI is set
  late double totalVolume; // Total match volume
  late String totalVolumeStr; // Total volume as string
  late int priority; // Match priority

  Matches({
    required this.mid,
    this.name = "",
    this.shortName = "",
    this.subtitle = "",
    this.startTime = "",
    this.endTime,
    this.matchType,
    required this.teams,
    this.winnerId,
    this.toss,
    this.inningsNo = 0,
    this.status = 1,
    this.gameState = 0,
    this.equation,
    this.result,
    this.winMargin,
    this.tournament = "",
    this.tournamentAbbr = "",
    this.venue,
    this.strikerId,
    this.nonStrikerId,
    this.bowlerId,
    this.numInstruments = 0,
    this.isPlayingXIPopulated = false,
    Innings? innings1,
    Innings? innings2,
    this.totalVolume = 0.0,
    this.totalVolumeStr = "0",
    this.priority = 3,
  })  : innings1 = innings1 ?? Innings(num: 1, matchId: mid),
        innings2 = innings2 ?? Innings(num: 2, matchId: mid);

  /// Gets the current batting team
  Team? getBattingTeam() {
    Team? battingTeam;
    if (inningsNo == 1) {
      int? teamId = innings1.battingTeamId;
      battingTeam = teams[teamId];
    } else {
      int? teamId = innings2.battingTeamId;
      battingTeam = teams[teamId];
    }
    return battingTeam;
  }

  /// Gets the current bowling team
  Team? getBowlingTeam() {
    Team? bowlingTeam;
    if (inningsNo == 1) {
      int? teamId = innings1.bowlingTeamId;
      bowlingTeam = teams[teamId];
    } else {
      int? teamId = innings2.bowlingTeamId;
      bowlingTeam = teams[teamId];
    }
    return bowlingTeam;
  }

  /// Gets the team that batted first
  Team? getBattingFirstTeam() {
    int? teamId = innings1.battingTeamId;
    if (teamId == null) {
      // TODO: handle this error
      try {
        return teams.values.first;
      } catch (e) {
        return null;
      }
      // return teams.values.first;
    }
    return teams[teamId];
  }

  /// Gets the team that bowled first
  Team? getBowlingFirstTeam() {
    int? teamId = innings1.bowlingTeamId;
    if (teamId == null) {
      return teams.values.last;
    }
    return teams[teamId];
  }

  /// Gets the current striker
  Player? getStriker() {
    Team? battingTeam = getBattingTeam();
    return battingTeam?.players[strikerId];
  }

  /// Gets the current non-striker
  Player? getNonStriker() {
    Team? battingTeam = getBattingTeam();
    return battingTeam?.players[nonStrikerId];
  }

  /// Gets the current bowler
  Player? getBowler() {
    Team? bowlingTeam = getBowlingTeam();
    return bowlingTeam?.players[bowlerId];
  }

  /// Gets a batsman by their ID
  Player? getBatsman(int pid) {
    Team? battingTeam = getBattingTeam();
    return battingTeam?.players[pid];
  }

  /// Gets a bowler by their ID
  Player? getBowlerFromPid(int pid) {
    Team? bowlingTeam = getBowlingTeam();
    return bowlingTeam?.players[pid];
  }

  static Map<int, Team> parseTeams(List<dynamic> json) {
    final Map<int, Team> teamMap = {};
    for (var element in json) {
      final int id = element['id'];
      final Team team = Team.fromJson(element);
      teamMap[id] = team;
    }
    return teamMap;
  }

  /// Updates batsman's details
  void updateBatsmanDetails(Map<String, dynamic> json) {
    Team? battingTeam = getBattingTeam();
    Player? batsman = battingTeam?.players[json['id']];
    batsman?.runs = json['runs'];
    batsman?.balls = json['balls'];
    batsman?.fours = json['fours'];
    batsman?.sixes = json['sixes'];
  }

  /// Updates bowler's details
  void updateBowlerDetails(Map<String, dynamic> json) {
    Team? bowlingTeam = getBowlingTeam();
    Player? bowler = bowlingTeam?.players[json['id']];
    bowler?.runsConceded = json['runs_conceded'];
    bowler?.ballsBowled = json['balls'];
    bowler?.oversCompleted = json['overs'];
    bowler?.wickets = json['wickets'];
  }

  Matches.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    name = json['name'];
    shortName = json['short_name'];
    subtitle = json['subtitle'];
    startTime = json['start_time'];

    endTime = json['end_time'];
    numInstruments = json['num_instruments'];
    matchType = json['match_type'];

    winnerId = json['winner_id'];
    toss = json['toss'];
    inningsNo = json['innings_no'];
    status = json['status'];

    gameState = json['game_state'];
    equation = json['equation'];
    result = json['result'];
    winMargin = json['win_margin'];
    tournament = json['tournament'];
    tournamentAbbr = json['tournamentabbr'];
    isPlayingXIPopulated = json['playing_xi_populated'];

    venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;

    innings1 = json['innings1'] != null
        ? Innings.fromJson(json['innings1'])
        : Innings(num: 1, matchId: mid);

    innings2 = json['innings2'] != null
        ? Innings.fromJson(json['innings2'])
        : Innings(num: 2, matchId: mid);

    strikerId = json['strikerId'];

    nonStrikerId = json['nonStrikerId'];

    bowlerId = json['bowlerId'];
    if (json["teams"] != null) {
      teams = parseTeams(json['teams']);
    }
    totalVolume = json['total_volume'].toDouble();
    totalVolumeStr = json['total_volume_str'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mid'] = mid;
    data['name'] = name;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['match_type'] = matchType;
    data['winner_id'] = winnerId;
    data['toss'] = toss;
    data['innings_no'] = inningsNo;
    data['status'] = status;
    data['game_state'] = gameState;
    data['equation'] = equation;
    data['result'] = result;
    data['win_margin'] = winMargin;
    data['tournament'] = tournament;
    data['venue'] = venue;
    data['strikerId'] = strikerId;
    data['nonStrikerId'] = nonStrikerId;
    data['bowlerId'] = bowlerId;
    return data;
  }
}
