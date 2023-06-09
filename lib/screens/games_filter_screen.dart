import 'package:flutter/material.dart';
import 'package:simple_scratch/constants.dart';
import 'package:simple_scratch/models/filterItem.dart';

class GamesFilterScreen extends StatefulWidget {
  final List<FilterItem> selectedFiltersListPassed;
  const GamesFilterScreen({
    Key? key,
    required this.selectedFiltersListPassed,
  }) : super(key: key);

  @override
  State<GamesFilterScreen> createState() => _GamesFilterScreenState();
}

class _GamesFilterScreenState extends State<GamesFilterScreen> {
  @override
  void initState() {
    super.initState();
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
  }

  List<FilterItem> priceFilters = [
    FilterItem(filterText: '\$1', id: 1),
    FilterItem(filterText: '\$2', id: 2),
    FilterItem(filterText: '\$3', id: 3),
    FilterItem(filterText: '\$5', id: 4),
    FilterItem(filterText: '\$10', id: 5),
    FilterItem(filterText: '\$20', id: 6),
    FilterItem(filterText: '\$25', id: 7),
    FilterItem(filterText: '\$30', id: 8),
  ];
  List<FilterItem> topPrizeFilters = [
    FilterItem(filterText: '1M+', id: 10),
    FilterItem(filterText: '\$500k+', id: 11),
    FilterItem(filterText: '\$250k - \$500k', id: 12),
    FilterItem(filterText: '\$100k - \$250k', id: 13),
    FilterItem(filterText: '\$50k - \$100k', id: 14),
    FilterItem(filterText: '\$5k - \$50k', id: 15),
    FilterItem(filterText: 'Less Than \$5k', id: 16)
  ];
  List<FilterItem> selectedFiltersList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Stack(
                    children: [
                      Positioned.directional(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'Filter Scratch-Offs',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = kGreenOliveColor,
                                  fontFamily: 'Pacifico'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        'Filter Scratch-Offs',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: kYellowLightColor,
                              fontFamily: 'Pacifico',
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 24,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              FilterCard('Ticket Price', kGreenLightColor, kGreenDarkColor, 5,
                  priceFilters),
              SizedBox(
                height: 10,
              ),
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
                            for (var element in priceFilters) {
                              element.isSelected = false;
                            }
                            for (var element in topPrizeFilters) {
                              element.isSelected = false;
                            }
                            selectedFiltersList = [];
                            print(selectedFiltersList.length);
                            setState(() {});
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: kBackgroundColor,
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
                      if (selectedFiltersList.isNotEmpty) {
                        print('Sending Filters: ');
                        for (int i = 0; i < selectedFiltersList.length; i++) {
                          print(selectedFiltersList[i].filterText);
                        }
                        Navigator.pop(context, selectedFiltersList);
                      } else {
                        Navigator.pop(context, selectedFiltersList);
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: kGreenLightColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Done',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget FilterCard(String title, Color titleColor, Color borderColor,
      int crossAxisCount, List<FilterItem> filters) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: borderColor),
      ),
      color: kBackgroundColor,
      child: Container(
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
                          color: Color(0xff363636),
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
                        print('Selected filter ${filters[index].filterText}');
                      } else {
                        selectedFiltersList.removeAt(
                            selectedFiltersList.indexWhere(
                                (element) => element.id == filters[index].id));
                        print(
                            'UN-Selected filter ${filters[index].filterText}');
                        selectedFiltersList.forEach((element) {
                          print(element.filterText);
                        });
                      }
                      filters[index].isSelected = !filters[index].isSelected;
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: filters[index].isSelected
                        ? kGreenLightColor
                        : kBackgroundColor,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }
}