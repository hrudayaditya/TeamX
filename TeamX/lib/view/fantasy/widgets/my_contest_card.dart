import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../res/app_text_style.dart';
import '../../../res/color.dart';
import '../match_fantsay_page.dart';

class MyContestCard extends StatelessWidget {
  final String id; // Contest ID
  final int prize;
  final int entry;
  final int totalSpots;
  final int filledSpots;
  final List<Map<String, String>> teams;
  final bool isFinished;
  final Map<String, dynamic> contest; // Full contest details

  MyContestCard({
    super.key,
    required this.id,
    required this.prize,
    required this.entry,
    required this.totalSpots,
    required this.filledSpots,
    required this.teams,
    required this.isFinished,
    required this.contest,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffd4dffc),
            Color(0xbff0f3fe),
            Color(0x80f0f3fe),
            Color(0xfff0f3fe),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        color: Color(0xfff8f8fe),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1.5, color: Colors.white),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 20)
        ],
      ),
      child: Column(
        children: [
          // Contest summary info
          Padding(
            padding: EdgeInsets.only(top: 8, left: 14, right: 14),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Max Prize Pool",
                        style: AppTextStyles.primaryStyle(
                            14.0, Colors.black54, FontWeight.w500)),
                    Spacer(),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Entered',
                        style: AppTextStyles.primaryStyle(
                            14.0, Colors.black54, FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: '',
                            style: GoogleFonts.poppins(
                                color: Colors.green,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  children: [
                    Text("\$${prize}",
                        style: AppTextStyles.terniaryStyle(
                            22.0, Colors.black, FontWeight.w700)),
                    Spacer(),
                    // Navigate to MatchFantasyPage with full contest details.
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MatchFantasyPage(
                            contestId: id,
                            contest: contest,
                          ),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          entry == 0 ? "FREE" : "\$${entry}",
                          style: AppTextStyles.terniaryStyle(
                              18, Colors.white, FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
                !isFinished
                    ? spotsFillBar(width, filledSpots, totalSpots)
                    : Column(
                        children: [
                          Text('Spots',
                              style: AppTextStyles.terniaryStyle(
                                  10, Colors.black54, FontWeight.w500)),
                          Text('${totalSpots}',
                              style: AppTextStyles.terniaryStyle(
                                  12, Colors.black87, FontWeight.w500)),
                        ],
                      ),
              ],
            ),
          ),
          SizedBox(height: 8),
          // Details row
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white70,
              border: Border(top: BorderSide(width: 0.5, color: Colors.white)),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black54, width: 1),
                  ),
                  child: Icon(Icons.wine_bar_outlined, color: Colors.black54, size: 11),
                ),
                // Text("  45%",
                //     style: AppTextStyles.primaryStyle(12.0, Colors.black54, FontWeight.w500)),
                // SizedBox(width: 10),
                // Container(
                //   padding: EdgeInsets.all(1),
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     border: Border.all(color: Colors.black54, width: 1),
                //   ),
                //   child: Text("M",
                //       style: AppTextStyles.primaryStyle(11.0, Colors.black54, FontWeight.w500)),
                // ),
                // Text("  Upto 11",
                //     style: AppTextStyles.primaryStyle(12.0, Colors.black54, FontWeight.w500)),
                // Spacer(),
                // Container(
                //   padding: EdgeInsets.all(1),
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     border: Border.all(color: Colors.black54, width: 1),
                //   ),
                //   child: Icon(Icons.currency_rupee, color: Colors.black54, size: 11),
                // ),
                // Text("  Flexible",
                //     style: AppTextStyles.primaryStyle(12.0, Colors.black54, FontWeight.w500)),
              ],
            ),
          ),
          // Teams expansion tile
          !isFinished
              ? ExpansionTile(
                  shape: Border.all(width: 0, color: Colors.transparent),
                  collapsedShape: Border.all(width: 0, color: Colors.transparent),
                  iconColor: Colors.black,
                  collapsedIconColor: Colors.black,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Joined with ${teams.length} Team(s)",
                          style: AppTextStyles.terniaryStyle(14, Colors.black87, FontWeight.w500)),
                      SizedBox(height: 4),
                      Container(
                        height: 23,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: teams.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text(
                                "T${index + 1}",
                                style: AppTextStyles.terniaryStyle(14, Colors.white, FontWeight.w600),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: teams.length,
                      itemBuilder: (context, index) {
                        return myContestCardTeamTile(
                          index,
                          teams[index]['captain']!,
                          teams[index]['viceCaptain']!,
                        );
                      },
                    ),
                    SizedBox(height: 10),
                  ],
                )
              : SizedBox(),
          // Footer row
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('PLAYER_ID',
                        style: AppTextStyles.terniaryStyle(14, AppColors.primaryColor, FontWeight.w600)),
                    Text('You Won \$30',
                        style: AppTextStyles.terniaryStyle(14, AppColors.green, FontWeight.w600)),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text("T1",
                      style: AppTextStyles.terniaryStyle(14, Colors.white, FontWeight.w600)),
                ),
                // Text("456.5",
                //     style: AppTextStyles.terniaryStyle(10, Colors.black54, FontWeight.w600)),
                // Text('#44', style: AppTextStyles.terniaryStyle(14, AppColors.black, FontWeight.w600)),
              ],
            ),
          ),
          // !isFinished
          //     ? Container(
          //         margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          //         height: 40,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(12),
          //             border: Border.all(color: AppColors.primaryColor, width: 1)),
          //         alignment: Alignment.center,
          //         child: Text(
          //           'Add a new Team',
          //           style: AppTextStyles.terniaryStyle(14, AppColors.primaryColor, FontWeight.w600),
          //         ),
          //       )
          //     : SizedBox(),
        ],
      ),
    );
  }

  Container myContestCardTeamTile(int index, String captain, String viceCaptain) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.7),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("Team ${index + 1}",
                  style: AppTextStyles.terniaryStyle(14, Colors.black, FontWeight.w600)),
              Spacer(),
              // Icon(Icons.edit_rounded, size: 18, color: Colors.black),
            ],
          ),
          Row(
            children: [
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: 'Captain ',
                  style: AppTextStyles.primaryStyle(14.0, Colors.black54, FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(
                      text: '\n${captain}',
                      style: AppTextStyles.terniaryStyle(16, Colors.black, FontWeight.w600),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 18),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: 'Vice Captain ',
                  style: AppTextStyles.primaryStyle(14.0, Colors.black54, FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(
                      text: '\n${viceCaptain}',
                      style: AppTextStyles.terniaryStyle(16, Colors.black, FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget spotsFillBar(double width, int filled, int totalSpots) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          width: width - 35,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
          ),
          height: 5,
          child: Stack(
            children: [
              Container(
                width: (width / 100) * (filled / totalSpots) * 100,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 5,
              )
            ],
          ),
        ),
        Row(
          children: [
            Text("${filled} spots left",
                style: AppTextStyles.primaryStyle(14.0, Color(0x80191d88), FontWeight.w500)),
            Spacer(),
            Text("${totalSpots} spots",
                style: AppTextStyles.primaryStyle(14.0, Colors.black54, FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}