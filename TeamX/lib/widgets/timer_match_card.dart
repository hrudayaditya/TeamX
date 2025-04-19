import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teamx/res/color.dart';

class CountdownWidget extends StatefulWidget {
  final Duration duration;
  final DateTime startTime;
  const CountdownWidget(
      {super.key, required this.duration, required this.startTime});

  @override
  CountdownWidgetState createState() => CountdownWidgetState();
}

class CountdownWidgetState extends State<CountdownWidget> {
  late Duration _remainingDuration;
  late Timer _timer;
  String formatDuration(Duration duration) {
    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String result = '';

    if (days > 0) {
      result += "${days}d ";
    }
    if (hours > 0) {
      result += "${hours}h ";
    }
    if (days == 0 && minutes > 0) {
      result += "${minutes}m ";
    }
    if (days == 0 && hours == 0) {
      result += "${seconds}s";
    }

    return result.trim(); // Trim to remove extra space at the end
  }

  String amOrPm = '';
  @override
  void initState() {
    super.initState();
    _remainingDuration = widget.duration;
    startCountdown();
    amOrPm = widget.startTime.hour < 12 ? ' AM' : ' PM';
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_remainingDuration.inSeconds == 0) {
          _timer.cancel();
        } else {
          _remainingDuration -= const Duration(seconds: 1);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 3, bottom: 3, left: 8, right: 8),
            child: Text(
              formatDuration(_remainingDuration),
              style: TextStyle(fontSize: 14, color: AppColors.primaryColor),
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Text(
          widget.startTime.minute == 0
              ? '${widget.startTime.hour}:${widget.startTime.minute}0'
              : '${widget.startTime.hour}:${widget.startTime.minute}',
          style: TextStyle(color: Colors.grey[700], fontSize: 12.0),
        )
      ],
    );
  }
}