import 'package:flutter/material.dart';
import 'package:choice/selection.dart';
import 'package:choice/inline.dart';
import 'package:choice/modal.dart';
import 'types.dart';

Future<List<T>?> createPrompt<T>({
  required BuildContext context,
  required ChoicePromptDelegate<T> delegate,
  required List<T> value,
  ValueChanged<List<T>>? onChanged,
  String? title,
  bool multiple = false,
  bool clearable = false,
  bool confirmation = false,
  bool loading = false,
  bool error = false,
  bool searchable = false,
  ValueChanged<String>? onSearch,
  required int itemCount,
  required IndexedChoiceStateBuilder<T> itemBuilder,
  ChoiceSkipCallback? itemSkip,
  ChoiceStateBuilder<T>? dividerBuilder,
  ChoiceStateBuilder<T>? leadingBuilder,
  ChoiceStateBuilder<T>? trailingBuilder,
  ChoiceStateBuilder<T>? placeholderBuilder,
  ChoiceStateBuilder<T>? errorBuilder,
  ChoiceStateBuilder<T>? loaderBuilder,
  ChoiceListBuilder? listBuilder,
  ChoiceStateBuilder<T>? modalHeaderBuilder,
  ChoiceStateBuilder<T>? modalFooterBuilder,
  ChoiceStateBuilder<T>? modalSeparatorBuilder,
  FlexFit modalFit = FlexFit.loose,
  ChoicePromptDelegate<T>? promptDelegate,
  ValueSetter<StateSetter>? onShow,
}) {
  return delegate(
    context,
    ChoiceModal<T>(
      selectionBuilder: (modalContext) => ChoiceController<T>(
        title: title,
        multiple: multiple,
        clearable: clearable,
        confirmation: confirmation,
        loading: loading,
        error: error,
        value: value,
        onChanged: onChanged,
      ).copyWith(
        search: searchable
            ? ChoiceSearchController.defaults(
                context: modalContext,
                onChanged: onSearch,
              )
            : null,
        onChanged: onChanged,
        onCloseModal: (value) {
          Navigator.maybePop(modalContext, value);
        },
      ),
      onShow: onShow,
      loading: loading,
      error: error,
      itemSkip: itemSkip,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      dividerBuilder: dividerBuilder,
      leadingBuilder: leadingBuilder,
      trailingBuilder: trailingBuilder,
      placeholderBuilder: placeholderBuilder,
      errorBuilder: errorBuilder,
      loaderBuilder: loaderBuilder,
      listBuilder: listBuilder,
      headerBuilder: modalHeaderBuilder,
      footerBuilder: modalFooterBuilder,
      separatorBuilder: modalSeparatorBuilder,
      fit: modalFit,
    ),
  );
}
