import 'package:flutter/material.dart';
import '../../../res/app_text_style.dart';
import '../../../res/color.dart';

class TeamAndPlayerInfo extends StatelessWidget {
  final List<dynamic> teamInfo; // from contestDetails['teamInfo']
  final int selectedPlayersCount;
  final int maxPlayers;
  final int team1Count;
  final int team2Count;
  final double creditsLeft;

  const TeamAndPlayerInfo({
    super.key,
    required this.teamInfo,
    required this.selectedPlayersCount,
    required this.maxPlayers,
    required this.team1Count,
    required this.team2Count,
    required this.creditsLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
      height: 42.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Players count
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Players',
                style: AppTextStyles.primaryStyle(
                  13.0,
                  Colors.white70,
                  FontWeight.w600,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$selectedPlayersCount',
                    style: AppTextStyles.terniaryStyle(
                      16.0,
                      AppColors.white,
                      FontWeight.w700,
                    ),
                  ),
                  Text(
                    '/$maxPlayers',
                    style: AppTextStyles.terniaryStyle(
                      16.0,
                      Colors.white54,
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Team 1 info
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (teamInfo.isNotEmpty)
                Image.network(
                  teamInfo[0]['img'] ?? '',
                  height: 36,
                  errorBuilder: (_, __, ___) => const Icon(Icons.sports_cricket, color: Colors.white),
                ),
              const SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    teamInfo.isNotEmpty ? (teamInfo[0]['shortname'] ?? '') : '',
                    style: AppTextStyles.primaryStyle(
                      13.0,
                      Colors.white70,
                      FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$team1Count',
                    style: AppTextStyles.terniaryStyle(
                      16.0,
                      AppColors.white,
                      FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Separator
          Text(
            ':',
            style: AppTextStyles.primaryStyle(
              27.5,
              Colors.white,
              FontWeight.w600,
            ),
          ),
          // Team 2 info
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    teamInfo.length > 1 ? (teamInfo[1]['shortname'] ?? '') : '',
                    style: AppTextStyles.primaryStyle(
                      13.0,
                      Colors.white70,
                      FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$team2Count',
                    style: AppTextStyles.terniaryStyle(
                      16.0,
                      AppColors.white,
                      FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              if (teamInfo.length > 1)
                Image.network(
                  teamInfo[1]['img'] ?? '',
                  height: 36,
                  errorBuilder: (_, __, ___) => const Icon(Icons.sports_cricket, color: Colors.white),
                ),
            ],
          ),
          // Credits left
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Credit Left',
                style: AppTextStyles.primaryStyle(
                  13.0,
                  Colors.white70,
                  FontWeight.w600,
                ),
              ),
              Text(
                creditsLeft.toStringAsFixed(1),
                style: AppTextStyles.terniaryStyle(
                  16.0,
                  AppColors.white,
                  FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}