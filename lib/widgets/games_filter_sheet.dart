import 'package:flutter/material.dart';
import 'package:simple_scratch/constants.dart';

import '../models/filter_item.dart';

class GamesFilterSheet extends StatefulWidget {
  final List<FilterItem> selectedFiltersListPassed;
  const GamesFilterSheet({super.key, required this.selectedFiltersListPassed});

  @override
  State<GamesFilterSheet> createState() => _GamesFilterSheetState();
}

class _GamesFilterSheetState extends State<GamesFilterSheet> {
  @override
  void initState() {
    super.initState();
    priceFilters.sort((a, b) => b.id.compareTo(a.id));
    topPrizeFilters.sort((a, b) => b.id.compareTo(a.id));
    selectFilters();
  }

  void selectFilters() {
    setState(() {
      if (widget.selectedFiltersListPassed.isNotEmpty) {
        selectedFiltersList = widget.selectedFiltersListPassed;
        for (var item in selectedFiltersList) {
          if (item.id < 10) {
            priceFilters[
                    priceFilters.indexWhere((element) => element.id == item.id)]
                .isSelected = true;
          } else {
            topPrizeFilters[topPrizeFilters
                    .indexWhere((element) => element.id == item.id)]
                .isSelected = true;
          }
        }
      }
    });
  }

  List<FilterItem> priceFilters = [
    FilterItem(filterText: '\$30', filterType: 1, id: 1),
    FilterItem(filterText: '\$25', filterType: 1, id: 2),
    FilterItem(filterText: '\$20', filterType: 1, id: 3),
    FilterItem(filterText: '\$10', filterType: 1, id: 4),
    FilterItem(filterText: '\$5', filterType: 1, id: 5),
    FilterItem(filterText: '\$3', filterType: 1, id: 6),
    FilterItem(filterText: '\$2', filterType: 1, id: 7),
    FilterItem(filterText: '\$1', filterType: 1, id: 8)
  ];
  List<FilterItem> topPrizeFilters = [
    FilterItem(filterText: 'Less Than \$5k', filterType: 2, id: 10),
    FilterItem(filterText: '\$5k - \$50k', filterType: 2, id: 11),
    FilterItem(filterText: '\$50k - \$100k', filterType: 2, id: 12),
    FilterItem(filterText: '\$100k - \$250k', filterType: 2, id: 13),
    FilterItem(filterText: '\$250k - \$500k', filterType: 2, id: 14),
    FilterItem(filterText: '\$500k+', filterType: 2, id: 15),
    FilterItem(filterText: '1M+', filterType: 2, id: 16)
  ];
  List<FilterItem> selectedFiltersList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 48,
                    height: 48,
                  ),
                  Text(
                    'Filters',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              FilterCard('Ticket Price', kGreenLightColor, kGreenDarkColor, 5,
                  priceFilters),
              SizedBox(
                height: 10,
              ),
              // Divider(
              //   color: kBlackLightColor,
              //   height: 1,
              //   thickness: 1,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              FilterCard('Top Prize', kGreenLightColor, kGreenDarkColor, 3,
                  topPrizeFilters),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  selectedFiltersList.isEmpty
                      ? SizedBox(
                          height: 0,
                          width: 0,
                        )
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              for (var element in priceFilters) {
                                element.isSelected = false;
                              }
                              for (var element in topPrizeFilters) {
                                element.isSelected = false;
                              }
                              selectedFiltersList = [];
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: kBackgroundColor,
                            foregroundColor: kBackgroundColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Clear Selected',
                            style: TextStyle(
                                color: kGreenLightColor,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, selectedFiltersList);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: kGreenLightColor,
                      foregroundColor: kGreenDarkColor,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Done',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget FilterCard(String title, Color titleColor, Color borderColor,
      int crossAxisCount, List<FilterItem> filters) {
    return Container(
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
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Colors.black54,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Container(
            height: 10,
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: filters.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
                crossAxisCount: crossAxisCount,
                childAspectRatio: 2),
            itemBuilder: (context, index) {
              return TextButton(
                onPressed: () {
                  setState(() {
                    if (!filters[index].isSelected) {
                      selectedFiltersList.add(filters[index]);
                    } else {
                      selectedFiltersList.removeAt(
                          selectedFiltersList.indexWhere(
                              (element) => element.id == filters[index].id));
                    }
                    filters[index].isSelected = !filters[index].isSelected;
                  });
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  foregroundColor: filters[index].isSelected
                      ? kBackgroundColor
                      : kGreenDarkColor,
                  backgroundColor: filters[index].isSelected
                      ? kGreenLightColor
                      : kBackgroundColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  filters[index].filterText,
                  style: TextStyle(
                      color: filters[index].isSelected
                          ? kBackgroundColor
                          : kGreenLightColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          Container(
            height: 10,
          ),
        ],
      ),
    );
  }
}