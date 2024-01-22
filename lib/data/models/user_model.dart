import 'package:equatable/equatable.dart';

class SupaUser extends Equatable {
  final int? id;
  final String? fname;
  final String? lname;
  final String? uname;
  final String? email;
  final String? phone;
  final String? pass;

  const SupaUser({
    required this.id,
    required this.fname,
    required this.lname,
    required this.uname,
    required this.email,
    required this.phone,
    required this.pass,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

//FIXME - Add Onchanged parameters
  static SupaUser nullUser = const SupaUser(
    id: -1,
    fname: 'No First Name Specified',
    lname: 'No Last Name Specified',
    uname: 'No User Name Specified',
    email: 'No Email Specified',
    phone: 'No Phone number Specified',
    pass: 'No Password Specified',
  );
}
