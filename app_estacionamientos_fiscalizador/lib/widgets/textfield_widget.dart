import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIconData,
    required this.obscureText,
    this.suffixIconData,
    required this.controller, // Agregar el controlador
  });

  final String hintText;
  final IconData prefixIconData;
  final bool obscureText;
  final IconData? suffixIconData;
  final TextEditingController controller; // controlador

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller, // Usar el controlador aquí
      obscureText: _obscureText,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: widget.hintText,
        prefixIcon: Icon(
          widget.prefixIconData,
          size: 18,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        suffixIcon: widget.suffixIconData == Icons.lock_outline
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  size: 18,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : (widget.suffixIconData != null
                ? Icon(
                    widget.suffixIconData,
                    size: 18,
                    color: Colors.black,
                  )
                : null),
        labelStyle: const TextStyle(color: Colors.black),
        focusColor: Colors.purple,
      ),
    );
  }
}
