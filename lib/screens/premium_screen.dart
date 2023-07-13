import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import '../utils.dart';
import '../widgets/pricing_cards.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff20201e),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    scrollbarTheme: ScrollbarThemeData(
                        thumbColor: MaterialStateProperty.all(kBlackLightColor),
                        crossAxisMargin: -6),
                  ),
                  child: Scrollbar(
                    controller: ScrollController(),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Text(
                            'Simplify Your Odds',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                  color: kGreenLightColor,
                                  fontFamily: 'Pacifico',
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Make the most informed decision when it comes to your scratch off games with Premium',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.grey.shade500,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: kYellowLightColor,
                                size: 35,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Top Tickets: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      TextSpan(
                                        text:
                                            'Skip the search and swipe through the best tickets for each price',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: kYellowLightColor,
                                size: 35,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Exclusive Ticket Stats: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      TextSpan(
                                        text:
                                            'View each ticket\'s Calculated Odds, Expected Value, and more',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: kYellowLightColor,
                                size: 35,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Zero Ads: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      TextSpan(
                                        text:
                                            'Browse the latest tickets and develop your winning strategy, distraction-free',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Select the plan best for you',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: PricingCards(pricingCards: [
                                  PricingCard(
                                      cardColor: kBackgroundColor,
                                      title: 'Premium Annual',
                                      price: '\$50',
                                      subPriceText: '/yr',
                                      billedText:
                                          '\$4.17 per month, billed annually',
                                      mainPricingHighlightText: 'Best Deal',
                                      mainPricing: true,
                                      badgeColor: kGreenLightColor,
                                      cardBorder: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: kGreenLightColor,
                                            width: 4.0),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      onPress: () {
                                        Utils.showInfoPopUp(
                                            Text(
                                                'In-App Purchases are Coming Soon'),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            'We are still working on implementing in-app purchases for our mobile app.',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            'In the meantime, you can subscribe to premium by going to ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            'simplescratch.net',
                                                        style: TextStyle(
                                                            color:
                                                                kGreenLightColor,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontSize: 16),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                launchURL();
                                                              },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            context);
                                      }),
                                  PricingCard(
                                      cardColor: kBackgroundColor,
                                      title: 'Premium Monthly',
                                      price: '\$5',
                                      subPriceText: '/mo',
                                      billedText: '',
                                      cardBorder: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: kGreenLightColor,
                                            width: 4.0),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      onPress: () {
                                        Utils.showInfoPopUp(
                                            Text(
                                                'In-App Purchases are Coming Soon'),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            'We are still working on implementing in-app purchases for our mobile app.',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            'In the meantime, you can subscribe to premium by going to ',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            'simplescratch.net',
                                                        style: TextStyle(
                                                            color:
                                                                kGreenLightColor,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontSize: 16),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                launchURL();
                                                              },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            context);
                                      }),
                                ]),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Change plans or cancel at anytime',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey.shade500,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

launchURL() async {
  Uri url = Uri.parse('https://simplescratch.net/#/pricing');
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}