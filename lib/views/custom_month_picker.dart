import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'month_picker.dart';
part 'year_picker.dart';
part '../controller/month_year_controller.dart';


void showMonthPicker(context,
    {required Function(int, int) onSelected,
      int? firstYear,
      int? initialSelectedMonth,
      int? initialSelectedYear,
      int? lastYear,
      String selectButtonText = "OK",
      String cancelButtonText = "Cancel",
      Color highlightColor = Colors.green,
      Color? contentBackgroundColor = Colors.white,
      Color? dialogBackgroundColor,
      Color? textColor}) {
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return _CustomMonthPicker(
            onSelected: onSelected,
            firstYear: firstYear,
            initialSelectedMonth: initialSelectedMonth,
            initialSelectedYear: initialSelectedYear,
            lastYear: lastYear,
            selectButtonText: selectButtonText,
            cancelButtonText: cancelButtonText,
            highlightColor: highlightColor,
            contentBackgroundColor: contentBackgroundColor,
            dialogBackgroundColor: dialogBackgroundColor,
            textColor: textColor);
      });
}


class _CustomMonthPicker extends StatefulWidget {
  const _CustomMonthPicker({
    Key? key,
    required this.onSelected,
    this.firstYear,
    this.initialSelectedMonth,
    this.initialSelectedYear,
    this.lastYear,
    this.selectButtonText = "OK",
    this.cancelButtonText = "Cancel",
    this.highlightColor = Colors.green,
    this.textColor = Colors.black,
    this.contentBackgroundColor = Colors.white,
    this.dialogBackgroundColor,
  }) : super(key: key);

  final Function(int, int) onSelected;
  final int? firstYear;
  final int? initialSelectedMonth;
  final int? initialSelectedYear;
  final int? lastYear;
  final String? selectButtonText;
  final String? cancelButtonText;
  final Color? highlightColor;
  final Color? textColor;
  final Color? dialogBackgroundColor;
  final Color? contentBackgroundColor;

  @override
  State<_CustomMonthPicker> createState() => _CustomMonthPickerState();
}

class _CustomMonthPickerState extends State<_CustomMonthPicker> {
  late _MonthYearController controller;

  @override
  void initState() {
    super.initState();
    controller = _MonthYearController.of(
      firstYear: widget.firstYear,
      initialMonth: widget.initialSelectedMonth,
      initialYear: widget.initialSelectedYear,
      lastYear: widget.lastYear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(15.0),
      contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
      scrollable: true,
      backgroundColor: widget.dialogBackgroundColor ?? const Color(0xffefefef),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              yearSelectionButton(),
              const SizedBox(height: 15),
              returnSelectionView(),
              const SizedBox(height: 15),
              dialogFooter()
            ],
          ),
        ),
      ),
    );
  }

  Widget returnSelectionView() {
    if (controller.yearSelectionStarted.isTrue) {
      return _YearPicker(
        highlightColor: widget.highlightColor!,
        backgroundColor: widget.contentBackgroundColor!,
      );
    }
    return _MonthPicker(
      highlightColor: widget.highlightColor!,
      backgroundColor: widget.contentBackgroundColor!,
    );
  }

  Widget yearSelectionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ElevatedButton(
        onPressed: () {
          controller.monthSelectionStarted(false);
          controller.yearSelectionStarted(
              !controller.yearSelectionStarted.value);
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          fixedSize: const Size(100, 45),
          padding: const EdgeInsets.all(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.selectedYear.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            Icon(
              controller.yearSelectionStarted.value
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget dialogFooter(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              if (controller.yearSelectionStarted.value) {
                controller.yearSelectionStarted(false);
              } else {
                Get.back();
              }
            },
            child: Text(widget.cancelButtonText!,
                style: TextStyle(color: widget.highlightColor))),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            widget.onSelected(
                controller.selected.month, controller.selected.year);
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(100, 40),
            padding: EdgeInsets.zero,
            backgroundColor: widget.highlightColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(widget.selectButtonText!),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
