import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;

/// The model to define data input for [PricingCards]
class PricingCard {
  /// Creates a new instance of a card
  const PricingCard({
    required this.title,
    required this.price,
    required this.subPriceText,
    required this.billedText,
    this.onPress,
    this.mainPricing = false,
    this.mainPricingHighlightText = '',
    this.priceStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    this.billedTextStyle = const TextStyle(
      fontSize: 12,
      color: Colors.grey,
    ),
    this.cardColor = Colors.white,
    this.badgeColor = Colors.red,
    this.titleStyle,
    this.cardBorder,
    this.subPriceStyle,
  });

  /// The top text
  final String title;

  /// The main big text
  final String price;

  /// The small text under the price
  final String subPriceText;

  /// The (possibly) smooth text on the bottom
  final String billedText;

  /// The function called when the user press this card
  final void Function()? onPress;

  /// Defines this card as main so it will have a special [cardBorder] and a badge
  final bool mainPricing;

  /// The text that will appear above the card if [mainPricing] is true
  final String mainPricingHighlightText;

  /// The [price] style
  final TextStyle? priceStyle;

  /// The [billedText] style
  final TextStyle? billedTextStyle;

  /// The [subPriceText] style
  final TextStyle? subPriceStyle;

  /// The [title] style
  final TextStyle? titleStyle;

  /// The border style of this
  final RoundedRectangleBorder? cardBorder;

  /// The background color of this
  final Color? cardColor;

  /// The background color of the badge
  final Color badgeColor;
}

/// A widget list with one or more [PricingCards]
class PricingCards extends StatelessWidget {
  /// Creates a widget list of [PricingCard]
  ///
  /// This list wraps accordingly to the width of the parent.
  const PricingCards({
    Key? key,
    required this.pricingCards,
  }) : super(key: key);

  /// The list of this, you can give this as much [PricingCard] you want
  final List<PricingCard> pricingCards;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: pricingCards.map((pc) {
        final pricingCard = Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              color: pc.cardColor,
              shape: pc.cardBorder ??
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red, width: 4.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      pc.title,
                      style: pc.titleStyle,
                    ),
                    SizedBox(height: 16),
                    Text(
                      pc.price,
                      style: pc.priceStyle,
                    ),
                    Text(
                      pc.subPriceText,
                      style: pc.subPriceStyle,
                    ),
                    SizedBox(height: 16),
                    Text(
                      pc.billedText,
                      style: pc.billedTextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );

        return InkWell(
          onTap: pc.onPress,
          child: pc.mainPricing
              ? Badge(
                  alignment: Alignment.center,
                  badgeContent: Text(
                    pc.mainPricingHighlightText,
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: BadgeShape.square,
                  position: BadgePosition.topStart(top: -10),
                  borderRadius: BorderRadius.circular(16),
                  toAnimate: false,
                  child: pricingCard,
                  badgeColor: pc.badgeColor,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                )
              : pricingCard,
        );
      }).toList(),
    );
  }
}