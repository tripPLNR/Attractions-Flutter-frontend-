import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:triplaner/domain/usecases/create_account_usecase.dart';
import 'package:triplaner/presentation/pages/main/bottom_navigation/bottom_navigation_initial_params.dart';
import 'package:triplaner/util/alert/app_snackbar.dart';
import 'signup_initial_params.dart';
import 'signup_state.dart';
import 'signup_navigator.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupNavigator navigator;
  SignupInitialParams initialParams;
  AppSnackBar snackBar;
  CreateAccountUseCase createAccountUseCase;
  SignupCubit(
      {required this.navigator,
      required this.initialParams,
      required this.snackBar,
      required this.createAccountUseCase,
      })
      : super(SignupState.initial(initialParams: initialParams));

  BuildContext get context => navigator.context;



  final txtFirstName = TextEditingController();
  final txtLastName = TextEditingController();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();

  String firstName="",lastName="",email = "", password = "";

  _getValues(){
    firstName=txtFirstName.text;
    lastName=txtLastName.text;
    email=txtEmail.text.trim();
    password=txtPassword.text;
  }

  bool _isEmpty() {
    if (email.isEmpty || password.isEmpty || firstName.isEmpty||lastName.isEmpty) {
      snackBar.show(
          context: navigator.context, info: "Please fill all fields.",snackBarType: SnackBarType.INFO);
      return true;
    }
    return false;
  }

  Future<void> signUpAction() async {
    _getValues();
    if(_isEmpty())return;
    try{
      emit(state.copyWith(loading: true));
      await createAccountUseCase.execute(email: email, password: password,firstName: firstName,lastName: lastName);
      emit(state.copyWith(loading: false));
      navigator.openBottomNavigation(const BottomNavigationInitialParams());
    }catch(e){
      emit(state.copyWith(loading: false));
      snackBar.show(context: context, info: e.toString());
    }
  }



  togglePassword(){
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }
  toggleConfirmPassword(){
    emit(state.copyWith(confirmPasswordVisible: !state.confirmPasswordVisible));
  }

  loginAction(){
    Navigator.pop(context);
  }
}
