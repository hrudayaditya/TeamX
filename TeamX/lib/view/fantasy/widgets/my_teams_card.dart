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
            right: -3,
            bottom: -3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1.2),
              ),
              child: Text(
                badgeText,
                style: GoogleFonts.lato(
                  fontSize: 8,
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
    double imageSize = width * 0.12; // Reduced image size
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [
              Color(0xffe0f7fa),
              Color.fromARGB(255, 72, 133, 190),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          image: const DecorationImage(
            image: AssetImage('assets/ground.jpg'),
            fit: BoxFit.cover,
            opacity: 0.05,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with team name.
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Text(
                _cleanTeamName(teamName),
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const Divider(height: 1, color: Colors.black26),
            // Captain and Vice-Captain Section.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Captain Block.
                  Column(
                    children: [
                      Text(
                        'CAP',
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _buildPlayerImage("C",
                          size: imageSize,
                          badgeColor: AppColors.primaryColor,
                          badgeTextColor: Colors.white),
                      const SizedBox(height: 6),
                      Text(
                        captain,
                        style: GoogleFonts.lato(
                          fontSize: 14,
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
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 6),
                      _buildPlayerImage("VC",
                          size: imageSize,
                          badgeColor: Colors.black87,
                          badgeTextColor: Colors.white),
                      const SizedBox(height: 6),
                      Text(
                        viceCaptain,
                        style: GoogleFonts.lato(
                          fontSize: 14,
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['WK', 'BAT', 'AR', 'BOWL'].map((role) {
                  return Column(
                    children: [
                      Text(
                        role,
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${roleStats[role] ?? 0}',
                        style: GoogleFonts.lato(
                          fontSize: 16,
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
