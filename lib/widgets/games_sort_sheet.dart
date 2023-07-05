import 'package:flutter/material.dart';
import 'package:simple_scratch/constants.dart';
import '../models/sort_item.dart';

class GamesSortSheet extends StatefulWidget {
  final SortItem selectedSortItemPassed;
  final bool isPremium;
  const GamesSortSheet(
      {super.key,
      required this.selectedSortItemPassed,
      required this.isPremium});

  @override
  State<GamesSortSheet> createState() => _GamesSortSheetState();
}

class _GamesSortSheetState extends State<GamesSortSheet> {
  @override
  void initState() {
    super.initState();
    if (widget.isPremium) {
      sortFilters.add(
        SortItem(sortText: 'Calculated Odds Asc', id: 7),
      );
      sortFilters.add(
        SortItem(sortText: 'Calculated Odds Desc', id: 8),
      );
    }
    sortFilters.sort((a, b) => a.id.compareTo(b.id));
    selectFilters();
  }

  void selectFilters() {
    setState(() {
      selectedSortItem = widget.selectedSortItemPassed;
      _value = sortFilters
          .indexWhere((element) => element.id == selectedSortItem.id);
    });
  }

  List<SortItem> sortFilters = [
    SortItem(sortText: 'Ticket Price Asc', id: 1),
    SortItem(sortText: 'Ticket Price Desc', id: 2),
    SortItem(sortText: 'Top Prize Asc', id: 3),
    SortItem(sortText: 'Top Prize Desc', id: 4),
    SortItem(sortText: 'Overall Odds Asc', id: 5),
    SortItem(sortText: 'Overall Odds Desc', id: 6),
  ];
  late SortItem selectedSortItem;
  late int _value;

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
                  Text(
                    'Sort tickets by',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Colors.black54,
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
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  runSpacing: 3,
                  children: List<Widget>.generate(
                    sortFilters.length,
                    (int index) {
                      return ChoiceChip(
                        label: Text(sortFilters[index].sortText),
                        labelStyle: TextStyle(
                          color:
                              _value == index ? Colors.white : kGreenLightColor,
                        ),
                        selected: _value == index,
                        backgroundColor: kBackgroundColor,
                        elevation: 5,
                        selectedColor: kGreenLightColor,
                        onSelected: (selected) {
                          setState(() {
                            _value = selected ? index : 1;
                          });
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Divider(
              //   color: kBlackLightColor,
              //   height: 1,
              //   thickness: 1,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      selectedSortItem = sortFilters[_value];
                      Navigator.pop(context, selectedSortItem);
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
                      'Sort',
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
}