import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/model/match_model.dart';

void main() {
  group('Squad', () {
    test('creates Squad from JSON', () {
      final squad = Squad.fromJson({
        'sid': 1,
        'name': 'Test Squad',
        'logo': 'test_logo.png',
        'abbreviation': 'TS',
      });

      expect(squad.sid, equals(1));
      expect(squad.name, equals('Test Squad'));
      expect(squad.logo, equals('test_logo.png'));
      expect(squad.abbreviation, equals('TS'));
    });

    test('converts Squad to JSON', () {
      final squad = Squad(
        sid: 1,
        name: 'Test Squad',
        logo: 'test_logo.png',
        abbreviation: 'TS',
      );

      final json = squad.toJson();
      expect(json['sid'], equals(1));
      expect(json['name'], equals('Test Squad'));
      expect(json['logo'], equals('test_logo.png'));
      expect(json['abbreviation'], equals('TS'));
    });
  });

  group('Player', () {
    test('creates Player from JSON with all fields', () {
      final player = Player.fromJson({
        'id': 1,
        'name': 'Test Player',
        'matchId': 1,
        'runs': 50,
        'balls': 30,
        'fours': 5,
        'sixes': 2,
        'overs_completed': 4,
        'balls_bowled': 24,
        'runs_conceded': 30,
        'wickets': 2,
        'playing': true,
        'how_out': 'caught',
        'batting_pos': 3,
      });

      expect(player.id, equals(1));
      expect(player.name, equals('Test Player'));
      expect(player.matchId, equals(1));
      expect(player.runs, equals(50));
      expect(player.balls, equals(30));
      expect(player.fours, equals(5));
      expect(player.sixes, equals(2));
      expect(player.oversCompleted, equals(4));
      expect(player.ballsBowled, equals(24));
      expect(player.runsConceded, equals(30));
      expect(player.wickets, equals(2));
      expect(player.playing, isTrue);
      expect(player.howOut, equals('caught'));
      expect(player.position, equals(3));
    });

    test('creates Player from JSON with minimal fields', () {
      final player = Player.fromJson({
        'id': 1,
        'name': 'Test Player',
        'matchId': 1,
      });

      expect(player.id, equals(1));
      expect(player.name, equals('Test Player'));
      expect(player.matchId, equals(1));
      expect(player.runs, equals(0));
      expect(player.balls, equals(0));
      expect(player.fours, equals(0));
      expect(player.sixes, equals(0));
      expect(player.oversCompleted, equals(0));
      expect(player.ballsBowled, equals(0));
      expect(player.runsConceded, equals(0));
      expect(player.wickets, equals(0));
      expect(player.playing, isFalse);
      expect(player.howOut, isEmpty);
      expect(player.position, equals(12));
    });

    test('converts Player to JSON', () {
      final player = Player(
        id: 1,
        name: 'Test Player',
        matchId: 1,
        runs: 50,
        balls: 30,
        fours: 5,
        sixes: 2,
        oversCompleted: 4,
        ballsBowled: 24,
        runsConceded: 30,
        wickets: 2,
        playing: true,
        howOut: 'caught',
        position: 3,
      );

      final json = player.toJson();
      expect(json['id'], equals(1));
      expect(json['name'], equals('Test Player'));
      expect(json['matchId'], equals(1));
      expect(json['runs'], equals(50));
      expect(json['balls'], equals(30));
      expect(json['fours'], equals(5));
      expect(json['sixes'], equals(2));
      expect(json['oversCompleted'], equals(4));
      expect(json['ballsBowled'], equals(24));
      expect(json['runsConceded'], equals(30));
      expect(json['playing'], isTrue);
    });
  });

  group('Team', () {
    test('creates Team from JSON', () {
      final team = Team.fromJson({
        'id': 1,
        'name': 'Test Team',
        'players': [
          {
            'id': 1,
            'name': 'Player 1',
            'matchId': 1,
          },
          {
            'id': 2,
            'name': 'Player 2',
            'matchId': 1,
          }
        ],
        'logo': 'test_logo.png',
        'abbreviation': 'TT',
      });

      expect(team.id, equals(1));
      expect(team.name, equals('Test Team'));
      expect(team.logo, equals('test_logo.png'));
      expect(team.abbreviation, equals('TT'));
      expect(team.players.length, equals(2));
      expect(team.players[1]?.name, equals('Player 1'));
      expect(team.players[2]?.name, equals('Player 2'));
    });

    test('converts Team to JSON', () {
      final team = Team(
        id: 1,
        name: 'Test Team',
        players: {
          1: Player(id: 1, name: 'Player 1', matchId: 1),
          2: Player(id: 2, name: 'Player 2', matchId: 1),
        },
        logo: 'test_logo.png',
        abbreviation: 'TT',
      );

      final json = team.toJson();
      expect(json['id'], equals(1));
      expect(json['name'], equals('Test Team'));
      expect(json['logo'], equals('test_logo.png'));
      expect(json['abbreviation'], equals('TT'));
      expect(json['players'].length, equals(2));
    });
  });

  group('Innings', () {
    test('creates Innings from JSON', () {
      final innings = Innings.fromJson({
        'num': 1,
        'match': 1,
        'batting_team_id': 1,
        'bowling_team_id': 2,
        'runs': 150,
        'wickets': 5,
        'overs': 20,
        'balls': 120,
      });

      expect(innings.num, equals(1));
      expect(innings.matchId, equals(1));
      expect(innings.battingTeamId, equals(1));
      expect(innings.bowlingTeamId, equals(2));
      expect(innings.runs, equals(150));
      expect(innings.wickets, equals(5));
      expect(innings.overs, equals(20));
      expect(innings.balls, equals(120));
    });

    test('converts Innings to JSON', () {
      final innings = Innings(
        num: 1,
        matchId: 1,
        battingTeamId: 1,
        bowlingTeamId: 2,
        runs: 150,
        wickets: 5,
        overs: 20,
        balls: 120,
      );

      final json = innings.toJson();
      expect(json['num'], equals(1));
      expect(json['match_id'], equals(1));
      expect(json['batting_team'], equals(1));
      expect(json['bowling_team'], equals(2));
      expect(json['runs'], equals(150));
      expect(json['wickets'], equals(5));
      expect(json['overs'], equals(20));
      expect(json['balls'], equals(120));
    });
  });

  group('Venue', () {
    test('creates Venue from JSON', () {
      final venue = Venue.fromJson({
        'vid': 1,
        'name': 'Test Stadium',
        'city': 'Test City',
        'country': 'Test Country',
      });

      expect(venue.id, equals(1));
      expect(venue.name, equals('Test Stadium'));
      expect(venue.city, equals('Test City'));
      expect(venue.country, equals('Test Country'));
    });

    test('converts Venue to JSON', () {
      final venue = Venue(
        id: 1,
        name: 'Test Stadium',
        city: 'Test City',
        country: 'Test Country',
      );

      final json = venue.toJson();
      expect(json['id'], equals(1));
      expect(json['name'], equals('Test Stadium'));
      expect(json['city'], equals('Test City'));
      expect(json['country'], equals('Test Country'));
    });
  });

  group('Matches', () {
    test('creates Matches with required fields', () {
      final team = Team(
        id: 1,
        name: 'Test Team',
        players: {},
        abbreviation: 'TT',
      );

      final matches = Matches(
        mid: 1,
        teams: {1: team},
        startTime: '2024-03-15T10:00:00Z',
        endTime: '2024-03-15T14:00:00Z',
        status: 1,
        tournament: 'Test Tournament',
        tournamentAbbr: 'TT',
      );

      expect(matches.mid, equals(1));
      expect(matches.teams.length, equals(1));
      expect(matches.startTime, equals('2024-03-15T10:00:00Z'));
      expect(matches.endTime, equals('2024-03-15T14:00:00Z'));
      expect(matches.status, equals(1));
      expect(matches.tournament, equals('Test Tournament'));
      expect(matches.tournamentAbbr, equals('TT'));
    });

    test('creates Matches from JSON', () {
      final matches = Matches.fromJson({
        'mid': 1,
        'name': 'Test Match',
        'short_name': 'TM',
        'subtitle': 'Test',
        'start_time': '2024-03-15T10:00:00Z',
        'end_time': '2024-03-15T14:00:00Z',
        'num_instruments': 1,
        'match_type': 1,
        'winner_id': 1,
        'toss': 1,
        'innings_no': 1,
        'status': 1,
        'game_state': 0,
        'equation': '',
        'result': '',
        'win_margin': '',
        'tournament': 'Test Tournament',
        'tournamentabbr': 'TT',
        'playing_xi_populated': false,
        'venue': {
          'vid': 1,
          'name': 'Test Stadium',
          'city': 'Test City',
          'country': 'Test Country',
        },
        'teams': [
          {
            'id': 1,
            'name': 'Test Team',
            'players': [],
            'logo': 'test_logo.png',
            'abbreviation': 'TT',
          }
        ],
        'total_volume': 100,
        'total_volume_str': '100',
        'priority': 3,
      });

      expect(matches.mid, equals(1));
      expect(matches.name, equals('Test Match'));
      expect(matches.shortName, equals('TM'));
      expect(matches.subtitle, equals('Test'));
      expect(matches.startTime, equals('2024-03-15T10:00:00Z'));
      expect(matches.endTime, equals('2024-03-15T14:00:00Z'));
      expect(matches.numInstruments, equals(1));
      expect(matches.matchType, equals(1));
      expect(matches.winnerId, equals(1));
      expect(matches.toss, equals(1));
      expect(matches.inningsNo, equals(1));
      expect(matches.status, equals(1));
      expect(matches.gameState, equals(0));
      expect(matches.tournament, equals('Test Tournament'));
      expect(matches.tournamentAbbr, equals('TT'));
      expect(matches.totalVolume, equals(100));
      expect(matches.totalVolumeStr, equals('100'));
      expect(matches.priority, equals(3));
    });

    test('converts Matches to JSON', () {
      final team = Team(
        id: 1,
        name: 'Test Team',
        players: {},
        abbreviation: 'TT',
      );

      final matches = Matches(
        mid: 1,
        teams: {1: team},
        startTime: '2024-03-15T10:00:00Z',
        endTime: '2024-03-15T14:00:00Z',
        status: 1,
        tournament: 'Test Tournament',
        tournamentAbbr: 'TT',
      );

      final json = matches.toJson();
      expect(json['mid'], equals(1));
      expect(json['start_time'], equals('2024-03-15T10:00:00Z'));
      expect(json['end_time'], equals('2024-03-15T14:00:00Z'));
      expect(json['status'], equals(1));
      expect(json['tournament'], equals('Test Tournament'));
    });
  });

  group('MatchListModel', () {
    test('creates MatchListModel with default values', () {
      final model = MatchListModel();
      expect(model.matches, isEmpty);
      expect(model.matchesMap, isEmpty);
      expect(model.tournamentSquads, isEmpty);
    });

    test('creates MatchListModel with provided values', () {
      final team = Team(
        id: 1,
        name: 'Test Team',
        players: {},
        abbreviation: 'TT',
      );

      final match = Matches(
        mid: 1,
        teams: {1: team},
        startTime: '2024-03-15T10:00:00Z',
        endTime: '2024-03-15T14:00:00Z',
        status: 1,
        tournament: 'Test Tournament',
        tournamentAbbr: 'TT',
      );

      final model = MatchListModel(
        matches: [match],
        matchesMap: {1: match},
        tournamentSquads: {},
      );

      expect(model.matches.length, equals(1));
      expect(model.matchesMap.length, equals(1));
      expect(model.tournamentSquads, isEmpty);
    });

    test('updates match in MatchListModel', () {
      final model = MatchListModel();
      model.updateMatch({
        'mid': 1,
        'name': 'Test Match',
        'short_name': 'TM',
        'subtitle': 'Test',
        'start_time': '2024-03-15T10:00:00Z',
        'end_time': '2024-03-15T14:00:00Z',
        'num_instruments': 1,
        'match_type': 1,
        'winner_id': 1,
        'toss': 1,
        'innings_no': 1,
        'status': 1,
        'game_state': 0,
        'equation': '',
        'result': '',
        'win_margin': '',
        'tournament': 'Test Tournament',
        'tournamentabbr': 'TT',
        'playing_xi_populated': false,
        'teams': [],
        'total_volume': 100,
        'total_volume_str': '100',
        'priority': 3,
      });

      expect(model.matchesMap.length, equals(1));
      expect(model.matchesMap[1]?.mid, equals(1));
      expect(model.matchesMap[1]?.name, equals('Test Match'));
    });

    test('updates tournament squads in MatchListModel', () {
      final model = MatchListModel();
      model.updateTournamentSquads([
        {
          'sid': 1,
          'name': 'Test Squad',
          'logo': 'test_logo.png',
          'abbreviation': 'TS',
        }
      ]);

      expect(model.tournamentSquads.length, equals(1));
      expect(model.tournamentSquads[1]?.name, equals('Test Squad'));
      expect(model.tournamentSquads[1]?.logo, equals('test_logo.png'));
      expect(model.tournamentSquads[1]?.abbreviation, equals('TS'));
    });
  });
}
