import 'package:expensetracker/Helpers/constant.dart';
import 'package:expensetracker/Model/my_expense_model.dart';
import 'package:expensetracker/Providers/expense_list_provider.dart';
import 'package:expensetracker/Providers/state_provider.dart';
import 'package:expensetracker/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

//hive key
const String expenseBoxKey = "expenseBox";
// const String stateBoxKey = "stateBox";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(MyExpenseModelAdapter());
  // Hive.registerAdapter(StateModelAdapter());
  await Hive.openBox<MyExpenseModel>(expenseBoxKey);
  // await Hive.openBox(stateBoxKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:  (context) => StateProvider()),
        ChangeNotifierProvider(create:  (context) => ExpenseListProvider()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Expense Tracker',
          theme: ThemeData(
            canvasColor: Colors.transparent,
            primarySwatch: Colors.deepPurple,
          ),
          home: HomeScreen(),
        );
        }
      ),
    );
  }
}

