import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../model/event_model.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../remote/network/firestore_manager.dart';
import '../resources/app_constants.dart';
import '../resources/assets_manager.dart';
import '../resources/dialog_utiles.dart';

class EventItem extends StatefulWidget {
  final EventModel event;
  const EventItem({super.key,required this.event});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.25,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .secondary
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  provider.themeMode == ThemeMode.dark
                      ? AppConstants.darkEventTypeBackground[widget.event.type]??""
                      : AppConstants.lightEventTypeBackground[widget.event.type]??"",
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                      )
                  ),
                  child: Text(widget.event.dateAndTime?.toDate().day.toString()??"",style: Theme.of(context).textTheme.headlineSmall,),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 9.5,
                      horizontal: 8
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                      )
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(widget.event.title??"",style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500
                        ),),
                      ),
                      IconButton(onPressed: () {
                        heartClicked(userProvider);
                      }, icon: SvgPicture.asset(userProvider.user?.favorites?.contains(widget.event.id!)??false
                          ?AssetsManager.heart_selected
                          :AssetsManager.heart))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  heartClicked(UserProvider userProvider)async{
    if(userProvider.user?.favorites?.contains(widget.event.id!)??false){
      DialogUtils.showLoadingDialog(context);
      await FirestoreManager.deleteEventFavorite(widget.event);
      userProvider.user?.favorites?.remove(widget.event.id!);
      await FirestoreManager.updateUser(userProvider.user?.favorites??[]);
      Navigator.of(context).pop();
      SnackBar snackBar = SnackBar(content: Text("Event deleted from your favorites"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }else{
      DialogUtils.showLoadingDialog(context);
      await FirestoreManager.addEventFavorite(widget.event);
      userProvider.user?.favorites?.add(widget.event.id!);
      await FirestoreManager.updateUser(userProvider.user?.favorites??[]);
      Navigator.of(context).pop();
      SnackBar snackBar = SnackBar(content: Text("Event added to your favorites"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {

    });
  }
}