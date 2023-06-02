import 'package:flutter/material.dart';
import 'package:simple_scratch/constants.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final Color titleColor;
  final String body;
  final String btnText;
  final Color btnTextColor;
  final Color btnColor;
  final Color backgroundColor;
  final Color borderColor;
  const InfoCard(
      {Key? key,
      required this.title,
      required this.body,
      required this.btnText,
      required this.backgroundColor,
      required this.titleColor,
      required this.btnTextColor,
      required this.btnColor,
      required this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor),
      ),
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Positioned.directional(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = titleColor == kGreenLightColor
                                  ? kGreenDarkColor
                                  : kGreenOliveColor,
                            fontFamily: 'Pacifico'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: titleColor,
                            fontFamily: 'Pacifico',
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Container(
                  height: 10,
                ),
                Text(
                  body,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                      color: Colors.grey),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: btnColor,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    btnText,
                    style: TextStyle(
                        color: btnTextColor, fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}