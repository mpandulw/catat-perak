import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:get/get.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D3748),

      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Verify OTP.',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  "Input your One Time Password Here!",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child:
                  controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 27.5),

                              Align(
                                alignment: Alignment.center,
                                child: const Text(
                                  "Please enter the 6-digit code sent to your email!",
                                ),
                              ),

                              const SizedBox(height: 7.5),

                              // TextFormField for username
                              OtpTextField(
                                numberOfFields: 6,
                                onSubmit: (value) {
                                  controller.otp.value = value;
                                  controller.verifyOtp();
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                ),
                              ),

                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
