import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? placeholder;
  final bool isPrice;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isDisabled;

  const TextInput({
    super.key,
    required this.controller,
    required this.label,
    this.placeholder,
    this.isPrice = false,
    this.keyboardType,
    this.validator,
    this.isDisabled = false,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!widget.isDisabled) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isExpanded = _isFocused || widget.controller.text.isNotEmpty;

    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _isFocused ? Colors.black : Colors.grey.withOpacity(0.3),
          width: _isFocused ? 2 : 1.5,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: isExpanded ? 18 : 0,
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: widget.keyboardType,
                  validator: widget.validator,
                  enabled: !widget.isDisabled,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText: !isExpanded ? widget.label : widget.placeholder,
                    hintStyle: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: !isExpanded ? 16 : 14,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (widget.isPrice)
                Icon(
                  Icons.attach_money,
                  color: Colors.grey[600],
                  size: 20,
                ),
            ],
          ),
        ],
      ),
    );
  }
} 