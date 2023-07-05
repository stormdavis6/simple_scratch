class FilterItem {
  int id;
  int filterType; // 1 for ticketPrice, 2 for TopPrize
  String filterText;
  bool isSelected = false;

  FilterItem(
      {required this.id, required this.filterType, required this.filterText});
}