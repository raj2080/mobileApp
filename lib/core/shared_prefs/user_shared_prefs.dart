import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../failure/failure.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
  return UserSharedPrefs();
});

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // Set user token
  Future<Either<Failure, bool>> setUserToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('token', token);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get user token
  Future<Either<Failure, String?>> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString('token');
      return right(token);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete token
  Future<Either<Failure, bool>> deleteUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('token');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> setUserId(String userId) async {
    try {
      await _initSharedPreferences();
      await _sharedPreferences.setString('userId', userId);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, String?>> getUserId() async {
    try {
      await _initSharedPreferences();
      final userId = _sharedPreferences.getString('userId');
      return right(userId);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> deleteUserId() async {
    try {
      await _initSharedPreferences();
      await _sharedPreferences.remove('userId');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> setFirstName(String firstName) async {
    try {
      await _initSharedPreferences();
      await _sharedPreferences.setString('firstName', firstName);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get first name
  Future<Either<Failure, String?>> getFirstName() async {
    try {
      await _initSharedPreferences();
      final firstName = _sharedPreferences.getString('firstName');
      return right(firstName);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete first name
  Future<Either<Failure, bool>> deleteFirstName() async {
    try {
      await _initSharedPreferences();
      await _sharedPreferences.remove('firstName');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Set last name
  Future<Either<Failure, bool>> setLastName(String lastName) async {
    try {
      await _initSharedPreferences();
      await _sharedPreferences.setString('lastName', lastName);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get last name
  Future<Either<Failure, String?>> getLastName() async {
    try {
      await _initSharedPreferences();
      final lastName = _sharedPreferences.getString('lastName');
      return right(lastName);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete last name
  Future<Either<Failure, bool>> deleteLastName() async {
    try {
      await _initSharedPreferences();
      await _sharedPreferences.remove('lastName');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Set email
  Future<Either<Failure, bool>> setEmail(String email) async {
    try {
      await _initSharedPreferences();
      await _sharedPreferences.setString('email', email);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get email
  Future<Either<Failure, String?>> getEmail() async {
    try {
      await _initSharedPreferences();
      final email = _sharedPreferences.getString('email');
      return right(email);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete email
  Future<Either<Failure, bool>> deleteEmail() async {
    try {
      await _initSharedPreferences();
      await _sharedPreferences.remove('email');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Set phone number
  Future<Either<Failure, bool>> setPhone(int phone) async {
    try {
      await _initSharedPreferences();
      await _sharedPreferences.setInt('phone', phone);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get phone number
  Future<Either<Failure, int>> getPhone() async {
    try {
      await _initSharedPreferences();
      final phone = _sharedPreferences.getInt('phone');
      return right(phone!);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete phone number
  Future<Either<Failure, bool>> deletePhone() async {
    try {
      await _initSharedPreferences();
      await _sharedPreferences.remove('phone');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
