import 'package:flutter/material.dart';

import '../../../res/app_text_style.dart';
import '../../../res/color.dart';

class TeamAndPlayerInfo extends StatelessWidget {
  TeamAndPlayerInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 14, right: 14, bottom: 10),
      height: 42.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                    '10',
                    style: AppTextStyles.terniaryStyle(
                      16.0,
                      AppColors.white,
                      FontWeight.w700,
                    ),
                  ),
                  Text(
                    '/11',
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
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                'https://staticg.sportskeeda.com/skm/assets/team-logos/cricket/melbourne-stars.png?w=192',
                height: 36,
              ),
              SizedBox(
                width: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'IND',
                    style: AppTextStyles.primaryStyle(
                      13.0,
                      Colors.white70,
                      FontWeight.w600,
                    ),
                  ),
                  Text(
                    '6',
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
          Text(
            ':',
            style: AppTextStyles.primaryStyle(
              27.5,
              Colors.white,
              FontWeight.w600,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'PAK',
                    style: AppTextStyles.primaryStyle(
                      13.0,
                      Colors.white70,
                      FontWeight.w600,
                    ),
                  ),
                  Text(
                    '3',
                    style: AppTextStyles.terniaryStyle(
                      16.0,
                      AppColors.white,
                      FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 4,
              ),
              Image.network(
                'https://staticg.sportskeeda.com/skm/assets/team-logos/cricket/sydney-sixers.png?w=192',
                height: 36,
              ),
            ],
          ),
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
                '10.8',
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