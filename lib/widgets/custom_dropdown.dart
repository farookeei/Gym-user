// import 'package:flutter/material.dart';
// import 'package:gym_user/core/themes/theme.dart';

// class CustomDropDown extends StatefulWidget {
//   final List<String> data;
//   final String title;
//   final String hintText;
//   final Function(String?)? onChnage;
//   final Function(String?)? onSaved;
//   final String? Function(String?)? validator;
//   final double marginTop;
//   final double marginbottom;

//   CustomDropDown({
//     required this.data,
//     this.marginTop = 10,
//     this.marginbottom = 10,
//     this.validator,
//     this.title = '',
//     this.hintText = '',
//     this.onChnage,
//     this.onSaved,
//   });

//   @override
//   _CustomDropDownState createState() => _CustomDropDownState();
// }

// class _CustomDropDownState extends State<CustomDropDown> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         margin:
//             EdgeInsets.only(top: widget.marginTop, bottom: widget.marginbottom),
//         padding: EdgeInsets.only(left: 14, right: 18),
//         decoration: BoxDecoration(
//             color: textformfieldfillcolor,
//             borderRadius: BorderRadius.circular(10)),
//         child: DropdownButtonFormField<String>(
//           validator: widget.validator,
//           decoration: InputDecoration(
//             border: InputBorder.none,
//           ),
//           icon: Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: Image.asset("assets/images/Bold/Arrow - Down Circle.png"),
//           ),
//           items: widget.data.map((String value) {
//             return new DropdownMenuItem<String>(
//               value: value,
//               child: new Text(
//                 value,
//                 style: Theme.of(context)
//                     .primaryTextTheme
//                     .bodyText1!
//                     .merge(TextStyle(fontWeight: FontWeight.w700)),
//               ),
//             );
//           }).toList(),
//           onChanged: widget.onChnage,
//           onSaved: widget.onSaved,
//           hint: Text(
//             widget.hintText,
//             style: Theme.of(context)
//                 .primaryTextTheme
//                 .bodyText1!
//                 .merge(TextStyle(fontWeight: FontWeight.w700)),
//           ),
//         ));
//   }
// }
