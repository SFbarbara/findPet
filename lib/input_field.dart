import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  final String rotulo;
  final IconData icone;
  final bool senha;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String?)? onsaved;
  final TextInputType? inputType;

  final List<TextInputFormatter>? inputFormatters;

  final int? maxLength;

  const InputField(this.rotulo, this.icone, this.senha,
      {Key? key,
      this.initialValue,
      this.validator,
      this.onsaved,
      this.inputType,
      this.inputFormatters,
      this.maxLength})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool ver = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: widget.initialValue,
        obscureText: widget.senha && !ver,
        decoration: InputDecoration(
            labelText: widget.rotulo,
            border: const OutlineInputBorder(),
            prefixIcon: Icon(widget.icone),
            suffixIcon: widget.senha
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        ver = !ver;
                      });
                    },
                    icon: Icon(ver ? Icons.visibility_off : Icons.visibility),
                  )
                : null),
        validator: widget.validator,
        onSaved: widget.onsaved,
      ),
    );
  }
}
