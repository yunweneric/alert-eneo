import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:eneo_fails/core/config.dart';
import 'package:eneo_fails/shared/components/bottom_sheets.dart';
import 'package:eneo_fails/shared/components/button.dart';
import 'package:eneo_fails/shared/utils/colors.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:fapshi_pay/fapshi_pay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:go_router/go_router.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  int totalAmount = 0;
  String readableAmount = "XAF0";
  TextEditingController amount_controller = TextEditingController();

  loadingUI(String text) {
    AppSheet.simpleModal(
      context: context,
      isDismissible: false,
      height: 300.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          kh10Spacer(),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  errorUI(String desc) {
    AppSheet.showErrorSheet(
      context: context,
      title: "Donation Status",
      desc: desc,
      onOkay: () => context.pop(),
    );
  }

  successUI(String desc) {
    AppSheet.showSuccessSheet(
      context: context,
      title: "Donation Status",
      desc: desc,
      onOkay: () => context.pop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SafeArea(
        child: Padding(
          padding: kAppPadding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kh20Spacer(),
              Text("Support Us!", style: Theme.of(context).textTheme.displayMedium),
              kh10Spacer(),
              Text("Supporting us, helps us build a better AI for predicting electricity outages in Cameroon"),
              kh20Spacer(),
              kh20Spacer(),
              kh20Spacer(),
              kh20Spacer(),
              kh20Spacer(),
              TextField(
                controller: amount_controller,
                keyboardAppearance: Brightness.dark,
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    locale: 'ko',
                    decimalDigits: 0,
                    symbol: 'XAF',
                  )
                ],
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "Enter amount",
                  prefixIcon: Icon(Icons.attach_money_rounded),
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                ),
                onChanged: (String val) {
                  if (val.isNotEmpty) {
                    String formattedAmount = val.split("XAF").join("").split(",").join("").trim();
                    setState(() {
                      readableAmount = val;
                      totalAmount = int.parse(formattedAmount);
                    });
                  }
                },
              ),
              kh20Spacer(),
              FapshiPay(
                amount: totalAmount,
                phone: "670912935",
                env: AppEnv.dev,
                sandboxApiUser: AppConfig.devApiUser,
                sandboxApiKey: AppConfig.devApiKey,
                liveApiUser: AppConfig.apiUser,
                liveApiKey: AppConfig.apiKey,
                title: "Donate Now",
                icon: Icon(Icons.payment, color: EneoFailsColor.kWhite),
                textStyle: TextStyle(color: EneoFailsColor.kWhite),
                initialLoadingUI: () => loadingUI("Loading ..."),
                checkPaymentLoadingUI: () {
                  context.pop();
                  loadingUI("Checking donation status!");
                },
                errorUI: (message) {
                  context.pop();
                  errorUI(message);
                },
                successUI: (paymentResponse) {
                  context.pop();
                  successUI("Thank you for donating ${paymentResponse.amount} to our project!");
                },
                buttonStyle: ElevatedButton.styleFrom(
                  padding: kPadding(10.w, 15.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onCheckPaymentSuccess: ((paymentResponse) {
                  setState(() {
                    readableAmount = "0XAF";
                    totalAmount = 0;
                    amount_controller.clear();
                  });
                }),
              ),
              kh20Spacer(),
              Center(
                child: Text(
                  "Thank you for donating $readableAmount to our project!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
