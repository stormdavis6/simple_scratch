import 'package:flutter/material.dart';
import 'package:simple_scratch/constants.dart';
import 'package:simple_scratch/widgets/pricing_cards.dart';

class PremiumSheet extends StatefulWidget {
  const PremiumSheet({super.key});

  @override
  State<PremiumSheet> createState() => _PremiumSheetState();
}

class _PremiumSheetState extends State<PremiumSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff20201e),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                )
              ],
            ),
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
            Text(
              'Simplify Your Odds',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                              fontWeight: FontWeight.bold, fontSize: 16),
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
                              fontWeight: FontWeight.bold, fontSize: 16),
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
                              fontWeight: FontWeight.bold, fontSize: 16),
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
            // Text(
            //   'Select a plan for your free trial',
            //   style: Theme.of(context).textTheme.titleLarge?.copyWith(
            //         color: Colors.white,
            //         fontFamily: 'Montserrat',
            //         fontWeight: FontWeight.bold,
            //       ),
            //   textAlign: TextAlign.center,
            // ),
            // SizedBox(
            //   height: 20,
            // ),
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
                      billedText: 'Just \$4.17 per month, billed annually',
                      mainPricingHighlightText: 'Best Deal',
                      mainPricing: true,
                      badgeColor: kGreenLightColor,
                      cardBorder: RoundedRectangleBorder(
                        side: BorderSide(color: kGreenLightColor, width: 4.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    PricingCard(
                      cardColor: kBackgroundColor,
                      title: 'Premium Monthly',
                      price: '\$5',
                      subPriceText: '/mo',
                      billedText: '',
                    ),
                  ]),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Change plans or cancel at anytime',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade500,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// SizedBox(
// width: MediaQuery.of(context).size.width * .5 - 8,
// child: Card(
// elevation: 3,
// shadowColor: kBlackLightColor,
// color: kBlackLightColor,
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// 'Yearly',
// style: Theme.of(context)
//     .textTheme
//     .titleMedium
//     ?.copyWith(
// color: Colors.white,
// fontFamily: 'Montserrat',
// fontWeight: FontWeight.bold,
// ),
// textAlign: TextAlign.center,
// ),
// Icon(
// Icons.check,
// color: kGreenLightColor,
// )
// ],
// ),
// Text(
// '\$50.00 / year',
// style: Theme.of(context)
//     .textTheme
//     .titleMedium
//     ?.copyWith(
// color: Colors.grey.shade500,
// fontFamily: 'Montserrat',
// fontWeight: FontWeight.bold,
// ),
// textAlign: TextAlign.left,
// ),
// Text(
// 'Just \$4.17 per month, billed annually',
// style:
// Theme.of(context).textTheme.bodyLarge?.copyWith(
// color: Colors.grey.shade500,
// fontFamily: 'Montserrat',
// fontWeight: FontWeight.bold,
// ),
// textAlign: TextAlign.center,
// ),
// ],
// ),
// ),
// ),
// ),
// SizedBox(
// width: MediaQuery.of(context).size.width * .5 - 8,
// child: Card(
// elevation: 3,
// shadowColor: kBlackLightColor,
// color: kBlackLightColor,
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(
// 'Yearly',
// style: Theme.of(context)
//     .textTheme
//     .titleMedium
//     ?.copyWith(
// color: Colors.white,
// fontFamily: 'Montserrat',
// fontWeight: FontWeight.bold,
// ),
// textAlign: TextAlign.center,
// ),
// Icon(
// Icons.check,
// color: kGreenLightColor,
// )
// ],
// ),
// Text(
// '\$50.00 / year',
// style: Theme.of(context)
//     .textTheme
//     .titleMedium
//     ?.copyWith(
// color: Colors.grey.shade500,
// fontFamily: 'Montserrat',
// fontWeight: FontWeight.bold,
// ),
// textAlign: TextAlign.left,
// ),
// Text(
// 'Just \$4.17 per month, billed annually',
// style:
// Theme.of(context).textTheme.bodyLarge?.copyWith(
// color: Colors.grey.shade500,
// fontFamily: 'Montserrat',
// fontWeight: FontWeight.bold,
// ),
// textAlign: TextAlign.center,
// ),
// ],
// ),
// ),
// ),
// )