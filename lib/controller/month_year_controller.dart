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
    yearList=List.generate((initialYear!-firstYear!)+1, (index) => (initialYear!-index).toString());
    selectedMonth({
      "name":monthsName[initialMonth!-1],
      "index":initialMonth!-1
    });
    selectedYear(initialYear!);
  }

  void setYear(year){
    selectedYear(int.parse(year));
    selected=DateTime(selectedYear.value,selectedMonth.value["index"]+1,1);
  }
  void setMonth(month){
    selectedMonth({
      "name":month,
      "index":monthsName.indexWhere((element) => element==month)
    });
    selected=DateTime(selectedYear.value,selectedMonth.value["index"]+1,1);
  }

}