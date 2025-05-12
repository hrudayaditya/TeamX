import 'package:flutter/material.dart';
import '../../../res/app_text_style.dart';
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
                style: AppTextStyles.terniaryStyle(10, badgeTextColor, FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imageSize = width * 0.18;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [
              Color(0xffd4dffc),
              Color(0xbff0f3fe),
              Color(0x80f0f3fe),
              Color(0xfff0f3fe),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          image: const DecorationImage(
            image: AssetImage('assets/ground_lines.png'),
            fit: BoxFit.cover,
            opacity: 0.05,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with Team Name and Edit Icon
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      teamName,
                      style: AppTextStyles.terniaryStyle(18, Colors.black87, FontWeight.bold),
                    ),
                  ),
                  // Icon(
                  //   Icons.mode_edit,
                  //   color: AppColors.primaryColor,
                  //   size: 22,
                  // ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.black26),
            // Captain and ViceCaptain Section (Image above the player's name)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Captain Block
                  Column(
                    children: [
                      Text(
                        'CAP',
                        style: AppTextStyles.terniaryStyle(14, Colors.black54, FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      _buildPlayerImage("C", size: imageSize, badgeColor: AppColors.primaryColor, badgeTextColor: Colors.white),
                      const SizedBox(height: 4),
                      Text(
                        captain,
                        style: AppTextStyles.terniaryStyle(16, Colors.black, FontWeight.w700),
                      ),
                    ],
                  ),
                  // Vice-Captain Block
                  Column(
                    children: [
                      Text(
                        'VC',
                        style: AppTextStyles.terniaryStyle(14, Colors.black54, FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      _buildPlayerImage("VC", size: imageSize, badgeColor: Colors.black87, badgeTextColor: Colors.white),
                      const SizedBox(height: 4),
                      Text(
                        viceCaptain,
                        style: AppTextStyles.terniaryStyle(16, Colors.black, FontWeight.w700),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Role Stats Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['WK', 'BAT', 'AR', 'BOWL'].map((role) {
                  return Column(
                    children: [
                      Text(
                        role,
                        style: AppTextStyles.primaryStyle(14, Colors.black54, FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${roleStats[role] ?? 0}',
                        style: AppTextStyles.terniaryStyle(16, Colors.black, FontWeight.w600),
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