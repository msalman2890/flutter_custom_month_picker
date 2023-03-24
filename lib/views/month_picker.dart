part of 'custom_month_picker.dart';

class _MonthPicker extends StatefulWidget {
  const _MonthPicker({required this.highlightColor, this.backgroundColor = Colors.white});

  final Color highlightColor;
  final Color backgroundColor;

  @override
  State<_MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<_MonthPicker> {
  late _MonthYearController controller;

  @override
  void initState() {
    super.initState();
    controller = _MonthYearController.of();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      color: widget.backgroundColor,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 2,
        children: List.generate(
            controller.monthsName.length,
            (index) => GestureDetector(
                  onTap: () {
                    controller.setMonth(controller.monthsName[index]);
                    controller.monthSelectionStarted(false);
                  },
                  child: Obx(
                    () => Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: controller.selectedMonth.value["name"] ==
                                  controller.monthsName[index]
                              ? widget.highlightColor
                              : Colors.transparent),
                      child: Center(
                        child: Text(
                          controller.monthsName[index],
                          style: TextStyle(
                              color: controller.selectedMonth.value["name"] ==
                                      controller.monthsName[index]
                                  ? Colors.white
                                  : const Color(0xff474747),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
