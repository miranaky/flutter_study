import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/common/utils.dart';
import 'package:thread_clone/features/authentication/repos/authentication_repo.dart';

class LoginViewModel extends AsyncNotifier {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _authRepo.signIn(
        email,
        password,
      ),
    );
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
