import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/model/match_model.dart';

void main() {
  test('MatchListModel and related classes', () {
    // Squad
    final squad = Squad.fromJson({
      'sid': 1,
      'name': 'Squad',
      'logo': 'logo.png',
      'abbreviation': 'SQD',
    });
    squad.toJson();

    // Player
    final player = Player.fromJson({
      'id': 1,
      'name': 'Player',
      'matchId': 1,
      'runs': 10,
      'balls': 5,
      'fours': 1,
      'sixes': 1,
      'overs_completed': 0,
      'balls_bowled': 0,
      'runs_conceded': 0,
      'wickets': 0,
      'playing': true,
      'how_out': '',
      'batting_pos': 1,
    });
    player.toJson();

    // Team
    final team = Team.fromJson({
      'id': 1,
      'name': 'Team',
      'players': [
        {
          'id': 1,
          'name': 'Player',
          'matchId': 1,
        }
      ],
      'logo': 'logo.png',
      'abbreviation': 'TM',
    });
    team.toJson();

    // Innings
    final innings = Innings.fromJson({
      'num': 1,
      'match': 1,
      'batting_team_id': 1,
      'bowling_team_id': 1,
      'runs': 100,
      'wickets': 2,
      'overs': 10,
      'balls': 60,
    });
    innings.toJson();

    // Venue
    final venue = Venue.fromJson({
      'vid': 1,
      'name': 'Stadium',
      'city': 'City',
      'country': 'Country',
    });
    venue.toJson();

    // Matches
    final matches = Matches(
      mid: 1,
      teams: {1: team},
      inningsNo: 1,
      status: 1,
      gameState: 0,
      tournament: '',
      tournamentAbbr: '',
      startTime: DateTime.now().toIso8601String(),
      endTime: DateTime.now().toIso8601String(),
      shortName: 'A vs B',
      subtitle: 'Test',
      numInstruments: 1,
      isPlayingXIPopulated: false,
      totalVolume: 0,
    );
    matches.getBattingTeam();
    matches.getBowlingTeam();
    matches.getBattingFirstTeam();
    matches.getBowlingFirstTeam();
    matches.getStriker();
    matches.getNonStriker();
    matches.getBowler();
    matches.getBatsman(1);
    matches.getBowlerFromPid(1);
    matches.updateBatsmanDetails({'id': 1, 'runs': 10, 'balls': 5, 'fours': 1, 'sixes': 1});
    matches.updateBowlerDetails({'id': 1, 'runs_conceded': 10, 'balls': 5, 'overs': 1, 'wickets': 1});
    matches.toJson();

    // MatchListModel
    final model = MatchListModel(matches: [matches]);
    model.toJson();
    model.updateMatch({
      'mid': 2,
      'name': 'Match2',
      'short_name': 'A vs B',
      'subtitle': 'Test',
      'start_time': DateTime.now().toIso8601String(),
      'end_time': DateTime.now().toIso8601String(),
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
      'tournament': '',
      'tournamentabbr': '',
      'playing_xi_populated': false,
      'venue': {
        'vid': 1,
        'name': 'Stadium',
        'city': 'City',
        'country': 'Country',
      },
      'innings1': null,
      'innings2': null,
      'strikerId': 1,
      'nonStrikerId': 1,
      'bowlerId': 1,
      'teams': [
        {
          'id': 1,
          'name': 'Team',
          'players': [
            {
              'id': 1,
              'name': 'Player',
              'matchId': 1,
            }
          ],
          'logo': 'logo.png',
          'abbreviation': 'TM',
        }
      ],
      'total_volume': 0,
      'total_volume_str': '0',
      'priority': 3,
    });
    model.updateTournamentSquads([
      {
        'sid': 1,
        'name': 'Squad',
        'logo': 'logo.png',
        'abbreviation': 'SQD',
      }
    ]);
  });
}