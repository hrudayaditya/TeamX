import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:teamx/view/Fantasy/widgets/team_and_player_info.dart';
import 'package:http/http.dart' as http;
import '../../res/app_text_style.dart';
import '../../res/color.dart';
import '../../res/app_url.dart';
import '../../utils/utils.dart';

class TeamPreview extends StatefulWidget {
  final List<Map<String, dynamic>> selectedPlayers;
  // Accept contest details in the new format
  final Map<String, dynamic> contest;

  const TeamPreview({
    required this.selectedPlayers,
    required this.contest,
    Key? key,
  }) : super(key: key);

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

  Future<bool> _confirmPayment(int amount) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirm Payment"),
            content: Text("This contest costs $amount. Do you want to proceed?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Yes"),
              )
            ],
          ),
        )) ??
        false;
  }

  Future<void> _createTeam() async {
    // Check if both captain and vice captain are selected.
    if (selectedCaptain == null || selectedViceCaptain == null) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Selection Required"),
          content: const Text("Please select both a Captain and a Vice Captain."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    final utils = Utils();
    final email = await utils.fetchDataSecure('email');
    print("Contest Data: ${widget.contest}");
    final contestAmount = widget.contest['entryFee'] ?? 0;
    print("Contest Entry Fee: $contestAmount");

    if (contestAmount > 0) {
      bool confirmed = await _confirmPayment(contestAmount);
      if (!confirmed) return;

      final reduceResponse = await http.post(
        Uri.parse(AppUrl.reduceAmount),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "amount": contestAmount,
        }),
      );

      if (reduceResponse.statusCode < 200 || reduceResponse.statusCode >= 300) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Payment failed. Please try again.")),
        );
        print("Reduce amount failed. Response: ${reduceResponse.body}");
        return;
      } else {
        print("Wallet deducted successfully. Response: ${reduceResponse.body}");
      }
    }

    // Find captain and vice captain objects from the selected players list.
    final captainObject = widget.selectedPlayers.firstWhere(
      (p) => p['name'] == selectedCaptain,
      orElse: () => {},
    );
    final viceCaptainObject = widget.selectedPlayers.firstWhere(
      (p) => p['name'] == selectedViceCaptain,
      orElse: () => {},
    );

    // Prepare team data; saving players as-is with captain and vice captain information.
    final teamData = {
      "userEmail": email,
      "contestId": widget.contest['id'] ?? widget.contest['contestId'],
      "players": widget.selectedPlayers,
      "captain": captainObject,
      "viceCaptain": viceCaptainObject,
    };

    final createResponse = await http.post(
      Uri.parse(AppUrl.createTeam),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(teamData),
    );

    if (createResponse.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Team created successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create team.")),
      );
      print("Failed to create team. TeamData: ${jsonEncode(teamData)}");
      print("Response: ${createResponse.body}");
    }

    print('Contest Details: ${widget.contest}');
    print('Team Players: ${widget.selectedPlayers}');
    print('Selected Captain: $selectedCaptain');
    print('Selected Vice Captain: $selectedViceCaptain');
  }

  @override
  Widget build(BuildContext context) {
    // Display contest details using the new format:
    // For example, show the "name" from the first item in the "data" array.
    String contestName = widget.contest['data'] != null &&
            widget.contest['data'].isNotEmpty &&
            widget.contest['data'][0]['name'] != null
        ? widget.contest['data'][0]['name']
        : 'Contest Details';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 72, 133, 190),
        elevation: 1.0,
        title: Text("Team Preview",
            style: AppTextStyles.primaryStyle(20.0, AppColors.white, FontWeight.w600)),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/ground.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
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
                            onPressed:
                                widget.selectedPlayers.isNotEmpty ? _createTeam : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 72, 133, 190),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                            child: Text("Create Team",
                                style: AppTextStyles.primaryStyle(
                                    16, AppColors.white, FontWeight.w600)),
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
                child: Text("C",
                    style: AppTextStyles.terniaryStyle(12, Colors.white, FontWeight.w600)),
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
                child: Text("VC",
                    style: AppTextStyles.terniaryStyle(10, Colors.white, FontWeight.w600)),
              ),
            ),
          ],
        )
      ],
    );
  }
}