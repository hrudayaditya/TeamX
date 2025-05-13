import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:teamx/view/fantasy/preview_players.dart';

import '../../res/app_text_style.dart';
import '../../res/color.dart';

class ChooseCaptainAndViceCaptain extends StatefulWidget {
  final List<String> batsmen;
  final List<String> wicketkeeper;
  final List<String> bowlers;
  final List<String> allRounders;

  const ChooseCaptainAndViceCaptain({
    required this.batsmen,
    required this.bowlers,
    required this.allRounders,
    required this.wicketkeeper,
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseCaptainAndViceCaptain> createState() =>
      _ChooseCaptainAndViceCaptainState();
}

class _ChooseCaptainAndViceCaptainState extends State<ChooseCaptainAndViceCaptain> {
  // Lists to track the selection state for VC and C (fixed length 11 for demo).
  late List<bool> _color_vc = List.filled(11, false, growable: false);
  late List<bool> _color_c = List.filled(11, false, growable: false);

  String vc_name = '';
  String c_name = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // Combine the passed string lists into one list for display.
    final List<String> players = widget.wicketkeeper +
        widget.batsmen +
        widget.allRounders +
        widget.bowlers;
    
    return Scaffold(
      backgroundColor: const Color(0xffeef0fc),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: AppBar(
          iconTheme: const IconThemeData(size: 20, color: Colors.white),
          backgroundColor: const Color.fromARGB(255, 72, 133, 190),
          elevation: 1.0,
          title: Text(
            "Create Team",
            style: AppTextStyles.primaryStyle(20.0, AppColors.white, FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        children: [
          // Header with instructions.
          Container(
            width: width,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: const Color(0xffeef0fc),
            child: Column(
              children: [
                Text(
                  "Choose your Captain and Vice Captain",
                  style: AppTextStyles.primaryStyle(17, AppColors.black, FontWeight.w700),
                  maxLines: 2,
                ),
                Text(
                  "C gets 2X points, VC gets 1.5X points",
                  style: AppTextStyles.primaryStyle(14, AppColors.black, FontWeight.w500),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          // Row with labels.
          Container(
            color: Colors.white60,
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                const Spacer(),
                SizedBox(
                  width: width * 0.1,
                  child: Center(
                    child: AutoSizeText(
                      "VC",
                      minFontSize: 10,
                      maxFontSize: 14,
                      style: AppTextStyles.primaryStyle(14, AppColors.black, FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.2,
                  child: Center(
                    child: AutoSizeText(
                      "C",
                      minFontSize: 10,
                      maxFontSize: 14,
                      style: AppTextStyles.primaryStyle(14, AppColors.black, FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          // List of players.
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: const BoxDecoration(
                    color: Color(0xffeef0fc),
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      players[index],
                      style: AppTextStyles.terniaryStyle(16, Colors.black, FontWeight.w500),
                    ),
                    tileColor: Colors.white,
                    leading: Image.asset(
                      'assets/cricket-player.png',
                      height: 32,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Toggle VC selection.
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_color_vc.contains(true)) {
                                if (vc_name == players[index]) {
                                  _color_vc[index] = !_color_vc[index];
                                  vc_name = '';
                                }
                              } else {
                                _color_vc[index] = true;
                                vc_name = players[index];
                              }
                            });
                          },
                          child: SizedBox(
                            width: width * 0.15,
                            child: Center(
                              child: CircleAvatar(
                                backgroundColor: _color_vc[index]
                                    ? AppColors.primaryColor
                                    : Colors.white60,
                                child: Text(
                                  'VC',
                                  style: AppTextStyles.terniaryStyle(
                                      14,
                                      _color_vc[index] ? AppColors.white : Colors.black,
                                      FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Toggle Captain selection.
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_color_c.contains(true)) {
                                if (c_name == players[index]) {
                                  _color_c[index] = !_color_c[index];
                                  c_name = '';
                                }
                              } else {
                                _color_c[index] = true;
                                c_name = players[index];
                              }
                            });
                          },
                          child: SizedBox(
                            width: width * 0.15,
                            child: Center(
                              child: CircleAvatar(
                                backgroundColor: _color_c[index]
                                    ? AppColors.primaryColor
                                    : Colors.white60,
                                child: Text(
                                  'C',
                                  style: AppTextStyles.terniaryStyle(
                                      14,
                                      _color_c[index] ? AppColors.white : Colors.black,
                                      FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // FAB that converts the string lists into player maps and passes only the selected players.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              final List<Map<String, dynamic>> selectedPlayers = [];
              selectedPlayers.addAll(widget.batsmen.map((player) => {
                    'name': player,
                    'role': 'bat',
                    'playerImg': 'assets/cricket-player.png',
                    'credit': 0,
                  }));
              selectedPlayers.addAll(widget.wicketkeeper.map((player) => {
                    'name': player,
                    'role': 'wk',
                    'playerImg': 'assets/cricket-player.png',
                    'credit': 0,
                  }));
              selectedPlayers.addAll(widget.bowlers.map((player) => {
                    'name': player,
                    'role': 'bowl',
                    'playerImg': 'assets/cricket-player.png',
                    'credit': 0,
                  }));
              selectedPlayers.addAll(widget.allRounders.map((player) => {
                    'name': player,
                    'role': 'allrounder',
                    'playerImg': 'assets/cricket-player.png',
                    'credit': 0,
                  }));
              
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TeamPreview(selectedPlayers: selectedPlayers, contest: {},),
              ));
            },
            child: Container(
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color.fromARGB(255, 72, 133, 190),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(0, 5)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 18),
                  Text(
                    " PREVIEW",
                    style: AppTextStyles.primaryStyle(16.0, AppColors.white, FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              // Implement SAVE functionality as needed.
            },
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.green,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(0, 5)),
                ],
              ),
              child: Center(
                child: Text(
                  "SAVE",
                  style: AppTextStyles.primaryStyle(16.0, AppColors.white, FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}