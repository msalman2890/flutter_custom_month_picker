# Flutter Custom Month Picker

A Flutter package for selecting a month and year using a dialog.

## Usage

To use this package, add flutter_custom_month_picker as a dependency in your pubspec.yaml file.

## Example

```dart
void showMonthPicker(context, onSelected: (month, year) {
      if (kDebugMode) {
        print('Selected month: $month, year: $year');
      }
    },
    initialSelectedMonth: 3,
    initialSelectedYear: 2021,
    firstYear: 2000,
    lastYear: 2025,
    firstEnabledMonth: 3,
    lastEnabledMonth: 10,
    selectButtonText: 'OK',
    cancelButtonText: 'Cancel',
    highlightColor: Colors.purple,
    textColor: Colors.black,
    contentBackgroundColor: Colors.white,
    dialogBackgroundColor: Colors.grey[200]
);
```

## Arguments

| Argument               | Type            | Description                                                                                                        |
|------------------------| --------------- |--------------------------------------------------------------------------------------------------------------------|
| context                | BuildContext    | The context in which to show the dialog.                                                                           |
| onSelected             | Function        | Called when a month is selected.                                                                                   |
| initialSelectedMonth   | int             | The initial month to select. Defaults to the current month.                                                        |
| initialSelectedYear    | int             | The initial year to select. Defaults to the current year.                                                          |
| firstYear              | int             | The first year that can be selected. Defaults to 1900.                                                             |
| lastYear               | int             | The last year that can be selected. Defaults to the current year.                                                  |
| firstEnabledMonth      | int             | The first month of the first year that can be selected. Defaults to 1.                                             |
| lastEnabledMonth       | int             | The last month of the last year that can be selected. Defaults to the 12.                                          |
| selectButtonText       | String          | The button text can be changed. Defaults to 'OK'.                                                                  |
| cancelButtonText       | String          | The button text can be changed. Defaults to 'Cancel'.                                                              |
| highlightColor         | Color           | The highlight color for the selected month and year. It will also reflected to the 'OK' button. Defaults to green. |
| textColor              | Color           | The color of the text. Defaults to black.                                                                          |
| contentBackgroundColor | Color           | The background color of the dialog content. Defaults to white.                                                     |
| dialogBackgroundColor  | Color           | The background color of the dialog. Defaults to light grey.                                                        |


## Screenshots

<img src="https://raw.githubusercontent.com/msalman2890/flutter_custom_month_picker/master/screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20Max%20-%202023-03-24%20at%2012.23.51.png" width="250" height="250">

<img src="https://raw.githubusercontent.com/msalman2890/flutter_custom_month_picker/master/screenshots/Simulator%20Screen%20Shot%20-%20iPhone%2014%20Pro%20Max%20-%202023-03-24%20at%2012.24.01.png" width="250" height="250">


## Contributing

Contributions are welcome! Please feel free to file an issue or submit a pull request.
