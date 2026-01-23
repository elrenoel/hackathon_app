import 'package:flutter/material.dart';

class StartTimeTask extends StatelessWidget {
  final TextEditingController controller;

  const StartTimeTask({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Start Time'),
        SizedBox(height: 10),
        TextField(
          readOnly: true,
          controller: controller,
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    timePickerTheme: TimePickerThemeData(
                      backgroundColor: Color(0xFFF5F5F5),

                      // Jam & menit (kotak besar)
                      hourMinuteColor: Colors.white,
                      hourMinuteTextColor: Colors.black,
                      hourMinuteShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),

                      // AM / PM
                      dayPeriodColor: Colors.white,
                      dayPeriodTextColor: Colors.black,
                      dayPeriodShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      // Dial (jam bulat)
                      dialBackgroundColor: Colors.white,
                      dialHandColor: Colors.grey,
                      dialTextColor: Colors.black,

                      // Tombol OK / Cancel
                      cancelButtonStyle: TextButton.styleFrom(
                        foregroundColor: Colors.grey,
                      ),
                      confirmButtonStyle: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (time != null) {
              controller.text =
                  '${time.hour.toString().padLeft(2, '0')}:'
                  '${time.minute.toString().padLeft(2, '0')}:00';
            }
          },
          decoration: const InputDecoration(
            hintText: 'hh:mm:ss',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
