import 'package:flutter/material.dart';
import 'package:choice/selection.dart';
import 'package:choice/inline.dart';
import 'package:choice/utils.dart';
import 'header.dart';
import 'search.dart';
import 'footer.dart';
import 'separator.dart';
import 'button.dart';

class ChoiceModal<T> extends ChoiceList<T> {
  ChoiceModal({
    super.key,
    required this.selectionBuilder,
    required super.itemCount,
    required super.itemBuilder,
    super.itemSkip,
    super.dividerBuilder,
    super.leadingBuilder,
    super.trailingBuilder,
    super.placeholderBuilder,
    super.errorBuilder,
    super.loaderBuilder,
    super.loading = false,
    super.error = false,
    this.headerBuilder,
    this.footerBuilder,
    this.separatorBuilder,
    this.onWillClose,
    this.onShow,
    this.fit = FlexFit.loose,
    ChoiceListBuilder? listBuilder,
  }) : super(builder: listBuilder ?? defaultListBuilder);

  static final defaultListBuilder = ChoiceList.createVirtualized();

  final ChoiceController<T> Function(BuildContext context) selectionBuilder;

  /// {@template choice.modal.headerBuilder}
  /// Called to build modal header widget
  /// {@endtemplate}
  final ChoiceStateBuilder<T>? headerBuilder;

  /// {@template choice.modal.footerBuilder}
  /// Called to build modal footer widget
  /// {@endtemplate}
  final ChoiceStateBuilder<T>? footerBuilder;

  /// {@template choice.modal.separatorBuilder}
  /// Called to build modal separator widget
  /// {@endtemplate}
  final ChoiceStateBuilder<T>? separatorBuilder;

  /// {@template choice.modal.onWillClose}
  /// Called to veto attempts by the user to dismiss the enclosing [ModalRoute].
  ///
  /// If the callback returns a Future that resolves to false, the enclosing route will not be popped.
  /// {@endtemplate}
  final Future<bool> Function()? onWillClose;

  final ValueSetter<StateSetter>? onShow;

  /// {@template choice.modal.fit}
  /// How a flexible modal body is inscribed into the available space.
  ///
  /// If [flex] is non-zero, the [fit] determines whether
  /// the modal body fills the space the parent makes available during layout.
  /// If the fit is [FlexFit.tight], the modal body is required to fill the available space.
  /// If the fit is [FlexFit.loose], the modal body can be at most as large as the available space
  /// (but is allowed to be smaller).
  /// {@endtemplate}
  final FlexFit fit;

  static ChoiceStateBuilder<T> createSpacer<T>({
    Key? key,
    double? width,
    double? height,
    Widget? child,
  }) {
    return (_) => SizedBox(
          key: key,
          width: width,
          height: height,
          child: child,
        );
  }

  static const createHeader = ChoiceModalHeader.create;

  static const createSearchField = ChoiceSearchField.create;

  static const createSearchToggle = ChoiceSearchToggle.create;

  static const createFooter = ChoiceModalFooter.create;

  static const createSeparator = ChoiceModalSeparator.create;

  static const createConfirmButton = ChoiceConfirmButton.create;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillClose,
      child: ChoiceProvider<T>.builder(
        controller: selectionBuilder(context),
        builder: (state, _) {
          return SafeStatefulBuilder(builder: (_, rebuild) {
            onShow?.call(rebuild);
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                headerBuilder?.call(state),
                if (headerBuilder != null) separatorBuilder?.call(state),
                Flexible(fit: fit, child: super.build(context)),
                if (footerBuilder != null) separatorBuilder?.call(state),
                footerBuilder?.call(state),
              ].whereType<Widget>().toList(),
            );
          });
        },
      ),
    );
  }
}
