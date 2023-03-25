part of '../views/custom_month_picker.dart';

class _MonthYearController extends GetxController {
  _MonthYearController(
      {this.firstYear, this.lastYear, this.initialMonth, this.initialYear});

  static _MonthYearController of(
      {int? firstYear, int? lastYear, int? initialMonth, int? initialYear}) {
    try {
      return Get.find();
    } catch (e) {
      return Get.put(_MonthYearController(
        firstYear: firstYear ?? 1900,
        lastYear: lastYear ?? DateTime.now().year,
        initialMonth: initialMonth ?? DateTime.now().month,
        initialYear: initialYear ?? DateTime.now().year,
      ));
    }
  }

  final int? firstYear;
  final int? lastYear;
  final int? initialMonth;
  final int? initialYear;

  RxInt selectedMonth = 1.obs;
  RxInt selectedYear = 32.obs;

  DateTime selected = DateTime.now();
  RxBool monthSelectionStarted = false.obs;
  RxBool yearSelectionStarted = false.obs;

  List<String> yearList = [];

  List<String> monthsName = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "June",
    "July",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  void onInit() {
    super.onInit();
    _generateYearList();
    setMonth(initialMonth!);
    setYear(initialYear!);
  }

  void setYear(int year) {
    selectedYear(int.parse(year.toString()));
    _assignDate();
  }

  void setMonth(int month) {
    selectedMonth(month);
    _assignDate();
  }

  void _assignDate() {
    selected = DateTime(selectedYear.value, selectedMonth.value, 1);
  }

  void _generateYearList() {
    selectedMonth(selected.month);
    setYear(selected.year);
    yearList = List.generate((selectedYear.value - firstYear!) + 1,
        (index) => (selectedYear.value - index).toString());
  }
}
