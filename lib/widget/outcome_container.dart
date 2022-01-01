import 'package:expensetracker/Helpers/constant.dart';
import 'package:expensetracker/Model/my_expense_model.dart';
import 'package:expensetracker/Providers/state_provider.dart';
import 'package:expensetracker/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class OutcomeContainer extends StatefulWidget {
  const OutcomeContainer({Key? key}) : super(key: key);

  @override
  _OutcomeContainerState createState() => _OutcomeContainerState();
}

class _OutcomeContainerState extends State<OutcomeContainer> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<StateProvider>(context, listen: false).getState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.h,
      width: 91.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xff41224a),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 20,
                ),
                child: Text(
                  "Outcome",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: Consumer<StateProvider>(
                  builder: (context, stateProviderObj, _) => Text.rich(TextSpan(
                      text: '\$ ',
                      style: TextStyle(color: Colors.redAccent),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '${stateProviderObj.outcomeAmount}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent),
                        )
                      ])),
                ),
                // child: Text(
                //   "\$${widget.totalOutcome}",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 22,
                //       fontWeight: FontWeight.bold),
                // ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 20,
                ),
                child: Text(
                  "Income",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: Consumer<StateProvider>(
                    builder: (context, stateProviderObj, _) =>  Text.rich(TextSpan(
                            text: '\$ ',
                            style: TextStyle(color: Colors.green),
                            children: <InlineSpan>[
                              TextSpan(
                                text: '${stateProviderObj.incomeAmount}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              )
                            ]))),
                // child: Text(
                //   "\$${widget.totalOutcome}",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 22,
                //       fontWeight: FontWeight.bold),
                // ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 20,
                ),
                child: Text(
                  "Total",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                ),
                child: Consumer<StateProvider>(
                    builder: (context, stateProviderObj, _) =>  Text.rich(TextSpan(
                            text: "\$",
                            style: TextStyle(color: Colors.white),
                            children: <InlineSpan>[
                              TextSpan(
                                text: (stateProviderObj.incomeAmount - stateProviderObj.outcomeAmount)
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )
                            ]))),
                // child: Text(
                //   "\$${widget.totalOutcome}",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 22,
                //       fontWeight: FontWeight.bold),
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
