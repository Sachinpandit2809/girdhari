import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppPasswordController with ChangeNotifier {
  bool _appPasswordLoading = false;
  bool get appPasswordLoading => _appPasswordLoading;
  void setAppPasswordLoading(bool load) {
    _appPasswordLoading = load;
    notifyListeners();
  }

 
  }

