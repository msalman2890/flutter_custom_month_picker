import 'package:flutter/material.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Month Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  final date = await showMonthPicker(context,
                      initial: time,
                      firstEnabledMonth: 3,
                      lastEnabledMonth: 10,
                      firstYear: 2000,
                      lastYear: 2025,
                      selectButtonText: 'OK',
                      cancelButtonText: 'Cancel',
                      highlightColor: Colors.purple,
                      textColor: Colors.black,
                      contentBackgroundColor: Colors.white,
                      dialogBackgroundColor: Colors.grey[200]);
                  if (date != null) {
                    setState(() {
                      time = date;
                    });
                  }
                },
                child: const Text('Show Month Picker')),
            Text('Selected month: ${time.month}, year: ${time.year}')
          ],
        ),
      ),
    );
  }
}
