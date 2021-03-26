import 'dart:developer';

import 'package:auth_buttons/res/buttons/apple_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_buttons/auth_buttons.dart' show GoogleAuthButton;
import 'package:loading_overlay/loading_overlay.dart';

import '../../authentication/constant/auth_type.dart';
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
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              GoogleAuthButton(
                                onPressed: () =>
                                    loginSocialCubit.onSocialLoginButtonClicked(
                                        AuthType.google),
                              ),
                              AppleAuthButton(
                                onPressed: () => loginSocialCubit
                                    .onSocialLoginButtonClicked(AuthType.apple),
                              ),
                            ])),
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
                        context, StringConstant.routeMatchPerson, null);
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
