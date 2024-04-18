import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:eneo_fails/shared/components/button.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterwave_standard/flutterwave.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  handlePaymentInitialization() async {
    final Customer customer = Customer(name: "Flutterwave Developer", phoneNumber: "1234566677777", email: "customer@customer.com");
    final Flutterwave flutterwave = Flutterwave(
      context: context,
      publicKey: "Public Key-here",
      currency: "currency-here",
      redirectUrl: "add-your-redirect-url-here",
      txRef: "add-your-unique-reference-here",
      amount: "3000",
      customer: customer,
      paymentOptions: "ussd, card, barter, payattitude",
      customization: Customization(title: "My Payment"),
      isTestMode: true,
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
              Text(
                "Support Us!",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              kh10Spacer(),
              Text(
                "Supporting us, helps us build a better AI for predicting electricity outages in Cameroon",
                // style: Theme.of(context).textTheme.bodySmall,
              ),
              kh20Spacer(),
              kh20Spacer(),
              kh20Spacer(),
              kh20Spacer(),
              kh20Spacer(),
              TextField(
                keyboardAppearance: Brightness.dark,
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    locale: 'ko',
                    decimalDigits: 0,
                    symbol: 'FCFA',
                  )
                ],
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  hintText: "Enter amount",
                  prefixIcon: Icon(Icons.attach_money_rounded),
                  // prefix: Container(color: Colors.teal, height: 45.h, child: Text("Enter Amount")),
                  // suffix: Text("FCFA"),
                  hintStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              kh10Spacer(),
              AppButtons.submitButton(
                context: context,
                onPressed: () {},
                text: "Donate",
              )
            ],
          ),
        ),
      ),
    );
  }
}
