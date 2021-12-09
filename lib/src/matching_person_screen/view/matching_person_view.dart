import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../utility/nav_util.dart';
import '../../utility/string_const.dart';
import '../matching_person_screen.dart';

class MatchingPersonView extends StatelessWidget {
  const MatchingPersonView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var matchingPersonSearchCubit = MatchingPersonSearchCubit();

    return MultiBlocProvider(
        providers: [
          BlocProvider<MatchingPersonSearchCubit>(
            create: (_) => MatchingPersonSearchCubit(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(title: Text(StringConstant.appName)),
          body: SizedBox.expand(
            child: BlocConsumer<MatchingPersonSearchCubit,
                MatchingPersonSearchState>(
              bloc: matchingPersonSearchCubit,
              builder: (_, state) {
                if (state.runtimeType == MatchingPersonSearchOppositeExists) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    navigateToAndRemoveUntil(
                        context, StringConstant.routeMain, null);
                  });
                }

                return Container(
                  alignment: Alignment.center,
                  child: Column(children: <Widget>[
                    DropdownSearch<String>(),
                    ElevatedButton(
                        onPressed: () =>
                            matchingPersonSearchCubit.onContinueButtonClicked(),
                        child: Text("Continue")),
                  ]),
                );
              },
              listener: (context, state) {
                switch (state.runtimeType) {
                  case MatchingPersonSearchSelectedState:
                    navigateToAndRemoveUntil(
                        context, StringConstant.routeMain, null);
                    break;
                }
              },
            ),
          ),
        ));
  }
}
