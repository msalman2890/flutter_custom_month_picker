part of 'custom_month_picker.dart';

class _MonthPicker extends StatefulWidget {
  const _MonthPicker(
      {required this.highlightColor, this.backgroundColor = Colors.white});

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
    // get the controller from the parent
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
        children: List.generate(controller.monthsName.length, (index) {
          bool isDisabled = controller.isDisabledMonth(index + 1);
          return GestureDetector(
            onTap: () {
              // if the month is disabled, do nothing
              if (isDisabled) {
                return;
              }
              // set the selected month
              controller.setMonth(index + 1);
              controller.monthSelectionStarted(false);
            },
            child: Obx(
              () => Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: controller.selectedMonth.value - 1 == index
                        ? widget.highlightColor
                        : Colors.transparent),
                child: Center(
                  child: Text(
                    controller.monthsName[index],
                    style: TextStyle(
                        color: isDisabled
                            ? Colors.grey
                            : controller.selectedMonth.value - 1 == index
                                ? Colors.white
                                : const Color(0xff474747),
                        fontSize: 14,
                        fontWeight: controller.selectedMonth.value - 1 == index
                            ? FontWeight.w700
                            : FontWeight.w500),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
