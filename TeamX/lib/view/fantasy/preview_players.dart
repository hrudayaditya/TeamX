import 'package:flutter/material.dart';
import 'package:teamx/view/Fantasy/widgets/team_and_player_info.dart';

import '../../res/app_text_style.dart';
import '../../res/color.dart';

class TeamPreview extends StatefulWidget {

  final List<String> batsmen;
  final List<String> bowlers;
  final List<String> wicketkeeper;
  final List<String> allRounders;


  const TeamPreview({
    required this.batsmen,required this.bowlers,required this.allRounders,required this.wicketkeeper,
  });

  @override
  State<TeamPreview> createState() => _TeamPreviewState();
}

class _TeamPreviewState extends State<TeamPreview> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          AppBar().preferredSize.height,
        ),
        child: AppBar(
          iconTheme: IconThemeData(
            size: 20,
            color: Colors.white, // Set the color you want here
          ),
          backgroundColor: Color(0xff191D88),
          elevation: 1.0,
          title: Text("Team Preview",
              style: AppTextStyles.primaryStyle(
                  20.0, AppColors.white, FontWeight.w600)),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xff191D88),
            ),
            child: TeamAndPlayerInfo(),
          ),
          Expanded(
            child: Container(
              // constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/ground.jpg'),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('WICKET KEEPERS',
                      style: AppTextStyles.terniaryStyle(
                        14.0,
                        Colors.white,
                        FontWeight.w600,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        for(int i = 0; i < widget.wicketkeeper.length; i++)
                          PlayerIcon(
                            player: widget.wicketkeeper,
                            i: i,
                            player_type: 'wk',
                          ),
                      ],
                    ),

                    SizedBox(height:8),

                    Text('BATSMAN',
                      style: AppTextStyles.terniaryStyle(
                        14.0,
                        Colors.white,
                        FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        for(int i=0;i<widget.batsmen.length;i++)
                          PlayerIcon(player: widget.batsmen, i: i,player_type: 'bat',),
                      ],
                    ),

                    SizedBox(height:8),

                    Text('ALL ROUNDERS',
                      style: AppTextStyles.terniaryStyle(
                        14.0,
                        Colors.white,
                        FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        for(int i = 0; i < widget.allRounders.length;i++)
                          PlayerIcon(player: widget.allRounders, i: i,player_type: 'bat_ball',),
                      ],
                    ),

                    SizedBox(height:8),

                    Text('BOWLERS',
                      style: AppTextStyles.terniaryStyle(
                        14.0,
                        Colors.white,
                        FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        for(int i=0;i<widget.bowlers.length;i++)
                          PlayerIcon(player: widget.bowlers, i: i,player_type: 'ball',),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerIcon extends StatelessWidget {
  const PlayerIcon({
    Key? key,
    required this.player,
    required this.i,
    required this.player_type,
  }) : super(key: key);

  final List<String> player;
  final int i;
  final String player_type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          'assets/cricket-player.png',
          width: 40,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
              player[i],
              style: AppTextStyles.primaryStyle(12, Colors.white, FontWeight.w600)
          ),
        ),
        Text(
            '7.5 Cr',
            style: AppTextStyles.primaryStyle(14, Colors.white, FontWeight.w600)
        ),
      ],
    );
  }
}
