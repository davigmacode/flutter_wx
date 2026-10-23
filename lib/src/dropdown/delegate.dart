import 'package:flutter/material.dart';

class ChoiceDropdown extends StatefulWidget {
  const ChoiceDropdown({super.key});

  @override
  State<ChoiceDropdown> createState() => _ChoiceDropdownState();
}

class _ChoiceDropdownState extends State<ChoiceDropdown> {
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  OverlayEntry _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;

    var size = renderBox.size;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 5.0),
          child: const Material(
            elevation: 5.0,
            child: Column(
              children: [
                ListTile(
                  title: Text('India'),
                ),
                ListTile(
                  title: Text('Australia'),
                ),
                ListTile(
                  title: Text('USA'),
                ),
                ListTile(
                  title: Text('Canada'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    OverlayState? overlayState = Overlay.of(context);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlay();
        overlayState.insert(_overlayEntry!);
      } else {
        _overlayEntry?.remove();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormField(
        focusNode: _focusNode,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
