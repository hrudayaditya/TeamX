import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teamx/view/fantasy/preview_players.dart';

import '../../res/app_text_style.dart';
import '../../res/color.dart';


class ChooseCaptainAndViceCaptain extends StatefulWidget {
  final List<String> batsmen;
  final List<String> wicketkeeper;
  final List<String> bowlers;
  final List<String> allRounders;

  ChooseCaptainAndViceCaptain({
    required this.batsmen,required this.bowlers,required this.allRounders,required this.wicketkeeper,
  });

  @override
  State<ChooseCaptainAndViceCaptain> createState() => _ChooseCaptainAndViceCaptainState();
}

class _ChooseCaptainAndViceCaptainState extends State<ChooseCaptainAndViceCaptain> {



  late List<String> b = List.filled(widget.batsmen.length, 'bat');
  late List<String> wkpr = List.filled(widget.wicketkeeper.length, 'wk');
  late List<String> bowl = List.filled(widget.bowlers.length, 'ball');
  late List<String> al = List.filled(widget.allRounders.length, 'bat_ball');
  late List<String> image = wkpr+b+al+bowl;
  late List<String> players = widget.wicketkeeper+widget.batsmen+widget.allRounders+widget.bowlers;

  late List<bool> _color_vc = List.filled(11,false,growable: false);
  late List<bool> _color_c = List.filled(11,false,growable: false);

  String vc_name = '';
  String c_name = '';
  final int a = 1;

  late String messageText;


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffeef0fc),
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
          title: Text("Create Team",
              style: AppTextStyles.primaryStyle(
                  20.0, AppColors.white, FontWeight.w600)),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: width,
            color: Color(0xffeef0fc),
            // margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Text(
                  "Choose your Captain and Vice Captain",
                  style: AppTextStyles.primaryStyle( 17,
                      AppColors.black, FontWeight.w700),
                  maxLines: 2,
                ),
                Text(
                  "C gets 2X points, VC gets 1.5X points",
                  style: AppTextStyles.primaryStyle( 14,
                      AppColors.black, FontWeight.w500),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white60,
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Spacer(),
                SizedBox(
                  width: width * .1,
                  child: Center(
                    child: AutoSizeText(
                      "VC",
                      minFontSize: 10,
                      maxFontSize: 14,
                      style: AppTextStyles.primaryStyle( 14,
                          AppColors.black, FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * .2,
                  child: Center(
                    child: AutoSizeText(
                      "C",
                      minFontSize: 10,
                      maxFontSize: 14,
                      style: AppTextStyles.primaryStyle( 14,
                          AppColors.black, FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
              ],
            ),
          ),


          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: 11,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                          color: Color(0xffeef0fc),
                          border: Border(
                            bottom: BorderSide(color: Colors.white, width: 1),
                          )
                      ),
                      child: ListTile(
                        title: Text(players[index],
                          style: AppTextStyles.terniaryStyle(16, Colors.black, FontWeight.w500),
                        ),
                        tileColor: Colors.white,
                        leading: Image.asset(
                          'assets/cricket-player.png',
                          height: 32,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){
                                setState((){
                                  if(_color_vc.contains(true))
                                  {
                                    if(vc_name==players[index])
                                    {
                                      _color_vc[index] = !_color_vc[index];
                                      vc_name = '';
                                    }
                                  }
                                  else
                                  {
                                    _color_vc[index] = !_color_vc[index];
                                    vc_name = players[index];
                                  }
                                });
                              },
                              child: SizedBox(
                                width: width * 0.15,
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: (_color_vc[index])?AppColors.primaryColor:Colors.white60,
                                    child: Text('VC',
                                        style: AppTextStyles.terniaryStyle(14,
                                            (_color_vc[index]) ? AppColors.white :  Colors.black, FontWeight.w500)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState((){
                                  if(_color_c.contains(true))
                                  {
                                    if(c_name==players[index])
                                    {
                                      _color_c[index] = !_color_c[index];
                                      c_name = '';
                                    }
                                  }
                                  else
                                  {
                                    _color_c[index] = !_color_c[index];
                                    c_name = players[index];
                                  }
                                });
                              },
                              child: SizedBox(
                                width: width * 0.15,
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: (_color_c[index])?AppColors.primaryColor:Colors.white60,
                                    child: Text('C',
                                      style: AppTextStyles.terniaryStyle(14,
                                          (_color_c[index]) ? AppColors.white : Colors.black, FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
          ),
        ],
      ),




      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => TeamPreview(
                  batsmen: ['S Gill', 'R Sharma', 'V Kohli'],
                  bowlers: ['MD Siraj', 'Y Cahal', 'P Cummins', 'J Bumrah',], allRounders: ['G Maxwell', 'R Jadeja'],
                  wicketkeeper: ['K L Rahul'],
                ),
              ));
            },
            child: Container(
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Color(0xff191D88),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: Offset(0, 5)
                    )
                  ]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  Text(" PREVIEW",
                      style: AppTextStyles.primaryStyle(
                          16.0, AppColors.white, FontWeight.w700)),
                ],
              ),
            ),
          ),
          SizedBox(width: 10,),
          GestureDetector(
            onTap: () {

            },
            child: Container(
              height: 40,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.green,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: Offset(0, 5)
                    )
                  ]
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("SAVE",
                      style: AppTextStyles.primaryStyle(
                          16.0, AppColors.white, FontWeight.w700)),
                ],
              ),
            ),
          ),
        ],
      ),
    );


  }
}