import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../res/app_text_style.dart'; // You can remove this if using GoogleFonts directly.
import '../../../res/color.dart';

class MyTeamsCard extends StatelessWidget {
  final String teamName;
  final String captain;
  final String viceCaptain;
  final Map<String, int> roleStats; // e.g. {'WK':1, 'BAT':2, 'AR':5, 'BOWL':3}

  const MyTeamsCard({
    super.key,
    required this.teamName,
    required this.captain,
    required this.viceCaptain,
    required this.roleStats,
  });

  // Helper to build the player image with badge.
  Widget _buildPlayerImage(String badgeText,
      {required double size,
      required Color badgeColor,
      required Color badgeTextColor}) {
    return Container(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/cricket-player.png',
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          ),
          // Positioned badge
          Positioned(
            right: -4,
            bottom: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Text(
                badgeText,
                style: GoogleFonts.lato(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: badgeTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _cleanTeamName(String name) {
    // Remove any occurrence of " (Team X)" using regular expression.
    return name.replaceAll(RegExp(r'\s*\(Team\s*\d+\)'), '');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imageSize = width * 0.15;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [
              Color(0xffe0f7fa),
              Color.fromARGB(255, 72, 133, 190),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          image: const DecorationImage(
            image: AssetImage('assets/ground.png'),
            fit: BoxFit.cover,
            opacity: 0.05,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with team name.
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Text(
                _cleanTeamName(teamName),
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const Divider(height: 1, color: Colors.black26),
            // Captain and Vice-Captain Section.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Captain Block.
                  Column(
                    children: [
                      Text(
                        'CAP',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildPlayerImage("C",
                          size: imageSize,
                          badgeColor: AppColors.primaryColor,
                          badgeTextColor: Colors.white),
                      const SizedBox(height: 8),
                      Text(
                        captain,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  // Vice-Captain Block.
                  Column(
                    children: [
                      Text(
                        'VC',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildPlayerImage("VC",
                          size: imageSize,
                          badgeColor: Colors.black87,
                          badgeTextColor: Colors.white),
                      const SizedBox(height: 8),
                      Text(
                        viceCaptain,
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Role Stats Section.
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['WK', 'BAT', 'AR', 'BOWL'].map((role) {
                  return Column(
                    children: [
                      Text(
                        role,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${roleStats[role] ?? 0}',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}