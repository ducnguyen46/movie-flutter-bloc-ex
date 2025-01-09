import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/bloc/page_command.dart';
import 'package:movie/core/common/contants/routers.dart';
import 'package:movie/di/dependency_injection.dart';
import 'package:movie/features/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:movie/features/auth/sign_up/widgets/email_input.dart';
import 'package:movie/features/auth/sign_up/widgets/password_input.dart';
import '../../../core/common/translations/l10n.dart';
import '../../../core/common/widgets/custom_button.dart';
import '../../../core/common/widgets/svg_widget.dart';
import '../login/widgets/sign_up_or_sign_in_social.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = getIt.get<SignUpBloc>();
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: 24,
        ),
        child: BlocProvider(
          create: (context) => bloc,
          child: BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state.pageCommand is PageCommandNavigatorPage) {
                final pageCommand = state.pageCommand as PageCommandNavigatorPage;
                if (pageCommand.page == loginRoute) {
                  Navigator.pop(context, pageCommand.argument);
                }
              }
              bloc.add(SignUpEvent.onClearPage());
            },
            child: Column(
              children: [
                const SvgWidget(
                  ic: 'assets/icons/ic_logo.svg',
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  S.of(context).title_create_your_account,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 22),
                ),
                const SizedBox(
                  height: 32,
                ),
                EmailInput(bloc: bloc),
                const SizedBox(
                  height: 16,
                ),
                PasswordInput(bloc: bloc),
                const SizedBox(
                  height: 24,
                ),
                BlocBuilder<SignUpBloc, SignUpState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return CustomButton(
                        btnText: S.of(context).btn_sign_up,
                        enable: state.isEnable,
                        action: () => bloc.add(SignUpEvent.onSignUp(context)));
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Expanded(child: Divider()),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      S.of(context).txt_or_continue_with,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Expanded(child: Divider()),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SignUpOrSignInSocial(
                  onPressedFaceBook: () => bloc.add(SignUpEvent.onSignUpFacebook()),
                  onPressedGoogle: () => bloc.add(SignUpEvent.onSignUpGoogle()),
                  onPressedApple: () => bloc.add(SignUpEvent.onSignUpApple()),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    text: TextSpan(
                        text: S.of(context).txt_already_have_an_account,
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                      TextSpan(
                        text: S.of(context).txt_sign_in,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Theme.of(context).primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pop(context),
                      ),
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
