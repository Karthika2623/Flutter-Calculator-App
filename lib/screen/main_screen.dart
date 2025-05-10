import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_calculator_app/controller/calculate_controller.dart';
import 'package:flutter_calculator_app/controller/theme_controller.dart';
import 'package:flutter_calculator_app/utils/colors.dart';
import 'package:flutter_calculator_app/widget/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    "00",
    ".",
    "=",
  ];

 @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    var controller = Get.find<CalculateController>();
    var themeController = Get.find<ThemeController>();

    return GetBuilder<ThemeController>(builder: (context) {
      return Scaffold(
        backgroundColor: themeController.isDark
            ? DarkColors.scaffoldBgColor
            : LightColors.scaffoldBgColor,
        body: Column(
          children: [
            GetBuilder<CalculateController>(builder: (context) {
              return outPutSection(
                  themeController, controller, screenWidth, screenHeight);
            }),
            inPutSection(themeController, controller, screenWidth),
          ],
        ),
      );
    });
  }

  /// In put Section - Enter Numbers
  Widget inPutSection(ThemeController themeController,
      CalculateController controller, double screenWidth) {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.01),
        decoration: BoxDecoration(
          color: themeController.isDark
              ? DarkColors.sheetBgColor
              : LightColors.sheetBgColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: buttons.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: screenWidth * 0.02,
            mainAxisSpacing: screenWidth * 0.02,
          ),
          itemBuilder: (context, index) {
            final isOp = isOperator(buttons[index]);
            final color = isOp
                ? LightColors.operatorColor
                : themeController.isDark
                    ? DarkColors.btnBgColor
                    : LightColors.btnBgColor;
            final textColor = isOp
                ? Colors.white
                : themeController.isDark
                    ? Colors.white
                    : Colors.black;

            final baseButton = CustomAppButton(
              buttonTapped: () {
                if (index == 0) {
                  controller.clearInputAndOutput();
                } else if (index == 1) {
                  controller.deleteBtnAction();
                } else if (index == 19) {
                  controller.equalPressed();
                } else {
                  controller.onBtnTapped(buttons, index);
                }
              },
              color: (index == 0 || index == 1 || index == 19)
                  ? (themeController.isDark
                      ? DarkColors.leftOperatorColor
                      : LightColors.leftOperatorColor)
                  : color,
              textColor: (index == 0 || index == 1 || index == 19)
                  ? (themeController.isDark
                      ? DarkColors.btnBgColor
                      : LightColors.btnBgColor)
                  : textColor,
              text: buttons[index],
            );

            return baseButton;
          },
        ),
      ),
    );
  }

/// Out put Section - Show Result
  Widget outPutSection(ThemeController themeController,
      CalculateController controller, double screenWidth, double screenHeight) {
    return Expanded(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.05),
            child: GetBuilder<ThemeController>(builder: (controller) {
              return AdvancedSwitch(
                controller: controller.switcherController,
                activeImage: const AssetImage('assets/day_sky.png'),
                inactiveImage: const AssetImage('assets/night_sky.jpg'),
                activeColor: Colors.green,
                inactiveColor: Colors.grey,
                activeChild: Text(
                  'Day',
                  style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.045,
                  ),
                ),
                inactiveChild: Text(
                  'Night',
                  style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.042,
                  ),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(1000)),
                width: screenWidth * 0.25,
                height: screenHeight * 0.06,
                enabled: true,
                disabledOpacity: 0.5,
              );
            }),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: screenWidth * 0.05, top: screenHeight * 0.08),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    controller.userInput,
                    style: GoogleFonts.ubuntu(
                      color:
                          themeController.isDark ? Colors.white : Colors.black,
                      fontSize: screenWidth * 0.07,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    controller.userOutput,
                    style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      color:
                          themeController.isDark ? Colors.white : Colors.black,
                      fontSize: screenWidth * 0.11,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// is Operator Check
  bool isOperator(String y) {
    if (y == "%" || y == "/" || y == "x" || y == "-" || y == "+" || y == "=") {
      return true;
    }
    return false;
  }
}
