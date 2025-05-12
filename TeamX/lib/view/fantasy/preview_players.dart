import 'package:flutter/material.dart';
import 'package:teamx/view/Fantasy/widgets/team_and_player_info.dart';
import '../../res/app_text_style.dart';
import '../../res/color.dart';

class TeamPreview extends StatefulWidget {
  final List<Map<String, dynamic>> selectedPlayers;

  const TeamPreview({required this.selectedPlayers, Key? key}) : super(key: key);

  @override
  State<TeamPreview> createState() => _TeamPreviewState();
}

class _TeamPreviewState extends State<TeamPreview> {
  late List<Map<String, dynamic>> wicketkeeper;
  late List<Map<String, dynamic>> batsmen;
  late List<Map<String, dynamic>> allRounders;
  late List<Map<String, dynamic>> bowlers;

  @override
  void initState() {
    super.initState();
    wicketkeeper = widget.selectedPlayers.where((p) {
      final role = (p['role']?.toLowerCase() ?? '');
      return role == 'wk' || role.contains('wicket');
    }).toList();
    batsmen = widget.selectedPlayers.where((p) {
      final role = (p['role']?.toLowerCase() ?? '');
      return role == 'batsman' || role == 'bat';
    }).toList();
    allRounders = widget.selectedPlayers.where((p) {
      final role = (p['role']?.toLowerCase() ?? '');
      return role == 'allrounder' ||
          role == 'all-rounder' ||
          role.contains('all');
    }).toList();
    bowlers = widget.selectedPlayers.where((p) {
      final role = (p['role']?.toLowerCase() ?? '');
      return role == 'bowler' || role == 'bowl';
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff191D88),
        elevation: 1.0,
        title: Text("Team Preview",
            style: AppTextStyles.primaryStyle(20.0, AppColors.white, FontWeight.w600)),
      ),
      body: Stack(
        children: [
          // Full screen fixed background image.
          Positioned.fill(
            child: Image.asset(
              'assets/ground.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Overlay content.
          Column(
            children: [
              Container(
                width: double.infinity,
                color: const Color(0xff191D88).withOpacity(0.85),
                child: TeamAndPlayerInfo(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _roleSection('WICKET KEEPERS', wicketkeeper),
                        _roleSection('BATSMAN', batsmen),
                        _roleSection('ALL ROUNDERS', allRounders),
                        _roleSection('BOWLERS', bowlers),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _roleSection(String title, List<Map<String, dynamic>> players) {
    if (players.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(
          title,
          style: AppTextStyles.terniaryStyle(14.0, Colors.white, FontWeight.w600),
        ),
        const SizedBox(height: 4),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: players
                .map((p) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: PlayerIcon(player: p),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class PlayerIcon extends StatelessWidget {
  final Map<String, dynamic> player;

  const PlayerIcon({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipOval(
          child: Image.network(
            player['playerImg'] ?? '',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                Image.asset('assets/cricket-player.png', width: 50, height: 50),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(player['name'] ?? '',
              style: AppTextStyles.primaryStyle(12, Colors.white, FontWeight.w600)),
        ),
        Text('${player['credit'] ?? ''} Cr',
            style: AppTextStyles.primaryStyle(14, Colors.white, FontWeight.w600)),
      ],
    );
  }
}