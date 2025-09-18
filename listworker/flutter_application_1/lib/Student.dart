import 'package:flutter_application_1/Person.dart';

class Student extends Person {

  String enrollment;
  Student({required String name, required this.enrollment}): super(name) ;
}