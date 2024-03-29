import 'redirect_popup_initial_params.dart';

class RedirectPopupState {
final bool loading;
const RedirectPopupState({required this.loading});

factory RedirectPopupState.initial({required RedirectPopupInitialParams initialParams}) => RedirectPopupState(loading: false);

RedirectPopupState copyWith({bool? loading}) => RedirectPopupState(loading: loading??this.loading);
}
