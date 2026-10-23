import 'package:evently/core/remote/network/firestore_manager.dart';
import 'package:evently/core/resources/app_constants.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/dialog_utiles.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/core/reusable_components/back_btn.dart';
import 'package:evently/model/event_model.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../core/resources/assets_manager.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EventModel event = ModalRoute.of(context)?.settings.arguments as EventModel;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    String imagePath = "";
    if (event.type != null) {
      imagePath = themeProvider.themeMode == ThemeMode.dark
          ? AppConstants.darkEventTypeBackground[event.type] ?? ""
          : AppConstants.lightEventTypeBackground[event.type] ?? "";
    }
    String formattedDate = "";
    String formattedTime = "";
    if (event.dateAndTime != null) {
      DateTime dateTime = event.dateAndTime!.toDate();
      formattedDate = dateTime.toString().split(' ')[0];

      int hour = dateTime.hour;
      String period = hour >= 12 ? "PM" : "AM";
      hour = hour % 12;
      hour = hour == 0 ? 12 : hour;
      String minute = dateTime.minute.toString().padLeft(2, '0');
      formattedTime = "$hour:$minute $period";
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(),
        leadingWidth: 60,
        title: Text("Event Details"),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutesManager.editEvent,
                arguments: event,
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorsManager.lightFieldBorderColor,
                  width: 1,
                ),
              ),
              child: SvgPicture.asset(AssetsManager.edit),
            ),
          ),
          GestureDetector(
            onTap: () async {
              DialogUtils.showLoadingDialog(context);
              try {
                await FirestoreManager.deleteEvent(event);
                if (!context.mounted) return;
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Event deleted successfully")),
                );
              } catch (e) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Failed to delete event: $e")),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 4, right: 16),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorsManager.lightFieldBorderColor,
                  width: 1,
                ),
              ),
              child: SvgPicture.asset(AssetsManager.delete),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 193,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ColorsManager.lightFieldBorderColor,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                event.title ?? "Event Title",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge
              ),
              SizedBox(height: 16),

              Container(
                padding:  EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorsManager.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ColorsManager.lightFieldBorderColor,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorsManager.lightFieldBorderColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        AssetsManager.calendarAdd,
                      ),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedDate,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ColorsManager.blackColor,
                              ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          formattedTime,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              Text(
                "Description",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge
              ),
               SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: ColorsManager.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ColorsManager.lightFieldBorderColor,
                  ),
                ),
                child: Text(
                  event.desc ?? "No description provided.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                    color: ColorsManager.blackColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
