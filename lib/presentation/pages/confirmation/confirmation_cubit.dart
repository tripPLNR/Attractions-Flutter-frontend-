import 'package:flutter_bloc/flutter_bloc.dart';
import 'confirmation_initial_params.dart';
import 'confirmation_state.dart';
import 'confirmation_navigator.dart';


class ConfirmationCubit extends Cubit<ConfirmationState> {
ConfirmationNavigator navigator;
ConfirmationInitialParams initialParams;
ConfirmationCubit({required this.navigator,required this.initialParams}) : super(ConfirmationState.initial(initialParams:initialParams));
 get title => initialParams.title;
 get subTitle => initialParams.subtitle;
 get btnText => initialParams.btnText;
 get btnAction => initialParams.btnAction;

}
