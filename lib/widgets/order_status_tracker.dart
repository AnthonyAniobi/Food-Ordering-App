import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ordering_app/constants/app_images.dart';

class OrderStatusTracker extends StatelessWidget {
  final String status;

  const OrderStatusTracker({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    int statusIndex = switch (status) {
      'confirmed' => 1,
      'pending' => 0,
      'cancelled' => -1,
      'dispatched' => 2,
      'delivered' => 3,
      _ => 0,
    };

    return SizedBox(
      height: 86,
      width: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                statusText('Confirmation', 0 <= statusIndex),
                statusText('Preparing', 1 <= statusIndex),
                statusText('Dispatched', 2 <= statusIndex),
                statusText('Delivered', 3 <= statusIndex),
              ],
            ),
          ),

          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double fraction = (statusIndex.clamp(0, 3) / 3);
                  return Container(
                    width: constraints.maxWidth * fraction,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.white, Colors.green.withAlpha(180)],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: LinearProgressIndicator(
              value: statusIndex / 3,
              minHeight: 7,
              color: Colors.green,
              backgroundColor: Color(0xFFD9D9D9),
            ),
          ),

          Align(
            alignment: Alignment(-0.4, 0),
            child: statusIcon(AppSvg.dropFilled, 1 <= statusIndex),
          ),

          Align(
            alignment: Alignment(0.36, 0),
            child: statusIcon(AppSvg.dispatchedOutlined, 2 <= statusIndex),
          ),
          Align(
            alignment: Alignment(1, 0),
            child: statusIcon(AppSvg.bagInactive, 3 <= statusIndex),
          ),
        ],
      ),
    );
  }

  Widget statusIcon(String svg, bool active) {
    return Container(
      width: 32,
      height: 32,
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.green : Color(0xFFD9D9D9),
      ),
      child: SvgPicture.asset(
        svg,
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
    );
  }

  Widget statusText(String text, bool active) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: active ? Colors.green : Color(0xFFD9D9D9),
      ),
    );
  }
}
