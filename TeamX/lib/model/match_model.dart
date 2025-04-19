class MatchListModel {
  late List<Matches> matches;
  late Map<int, Matches> matchesMap;
  late Map<int, Squad> tournamentSquads;

  MatchListModel(
      {this.matches = const [],
        this.matchesMap = const <int, Matches>{},
        this.tournamentSquads = const <int, Squad>{}});

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

  void updateMatch(dynamic json) {
    final match = Matches.fromJson(json);
    matchesMap[match.mid] = match;
  }

  void updateTournamentSquads(dynamic json) {
    tournamentSquads = <int, Squad>{};
    for (var element in json) {
      final int sid = element['sid'];
      final Squad team = Squad.fromJson(element);
      tournamentSquads[sid] = team;
    }
  }
}

class Squad {
  late int sid;
  late String name;
  late String logo;
  late String abbreviation;

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

class Player {
  late int id;
  late String name;
  late int matchId;
  late int runs;
  late int balls;
  late int fours;
  late int sixes;
  late int oversCompleted;
  late int ballsBowled;
  late int runsConceded;
  late int wickets;
  late bool playing;
  late String howOut;
  late int position;

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

class Team {
  late int id;
  late String name;
  late Map<int, Player> players;
  late String logo;
  late String abbreviation;

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

class Innings {
  late int num;
  late int matchId;
  int? battingTeamId;
  int? bowlingTeamId;
  late int runs;
  late int wickets;
  late int overs;
  late int balls;

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

class Venue {
  late int id;
  late String name;
  late String city;
  late String country;

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

class Matches {
  late int mid;
  late String name;
  late String shortName;
  late String subtitle;
  late String startTime;
  String? endTime;
  int? matchType;
  late Map<int, Team> teams = <int, Team>{};
  int? winnerId;
  int? toss;
  late int inningsNo;
  Venue? venue;
  late int status;
  late int gameState;
  String? equation;
  String? result;
  String? winMargin;
  late String tournament;
  late String tournamentAbbr;
  late Innings innings1;
  late Innings innings2;
  int? strikerId;
  int? nonStrikerId;
  int? bowlerId;
  late int numInstruments;
  late bool isPlayingXIPopulated;
  late double totalVolume;
  late String totalVolumeStr;
  late int priority;

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

  Team? getBowlingFirstTeam() {
    int? teamId = innings1.bowlingTeamId;
    if (teamId == null) {
      return teams.values.last;
    }
    return teams[teamId];
  }

  Player? getStriker() {
    Team? battingTeam = getBattingTeam();
    return battingTeam?.players[strikerId];
  }

  Player? getNonStriker() {
    Team? battingTeam = getBattingTeam();
    return battingTeam?.players[nonStrikerId];
  }

  Player? getBowler() {
    Team? bowlingTeam = getBowlingTeam();
    return bowlingTeam?.players[bowlerId];
  }

  Player? getBatsman(int pid) {
    Team? battingTeam = getBattingTeam();
    return battingTeam?.players[pid];
  }

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

  void updateBatsmanDetails(Map<String, dynamic> json) {
    Team? battingTeam = getBattingTeam();
    Player? batsman = battingTeam?.players[json['id']];
    batsman?.runs = json['runs'];
    batsman?.balls = json['balls'];
    batsman?.fours = json['fours'];
    batsman?.sixes = json['sixes'];
  }

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