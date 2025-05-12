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

  String? selectedCaptain;
  String? selectedViceCaptain;

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
      return role == 'allrounder' || role == 'all-rounder' || role.contains('all');
    }).toList();
    bowlers = widget.selectedPlayers.where((p) {
      final role = (p['role']?.toLowerCase() ?? '');
      return role == 'bowler' || role == 'bowl';
    }).toList();
  }

  void _createTeam() {
    print('Team Players:');
    print(widget.selectedPlayers);
    print('Selected Captain: $selectedCaptain');
    print('Selected Vice Captain: $selectedViceCaptain');
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
          Positioned.fill(
            child: Image.asset(
              'assets/ground.jpg',
              fit: BoxFit.cover,
            ),
          ),
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
                      children: [
                        _roleSection('WICKET KEEPERS', wicketkeeper),
                        _roleSection('BATSMAN', batsmen),
                        _roleSection('ALL ROUNDERS', allRounders),
                        _roleSection('BOWLERS', bowlers),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _createTeam,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff191D88),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          ),
                          child: Text("Create Team",
                              style: AppTextStyles.primaryStyle(16, AppColors.white, FontWeight.w600)),
                        ),
                        const SizedBox(height: 20),
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
            children: players.map((p) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SelectablePlayerIcon(
                  player: p,
                  isCaptain: selectedCaptain == p['name'],
                  isVice: selectedViceCaptain == p['name'],
                  onCaptainTap: () {
                    setState(() {
                      selectedCaptain = p['name'];
                    });
                  },
                  onViceTap: () {
                    setState(() {
                      selectedViceCaptain = p['name'];
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class SelectablePlayerIcon extends StatelessWidget {
  final Map<String, dynamic> player;
  final bool isCaptain;
  final bool isVice;
  final VoidCallback onCaptainTap;
  final VoidCallback onViceTap;

  const SelectablePlayerIcon({
    Key? key,
    required this.player,
    required this.isCaptain,
    required this.isVice,
    required this.onCaptainTap,
    required this.onViceTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          child: Text(
            player['name'] ?? '',
            style: AppTextStyles.primaryStyle(12, Colors.white, FontWeight.w600),
          ),
        ),
        Text('${player['credit'] ?? ''} Cr',
            style: AppTextStyles.primaryStyle(14, Colors.white, FontWeight.w600)),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onCaptainTap,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isCaptain ? Colors.orange : Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Text("C", style: AppTextStyles.terniaryStyle(12, Colors.white, FontWeight.w600)),
              ),
            ),
            GestureDetector(
              onTap: onViceTap,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isVice ? Colors.orange : Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Text("VC", style: AppTextStyles.terniaryStyle(10, Colors.white, FontWeight.w600)),
              ),
            ),
          ],
        )
      ],
    );
  }
}