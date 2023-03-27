part of '../views/custom_month_picker.dart';

class _MonthYearController extends GetxController {
  _MonthYearController(
      {this.firstYear,
      this.lastYear,
      this.initialMonth,
      this.initialYear,
      this.firstEnabledMonth,
      this.lastEnabledMonth});

  /// static method to get the controller instance from anywhere
  static _MonthYearController of(
      {int? firstYear,
      int? lastYear,
      int? initialMonth,
      int? initialYear,
      int? firstEnabledMonth,
      int? lastEnabledMonth}) {
    try {
      // if the controller is already created, return it
      return Get.find();
    } catch (e) {
      // if not, create a new instance and return it
      return Get.put(_MonthYearController(
        firstYear: firstYear ?? 1900,
        lastYear: lastYear ?? DateTime.now().year,
        initialMonth: initialMonth ?? DateTime.now().month,
        initialYear: initialYear ?? DateTime.now().year,
        firstEnabledMonth: firstEnabledMonth ?? 1,
        lastEnabledMonth: lastEnabledMonth ?? 12,
      ));
    }
  }

  /// the first year to be shown in the year picker
  final int? firstYear;

  /// the last year to be shown in the year picker
  final int? lastYear;

  /// the first month to be enabled in the month picker
  final int? firstEnabledMonth;

  /// the last month to be enabled in the month picker
  final int? lastEnabledMonth;

  /// the initial month to be selected
  final int? initialMonth;

  /// the initial year to be selected
  final int? initialYear;

  /// the selected month
  RxInt selectedMonth = 1.obs;

  /// the selected year
  RxInt selectedYear = 32.obs;

  /// the selected date object (contains the selected month and year)
  DateTime selected = DateTime.now();

  /// this is used to show the month view or the year view in the dialog
  RxBool monthSelectionStarted = false.obs;
  RxBool yearSelectionStarted = false.obs;

  /// the list of years to be shown in the year picker
  List<String> yearList = [];

  /// the list of months to be shown in the month picker
  List<String> monthsName = [];

  @override
  void onInit() {
    super.onInit();
    // generate the list of months to be shown in the month picker
    _generateMonthList();

    // generate the list of years to be shown in the year picker
    _generateYearList();

    // set the initial month and year
    setMonth(initialMonth!);
    setYear(initialYear!);
  }

  /// this method is called when the user taps on a year in the year picker
  void setYear(int year) {
    selectedYear(int.parse(year.toString()));
    // if the selected year is less than the first enabled month, set the selected month to the first enabled month
    if (isDisabledMonth(selectedMonth.value)) {
      selectedMonth(firstEnabledMonth!);
    }
    _assignDate();
  }

  /// this method is called when the user taps on a month in the month picker
  void setMonth(int month) {
    selectedMonth(month);
    _assignDate();
  }

  /// this method is called when the user taps on the month name or year in the month picker
  void _assignDate() {
    selected = DateTime(selectedYear.value, selectedMonth.value, 1);
  }

  /// this method is called once when the controller is initialized to generate the list of years to be shown in the year picker
  void _generateYearList() {
    selectedMonth(selected.month);
    setYear(selected.year);
    yearList = List.generate((lastYear! - firstYear!) + 1,
        (index) => (lastYear! - index).toString());
  }

  /// this method is called once when the controller is initialized to generate the list of months to be shown in the year picker
  void _generateMonthList() {
    for (int i = 1; i <= 12; i++) {
      monthsName.add(DateFormat.MMM().format(DateTime(2023, i, 1)));
    }
  }

  /// this method is called when the user taps on the month name in the month picker to check if the month is enabled or not
  bool isDisabledMonth(int month) {
    if (month < firstEnabledMonth! && selectedYear.value == firstYear) {
      return true;
    } else if (month > lastEnabledMonth! && selectedYear.value == lastYear) {
      return true;
    }

    return false;
  }
}
