import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teamx/view/Fantasy/contest_details.dart';

import '../../../res/app_text_style.dart';
import '../../../res/color.dart';
import '../match_fantsay_page.dart';

class AllContestCrad extends StatelessWidget {
  final int prize;
  final int entry;
  final int totalSpots;
  final int filledSpots;
  final bool isFree;
  const AllContestCrad({
    super.key, required this.prize, required this.entry, required this.totalSpots, required this.filledSpots, required this.isFree,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) =>
                    ContestDetailsScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xffd4dffc),
                Color(0xbff0f3fe),
                Color(0x80f0f3fe),
                Color(0xfff0f3fe),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
          color: Color(0xfff8f8fe),
          borderRadius: BorderRadius.circular(10),
          border:
          Border.all(width: 1.5, color: Colors.white),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 2,
                blurRadius: 20)
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 8, left: 14, right: 14),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Max Prize Pool",
                          style: AppTextStyles.primaryStyle(
                              14.0,
                              Colors.black54,
                              FontWeight.w500)),
                      Spacer(),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Entry:   ',
                          style: AppTextStyles.primaryStyle(
                              14.0,
                              Colors.black54,
                              FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: "\$${entry}",
                              style: GoogleFonts.poppins(
                                  color: Colors.green,
                                  decoration: isFree ? TextDecoration
                                      .lineThrough : TextDecoration.none,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      Text("\$25,200",
                          style:
                          AppTextStyles.terniaryStyle(
                              22.0,
                              Colors.black,
                              FontWeight.w700)),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MatchFantasyPage()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 2, horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius:
                            BorderRadius.circular(4),
                          ),
                          child: Text(
                            isFree ? "FREE" : "\$${entry}",
                            style:
                            AppTextStyles.terniaryStyle(
                                18,
                                Colors.white,
                                FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                  spotsFillBar(width),
                  Row(
                    children: [
                      Text("850 spots left",
                          style: AppTextStyles.primaryStyle(
                              14.0,
                              Color(0x80191d88),
                              FontWeight.w500)),
                      Spacer(),
                      Text("2500 spots",
                          style: AppTextStyles.primaryStyle(
                              14.0,
                              Colors.black54,
                              FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: 4, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                border: Border(
                  top: BorderSide(
                      width: 0.5, color: Colors.white),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        )),
                    child: Icon(
                      Icons.wine_bar_outlined,
                      color: Colors.black54,
                      size: 11,
                    ),
                  ),
                  Text("  45%",
                      style: AppTextStyles.primaryStyle(
                          12.0,
                          Colors.black54,
                          FontWeight.w500)),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black54,
                            width: 1,
                          )),
                      child: Text("M",
                          style: AppTextStyles.primaryStyle(
                              11.0,
                              Colors.black54,
                              FontWeight.w500))),
                  Text("  Upto 11",
                      style: AppTextStyles.primaryStyle(
                          12.0,
                          Colors.black54,
                          FontWeight.w500)),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        )),
                    child: Icon(
                      Icons.currency_rupee,
                      color: Colors.black54,
                      size: 11,
                    ),
                  ),
                  Text("  Flexible",
                    style: AppTextStyles.primaryStyle(
                      12.0,
                      Colors.black54,
                      FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container spotsFillBar(double width) {
    return Container(
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
            width: width / 2,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 5,
          )
        ],
      ),
    );
  }

}