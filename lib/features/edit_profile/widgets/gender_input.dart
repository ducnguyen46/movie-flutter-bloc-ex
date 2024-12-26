import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/core/common/widgets/custom_text_field.dart';
import '../../../core/common/translations/l10n.dart';
import '../bloc/edit_profile_bloc.dart';

class GenderInput extends StatelessWidget {
  final EditProfileBloc bloc;
  const GenderInput({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        return CustomTextField(
          hintText: S.of(context).hint_text_gender,
          maxLength: 55,
          icRight: 'assets/icons/ic_arrow_dropdown.svg',
          actionRight: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onChanged: (val) => bloc.add(EditProfileEvent.onChangeGender(val)),
        );
      },
    );
  }
}
