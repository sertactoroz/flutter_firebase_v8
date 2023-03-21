// import 'package:flutter/material.dart';

// class AreYouSurePopUp extends StatelessWidget {
//   Future<void> _showConfirmationDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirmation'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Are you sure you want to perform this action?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Yes'),
//               onPressed: () {
//                 // Perform the action here
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('No'),
//               onPressed: () {
//                 // Dismiss the dialog
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Show Confirmation'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _showConfirmationDialog(context);
//           },
//           child: Text('Perform Action'),
//         ),
//       ),
//     );
//   }
// }
