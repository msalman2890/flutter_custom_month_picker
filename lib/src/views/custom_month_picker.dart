import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'package:intl/intl.dart';

part 'month_picker.dart';

part 'year_picker.dart';

part '../controller/month_year_controller.dart';

/// public method to access the month picker dialog with the required parameters
void showMonthPicker(context,
    {required Function(int, int) onSelected,
    int? firstYear,
    int? initialSelectedMonth,
    int? initialSelectedYear,
    int? lastYear,
    int? firstEnabledMonth,
    int? lastEnabledMonth,
    String selectButtonText = "OK",
    String cancelButtonText = "Cancel",
    Color highlightColor = Colors.green,
    Color? contentBackgroundColor = Colors.white,
    Color? dialogBackgroundColor,
    Color? textColor}) {
  // check if the parameters are valid
  try {
    // check if the first enabled month is valid
    if (firstEnabledMonth != null) {
      assert(firstEnabledMonth >= 1 && firstEnabledMonth <= 12);
    }

    // check if the last enabled month is valid
    if (lastEnabledMonth != null) {
      assert(lastEnabledMonth >= 1 && lastEnabledMonth <= 12);
    }

    firstEnabledMonth ??= 1;
    lastEnabledMonth ??= 12;
    firstYear ??= 1900;
    lastYear ??= DateTime.now().year;
    initialSelectedMonth ??= DateTime.now().month;
    initialSelectedYear ??= DateTime.now().year;

    // check if the first year is less than the last year
    assert(firstYear <= lastYear);

    // check if the initial selected year is between the first and last year
    assert(initialSelectedYear >= firstYear);
    assert(initialSelectedYear <= lastYear);

    if(initialSelectedYear == firstYear) {
      // check if the initial selected month is greater than the first enabled month
      assert(initialSelectedMonth >= firstEnabledMonth);
    }

    if(initialSelectedYear == lastYear) {
      // check if the initial selected month is less than the last enabled month
      assert(initialSelectedMonth <= lastEnabledMonth);
    }

  } catch (e) {
    // if not valid, log the error and return
    log(e.toString(), name: "flutter_custom_month_picker");
    return;
  }

  /// show the dialog
  showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return _CustomMonthPicker(
            onSelected: onSelected,
            firstYear: firstYear,
            initialSelectedMonth: initialSelectedMonth,
            initialSelectedYear: initialSelectedYear,
            lastYear: lastYear,
            firstEnabledMonth: firstEnabledMonth,
            lastEnabledMonth: lastEnabledMonth,
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
    this.firstEnabledMonth,
    this.lastEnabledMonth,
  }) : super(key: key);

  final Function(int, int) onSelected;
  final int? firstYear;
  final int? initialSelectedMonth;
  final int? initialSelectedYear;
  final int? lastYear;
  final int? firstEnabledMonth;
  final int? lastEnabledMonth;
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
    // initialize the controller with the required parameters
    controller = _MonthYearController.of(
      firstYear: widget.firstYear,
      initialMonth: widget.initialSelectedMonth,
      initialYear: widget.initialSelectedYear,
      lastYear: widget.lastYear,
      firstEnabledMonth: widget.firstEnabledMonth,
      lastEnabledMonth: widget.lastEnabledMonth,
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

  /// return the month picker or year picker based on the view selection
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

  /// return the year selection button
  Widget yearSelectionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ElevatedButton(
        onPressed: () {
          controller.monthSelectionStarted(false);
          controller
              .yearSelectionStarted(!controller.yearSelectionStarted.value);
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

  /// return the dialog footer with cancel and ok buttons
  Widget dialogFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              if (controller.yearSelectionStarted.value) {
                controller.yearSelectionStarted(false);
              } else {
                pop();
              }
            },
            child: Text(widget.cancelButtonText!,
                style: TextStyle(color: widget.highlightColor))),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            widget.onSelected(
                controller.selected.month, controller.selected.year);
            pop();
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

  /// method to close the dialog and delete the controller
  void pop() {
    Navigator.pop(context);
    Get.delete<_MonthYearController>();
  }
}
