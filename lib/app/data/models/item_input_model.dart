import 'package:flutter/material.dart';

class ItemInput {
  TextEditingController incomeNameController;
  TextEditingController incomePriceController;
  TextEditingController expenseNameController;
  TextEditingController expensePriceController;

  ItemInput()
    : incomeNameController = TextEditingController(),
      incomePriceController = TextEditingController(),
      expenseNameController = TextEditingController(),
      expensePriceController = TextEditingController();
}
