import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_buttons/auth_buttons.dart' show GoogleAuthButton;
import 'package:loading_overlay/loading_overlay.dart';

import '../../utility/nav_util.dart';
import '../../utility/string_const.dart';
import '../login_screen.dart';

class LogInView extends StatelessWidget {
  const LogInView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginSocialCubit = LoginSocialCubit();
    var isLoading = false;

    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginSocialCubit>(
            create: (_) => LoginSocialCubit(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(title: Text("Our Emoji Chatting")),
          body: SizedBox.expand(
            child: BlocConsumer<LoginSocialCubit, LoginSocialState>(
              bloc: loginSocialCubit,
              builder: (_, __) => Container(
                  alignment: Alignment.center,
                  child: LoadingOverlay(
                    child: Container(
                      alignment: Alignment.center,
                      child: GoogleAuthButton(
                        onPressed: () => loginSocialCubit.onGoogleClicked(),
                      ),
                    ),
                    isLoading: isLoading,
                  )),
              listener: (context, state) {
                log("login_view.dart: changing state: $state");

                switch (state.runtimeType) {
                  case LoadingState:
                    isLoading = true;
                    break;
                  case LogInState:
                    isLoading = false;
                    navigateToAndRemoveUntil(
                        context, StringConstant.routeMainBottomNav, null);
                    break;
                  case LoadedState:
                    isLoading = false;
                    break;
                  case ErrorState:
                    isLoading = false;
                    break;
                  case InitialState:
                    isLoading = false;
                    break;
                }
              },
            ),
          ),
        ));
  }
}
