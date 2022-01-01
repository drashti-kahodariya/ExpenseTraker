import 'package:expensetracker/Providers/expense_list_provider.dart';
import 'package:expensetracker/Providers/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MyText extends StatefulWidget {
  MyText({Key? key}) : super(key: key);
  // Function? callBack;


  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  // bool _isSearch = false;

  @override
  Widget build(BuildContext context) {

    return Consumer<ExpenseListProvider>(
      builder: (context,expenseListProviderObj,_)=>
       expenseListProviderObj.isSearch  ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          onChanged: (v){
            expenseListProviderObj.searchExpence(searchText: v);
            // expenseListProviderObj.changeSearchState();
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            suffixIcon: IconButton(icon: Icon(Icons.check),onPressed: (){

              setState(() {
                expenseListProviderObj.changeSearchState();

             });

            },),
            prefixIcon: Icon(Icons.search_outlined)
          ),
        ),
      ):Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 5.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello,",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                ),
              ),
              Text(
                "Priscilla",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            width: 45.w,
          ),
          GestureDetector(
            onTap: (){
              Provider.of<ExpenseListProvider>(context, listen: false).changeSearchState();

              setState(() {

              });
            },
            child: Container(
              height: 5.h,
              width: 11.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black12)),
              child: Icon(Icons.search_outlined, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
