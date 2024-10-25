// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';

class SimplePhoneNumberPicker extends StatefulWidget {
  const SimplePhoneNumberPicker({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<SimplePhoneNumberPicker> createState() =>
      _SimplePhoneNumberPickerState();
}

class _SimplePhoneNumberPickerState extends State<SimplePhoneNumberPicker> {
  final List<Map<String, String>> countries = [
    {'code': 'NO', 'name': 'Norway', 'dialCode': '+47'},
    {'code': 'DK', 'name': 'Denmark', 'dialCode': '+45'},
    {'code': 'SE', 'name': 'Sweden', 'dialCode': '+46'},
    {'code': 'FI', 'name': 'Finland', 'dialCode': '+358'},
  ];

  String selectedCountryCode = 'NO';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 70.0,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Color(0xFFE1EDF9)),
      ),
      child: Row(
        children: [
          DropdownButton<String>(
            value: selectedCountryCode,
            items: countries.map((country) {
              return DropdownMenuItem<String>(
                value: country['code'],
                child: Text('${country['name']} (${country['dialCode']})'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCountryCode = value!;
                _updateAppState();
              });
            },
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color(0xFFE1EDF9)),
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                setState(() {
                  phoneNumber = value;
                  _updateAppState();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateAppState() {
    FFAppState().update(() {
      FFAppState().phone =
          '${countries.firstWhere((country) => country['code'] == selectedCountryCode)['dialCode']}$phoneNumber';
    });
  }
}
