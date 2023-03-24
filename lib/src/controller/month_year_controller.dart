part of '../views/custom_month_picker.dart';

class _MonthYearController extends GetxController{
  _MonthYearController({this.firstYear, this.lastYear, this.initialMonth, this.initialYear});

  static _MonthYearController of({int? firstYear, int? lastYear, int? initialMonth, int? initialYear}) {
    try{
    return Get.find();
    }catch(e){
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

  RxMap selectedMonth = {}.obs;
  RxInt selectedYear = 32.obs;

  DateTime selected=DateTime.now();
  RxBool monthSelectionStarted=false.obs;
  RxBool yearSelectionStarted=false.obs;

  List<String> yearList=[];

  List<String> monthsName=[
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
    selectedMonth({
      "name":monthsName[initialMonth!-1],
      "index":initialMonth!-1
    });
    selectedYear(initialYear!);
  }

  void setYear(year){
    selectedYear(int.parse(year));
    _assignDate();
  }
  void setMonth(month){
    selectedMonth({
      "name":month,
      "index":monthsName.indexWhere((element) => element==month)
    });
    _assignDate();
  }

  void _assignDate(){
    selected=DateTime(selectedYear.value,selectedMonth.value["index"]+1,1);
  }

  void _generateYearList(){
    yearList=List.generate((selectedYear.value-firstYear!)+1, (index) => (selectedYear.value-index).toString());
  }

}