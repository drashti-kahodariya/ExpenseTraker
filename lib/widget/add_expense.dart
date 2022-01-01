import 'dart:math';

// import 'package:expensetracker/Model/expense_model.dart';
import 'package:expensetracker/Helpers/constant.dart';
import 'package:expensetracker/Model/my_expense_model.dart';
import 'package:expensetracker/Providers/expense_list_provider.dart';
import 'package:expensetracker/Providers/state_provider.dart';
import 'package:expensetracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

enum Status { Send, Recive }

class AddExpense extends StatefulWidget {
  AddExpense({Key? key}) : super(key: key);
  // Function? callBack;

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (ctx) => MyBottomSheet(
                // callBack: widget.callBack,
                ));
      },
      child: Icon(
        Icons.add,
        size: 3.h,
      ),
      backgroundColor: Color(0xfff08768),
      splashColor: Color(0xff90659a).withOpacity(1),
    );
  }
}

class MyBottomSheet extends StatefulWidget {
  MyBottomSheet({Key? key, this.expenceModel, this.index}) : super(key: key);
  final MyExpenseModel? expenceModel;
  // Function? callBack;
  final int? index;
  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  bool _flag = false;
  var _titleController = TextEditingController();
  var _decriptionController = TextEditingController();
  var _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _character = Status.Send;
  var rng = new Random();
  // Box<MyExpenseModel>? expenseBox = Hive.box<MyExpenseModel>(expenseBoxKey);
  // Box? stateBox = Hive.box(stateBoxKey);

  @override
  void initState() {
    super.initState();
    if (widget.expenceModel != null) {
      _titleController.text = widget.expenceModel!.title!;
      _decriptionController.text = widget.expenceModel!.description!;
      _amountController.text = widget.expenceModel!.amount!;
      _character =
          widget.expenceModel!.status! == true ? Status.Send : Status.Recive;


    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xffdbbce2),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 28.0, right: 28, left: 28),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter tittle!';
                  }
                },
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Color(0xff41224a))),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: " Enter tittle",
                  // labelText: "Tittle"
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              TextFormField(
                controller: _decriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter description!';
                  }
                },
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Color(0xff41224a))),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: " Enter description",
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              TextFormField(
                controller: _amountController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter amount!';
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Color(0xff41224a))),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: " Enter amount",
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              // Row(
              //   children: [

              Container(
                height: 6.h,
                // width: 150,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Send'),
                        leading: Radio<Status>(
                          value: Status.Send,
                          groupValue: _character,
                          onChanged: (Status? value) {
                            setState(() {
                              _character = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Recive'),
                        leading: Radio<Status>(
                          value: Status.Recive,
                          groupValue: _character,
                          onChanged: (Status? value) {
                            setState(() {
                              _character = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: Text(widget.expenceModel != null ? "Edit" : "Add"),
                    onPressed: () {
                      _add();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff41224a),
                      elevation: 15,
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      elevation: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _add() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      MyExpenseModel expenseValue = MyExpenseModel(
          title: _titleController.text,
          description: _decriptionController.text,
          amount: _amountController.text,
          status: _character == Status.Send ? true : false);
      var expenseListProviderObj =
          Provider.of<ExpenseListProvider>(context, listen: false);
      if (widget.expenceModel != null) {
        if(expenseListProviderObj.searchedExpenseList.length != 0)
          {
            expenseListProviderObj.changeSearchState();

          }
        expenseListProviderObj.resetSearch();

        expenseListProviderObj.editExpense(
            expenseValue: expenseValue, index: widget.index!, context: context);


      } else {
        expenseListProviderObj.addExpense(
            expenseValue: expenseValue, context: context);
        expenseListProviderObj.changeSearchState();
      }
      _titleController.clear();
      _decriptionController.clear();
      _amountController.clear();
    }
  }
}
