import 'package:expensetracker/Model/my_expense_model.dart';
import 'package:expensetracker/Providers/expense_list_provider.dart';
import 'package:expensetracker/Providers/state_provider.dart';
import 'package:expensetracker/widget/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class ShowExpense extends StatefulWidget {
  ShowExpense({Key? key}) : super(key: key);
  // final List<MyExpenseModel>? expenceList;
  // Function? callBack;

  @override
  _ShowExpenseState createState() => _ShowExpenseState();
}

class _ShowExpenseState extends State<ShowExpense> {
  // Box<MyExpenseModel>? expenseBox = Hive.box<MyExpenseModel>(expenseBoxKey);
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ExpenseListProvider>(context, listen: false)
          .setExpenseList(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
        child: Consumer<ExpenseListProvider>(
          builder: (context, expenseListProviderObj, _) {
            var expenseList =
                expenseListProviderObj.searchedExpenseList.length == 0
                    ? expenseListProviderObj.expenseList
                    : expenseListProviderObj.searchedExpenseList;
            return ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: expenseList.length,
                separatorBuilder: (context, index) => SizedBox(
                      height: 2.h,
                    ),
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(expenseList[index]),
                    background: Container(
                      color: Color(0xffdbbce2),
                    ),
                    onDismissed: (DismissDirection direction) {
                      Provider.of<ExpenseListProvider>(context, listen: false)
                          .deleteExpense(context: context, index: index);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            height: 7.h,
                            width: 7.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffF7F4F7),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Image.network(
                                  "https://kaylamakes.com/wp-content/uploads/2021/02/la-jefa-e1613361381520.png"),
                            ),
                          ),
                          // backgroundImage: NetworkImage(
                          //     "https://kaylamakes.com/wp-content/uploads/2021/02/la-jefa-e1613361381520.png"),

                          SizedBox(
                            width: 2.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${expenseList[index].title}",
                                // "ngyg5t",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "${expenseList[index].description}",
                                // "hyuhyuy",
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                expenseList[index].status == true
                                    ? "- \$${expenseList[index].amount}"
                                    : "+ \$${expenseList[index].amount}"
                                        "",
                                // "128",
                                style: TextStyle(
                                    color: expenseList[index].status == true
                                        ? Colors.redAccent
                                        : Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "Date: ${DateFormat('hh:mm aa ').format(DateTime.now())}",
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(widget.expenceList![index].toJson());
                              showModalBottomSheet(
                                  context: context,
                                  builder: (ctx) => MyBottomSheet(
                                        // callBack: widget.callBack,
                                        index: expenseListProviderObj.expenseList.indexWhere((element) => element.title == expenseList[index].title),
                                        expenceModel: expenseList[index],
                                      ));
                            },
                            child: Icon(
                              Icons.edit,
                              color: Color(0xfff08768),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
