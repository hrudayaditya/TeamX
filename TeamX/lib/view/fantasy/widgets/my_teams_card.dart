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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color(0xffd4dffc),
                Color(0xbff0f3fe),
                Color(0x80f0f3fe),
                Color(0xfff0f3fe),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            color: const Color(0xfff8f8fe),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2.5, color: Colors.white),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 2,
                  blurRadius: 20)
            ],
            image: const DecorationImage(
              image: AssetImage('assets/ground_lines.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  border: const Border(
                    bottom: BorderSide(width: 0.5, color: Colors.white),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      teamName,
                      style: AppTextStyles.terniaryStyle(16, Colors.white, FontWeight.w700),
                    ),
                    const Icon(
                      Icons.mode_edit,
                      color: Colors.white,
                      size: 22,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 14, right: 14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'CAP',
                              style: AppTextStyles.terniaryStyle(16, Colors.white, FontWeight.w600),
                            ),
                            Text(
                              captain,
                              style: AppTextStyles.terniaryStyle(18, Colors.white, FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(width: 25),
                        Column(
                          children: [
                            Text(
                              'VC',
                              style: AppTextStyles.terniaryStyle(16, Colors.white, FontWeight.w600),
                            ),
                            Text(
                              viceCaptain,
                              style: AppTextStyles.terniaryStyle(18, Colors.white, FontWeight.w600),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          width: width * 0.2,
                          height: 70,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/cricket-player.png',
                                  height: 50,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    'C',
                                    style: AppTextStyles.terniaryStyle(7, Colors.white, FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: width * 0.2,
                          height: 70,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/cricket-player.png',
                                  height: 50,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    'VC',
                                    style: AppTextStyles.terniaryStyle(7, Colors.black, FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  border: const Border(
                    top: BorderSide(width: 0.5, color: Colors.white),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var role in ['WK', 'BAT', 'AR', 'BOWL'])
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "$role  ",
                          style: AppTextStyles.primaryStyle(16.0, Colors.black54, FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${roleStats[role] ?? 0}',
                              style: AppTextStyles.terniaryStyle(16, Colors.white, FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}