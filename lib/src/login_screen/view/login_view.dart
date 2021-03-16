import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_buttons/auth_buttons.dart' show GoogleAuthButton;

import '../login_screen.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginSocialCubit = LoginSocialCubit();

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
              cubit: loginSocialCubit,
              builder: (_, __) => Container(
                  alignment: Alignment.center,
                  child: GoogleAuthButton(
                      onPressed: () => loginSocialCubit.onGoogleClicked(),
                      darkMode: false)),
              listener: (_, __) {},
            ),
          ),
        ));
  }
}
