import 'package:expensetracker/widget/add_expense.dart';
import 'package:expensetracker/widget/outcome_container.dart';
import 'package:expensetracker/widget/my_text.dart';
import 'package:expensetracker/widget/show_expense.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<MyExpenseModel> expenceList = [];

  @override
  Widget build(BuildContext context) {
    // print(totalOutcome);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: AddExpense(
        // callBack: (MyExpenseModel expense) {
        //   expenceList.add(expense);
        //   // print("Expanse List Length ----------- " + expenceList.length.toString());//
        //   setState(() {});
        // },
      ),
      body: SafeArea(
        child: Column(
          children: [
            MyText(
              // callBack: (String name) {
              //   print(name);
              //   setState(() {});
              // },
            ),
            // SizedBox(height: 2.h),
            OutcomeContainer(),
            ShowExpense(),
          ],
        ),
      ),
    );
  }
}
