import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:eneo_fails/app/payment/data/model/initialize_payment_request_model/initialize_payment_request_model.dart';
import 'package:eneo_fails/app/payment/logic/payment/payment_bloc.dart';
import 'package:eneo_fails/core/service_locators.dart';
import 'package:eneo_fails/shared/components/bottom_sheets.dart';
import 'package:eneo_fails/shared/utils/colors.dart';
import 'package:eneo_fails/shared/utils/language_util.dart';
import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  final paymentBloc = getIt.get<PaymentBloc>();
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
              Text(LangUtil.trans("donate.support_us"), style: Theme.of(context).textTheme.displayMedium),
              kh10Spacer(),
              Text(LangUtil.trans("donate.support_desc")),
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
                  hintText: LangUtil.trans("donate.enter_amount"),
                  prefixIcon: Icon(Icons.credit_card),
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
              ElevatedButton(
                onPressed: () {
                  if (totalAmount < 0) return;
                  final model = InitializePaymentRequestModel(
                    totalAmount: totalAmount,
                    currency: 'XAF',
                    transactionId: "transactionId",
                    returnUrl: 'returnUrl',
                    notifyUrl: 'notifyUrl',
                    paymentCountry: 'CM',
                  );
                  paymentBloc.add(PaymentInitializeEvent(model: model));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(kWidth(context)),
                  padding: kPadding(10.w, 12.h),
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: radiusM(),
                  ),
                ),
                child: Text(
                  LangUtil.trans("donate.donate"),
                  style: TextStyle(color: EneoFailsColor.kWhite),
                ),
              ),
              kh20Spacer(),
              Center(
                child: Text(
                  LangUtil.trans("donate.thanks", args: {"amount": readableAmount}),
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
