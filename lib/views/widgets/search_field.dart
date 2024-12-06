import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String> onChanged;
  final String hintText;
  final IconData prefixIcon;

  const SearchField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.onChanged,
    this.hintText = 'Search',
    this.prefixIcon = Icons.search,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey[600],
            ),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: Colors.grey[600],
            ),
            suffixIcon: _isFocused
                ? IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () {
                      widget.controller.clear();
                      widget.onChanged('');
                      _focusNode.unfocus();
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 5),
          ),
          onChanged: widget.onChanged,
          onTapOutside: (_) {
            _focusNode.unfocus();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
} 