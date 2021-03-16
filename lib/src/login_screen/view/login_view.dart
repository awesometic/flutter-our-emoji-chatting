import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                child: Text('Google sign-in button should be here'),
              ),
              listener: (_, __) {},
            ),
          ),
        ));
  }
}
