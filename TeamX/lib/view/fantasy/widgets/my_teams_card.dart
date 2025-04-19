import 'package:flutter/material.dart';

import '../../../res/app_text_style.dart';
import '../../../res/color.dart';

class MyTeamsCard extends StatelessWidget {
  const MyTeamsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
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
                  end: Alignment.topCenter),
              color: Color(0xfff8f8fe),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2.5, color: Colors.white),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 20)
              ],
              image: DecorationImage(
                  image: AssetImage('assets/ground_lines.png'),
                  fit: BoxFit.fitWidth)),
          child: Column(
            children: [
              Container(
                padding:
                EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  border: Border(
                    bottom:
                    BorderSide(width: 0.5, color: Colors.white),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ADITYA (T1)',
                      style: AppTextStyles.terniaryStyle(
                          16, Colors.white, FontWeight.w700),
                    ),
                    Icon(
                      Icons.mode_edit,
                      color: Colors.white,
                      size: 22,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, left: 14, right: 14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'IND',
                              style: AppTextStyles.terniaryStyle(
                                  16, Colors.white, FontWeight.w600),
                            ),
                            Text(
                              '4',
                              style: AppTextStyles.terniaryStyle(
                                  18, Colors.white, FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          children: [
                            Text(
                              'PAK',
                              style: AppTextStyles.terniaryStyle(
                                  16, Colors.white, FontWeight.w600),
                            ),
                            Text(
                              '7',
                              style: AppTextStyles.terniaryStyle(
                                  18, Colors.white, FontWeight.w600),
                            ),
                          ],
                        ),
                        Spacer(),
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
                                  padding: EdgeInsets.all(4),
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
                                    style:
                                    AppTextStyles.terniaryStyle(
                                        7,
                                        Colors.white,
                                        FontWeight.w600),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width * 0.2,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius:
                                    BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'A Rossington',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                    AppTextStyles.terniaryStyle(
                                        9,
                                        Colors.white,
                                        FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
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
                                  padding: EdgeInsets.all(4),
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
                                    style:
                                    AppTextStyles.terniaryStyle(
                                        7,
                                        Colors.black,
                                        FontWeight.w600),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: width * 0.2,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius:
                                    BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'S Singh',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                    AppTextStyles.terniaryStyle(
                                        9,
                                        Colors.black,
                                        FontWeight.w600),
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
              SizedBox(
                height: 14,
              ),
              Container(
                padding:
                EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white30,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.white),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'WK  ',
                        style: AppTextStyles.primaryStyle(
                            16.0, Colors.black54, FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: '1',
                            style: AppTextStyles.terniaryStyle(
                                16, Colors.white, FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'BAT  ',
                        style: AppTextStyles.primaryStyle(
                            16.0, Colors.black54, FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: '2',
                            style: AppTextStyles.terniaryStyle(
                                16, Colors.white, FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'AR  ',
                        style: AppTextStyles.primaryStyle(
                            16.0, Colors.black54, FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: '5',
                            style: AppTextStyles.terniaryStyle(
                                16, Colors.white, FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'BOWL  ',
                        style: AppTextStyles.primaryStyle(
                            16.0, Colors.black54, FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: '3',
                            style: AppTextStyles.terniaryStyle(
                                16, Colors.white, FontWeight.w600),
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