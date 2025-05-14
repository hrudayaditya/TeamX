import 'package:flutter_test/flutter_test.dart';
import 'package:teamx/model/match_model.dart';

void main() {
  test('MatchListModel methods', () {
    final model = MatchListModel();
    model.matches = [];
    model.matchesMap = {};
    model.tournamentSquads = {};
    model.toJson();
    model.updateMatch({
      'mid': 1,
      'name': 'Test Match',
      'short_name': 'TM',
      'subtitle': 'Test',
      'status': 1,
      'priority': 1,
      'start_time': '2025-05-13T12:00:00Z',
      'total_volume': 100,
      'total_volume_str': '100',
      'teams': [],
      'match_type': 1,
      'innings_no': 1,
      'game_state': 0,
      'tournament': 'Test Tournament',
      'tournamentabbr': 'TT',
      'playing_xi_populated': false,
      'strikerId': 1,
      'nonStrikerId': 2,
      'bowlerId': 3,
      'num_instruments': 0,
      'venue': null,
      'innings1': null,
      'innings2': null,
    });
    model.updateTournamentSquads([
      {
        'sid': 1,
        'name': 'Test Squad',
        'logo': 'test_logo.png',
        'abbreviation': 'TS',
        'players': [
          {'id': 1, 'name': 'Player 1'},
          {'id': 2, 'name': 'Player 2'}
        ]
      }
    ]);
  });
}
