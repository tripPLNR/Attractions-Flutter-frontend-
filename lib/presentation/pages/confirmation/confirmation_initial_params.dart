
import 'dart:ui';

class ConfirmationInitialParams {
  String? title;
  String? subtitle;
  String? btnText;
  VoidCallback? btnAction;

  ConfirmationInitialParams(
      {this.title, this.subtitle, this.btnText, this.btnAction});
}
