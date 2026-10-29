import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/remote/network/firestore_manager.dart';
import '../../../core/resources/app_constants.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/dialog_utiles.dart';
import '../../../core/resources/my_flutter_app_icons.dart';
import '../../../core/reusable_components/back_btn.dart';
import '../../../core/reusable_components/custom_button.dart';
import '../../../core/reusable_components/custom_field.dart';
import '../../../model/event_model.dart';
import '../../../providers/theme_provider.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int selectedTab = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      var event = ModalRoute.of(context)?.settings.arguments as EventModel?;
      if (event != null) {
        titleController.text = event.title ?? "";
        descController.text = event.desc ?? "";

        if (event.dateAndTime != null) {
          DateTime dt = event.dateAndTime!.toDate();
          selectedDate = dt;
          selectedTime = TimeOfDay.fromDateTime(dt);
        }
        if (event.type != null) {
          int index = AppConstants.types.indexOf(event.type!);
          if (index != -1) {
            selectedTab = index;
          }
        }
      }
      isInitialized = true;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    Map<String, String> currentBackgrounds = themeProvider.themeMode == ThemeMode.dark
        ? AppConstants.darkEventTypeBackground
        : AppConstants.lightEventTypeBackground;

    return Scaffold(
      appBar: AppBar(
        leading: BackBtn(),
        leadingWidth: 60,
        title: const Text("Edit event"),
      ),
      body: DefaultTabController(
        length: AppConstants.types.length,
        initialIndex: selectedTab,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                spacing: 16,
                children: [
                  Container(
                    height: screenHeight * 0.23,
                    child: TabBarView(
                      children: AppConstants.types.map((type) {
                        return Container(
                          width: double.infinity,
                          height: screenHeight * 0.23,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                currentBackgrounds[type] ?? "",
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  TabBar(
                    onTap: (value) {
                      setState(() {
                        selectedTab = value;
                      });
                    },
                    labelStyle: Theme.of(context).textTheme.bodyMedium,
                    unselectedLabelStyle: Theme.of(context).textTheme.displaySmall,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: ColorsManager.lightFieldBorderColor,
                    dividerHeight: 0,
                    indicatorPadding: EdgeInsets.zero,
                    indicatorWeight: 0,
                    indicator: BoxDecoration(
                      color: ColorsManager.lightPrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                               Icon(MyFlutterApp.bike),
                               Text("Sport", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                               Icon(MyFlutterApp.birthday_icon),
                               Text("Birthday", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                               Icon(MyFlutterApp.book),
                               Text("Book", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                               Icon(MyFlutterApp.meeting),
                               Text("Meeting", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            spacing: 8,
                            children: [
                               Icon(MyFlutterApp.exhibition),
                               Text("Exhibition", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Title", style: Theme.of(context).textTheme.displaySmall),
                      CustomField(
                        prefixPath: "",
                        controller: titleController,
                        keyboard: TextInputType.text,
                        hint: "Event Title",
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Event title can't be empty";
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description", style: Theme.of(context).textTheme.displaySmall),
                      CustomField(
                        maxLines: 5,
                        prefixPath: "",
                        controller: descController,
                        keyboard: TextInputType.text,
                        hint: "Event Description",
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Event description can't be empty";
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AssetsManager.date),
                       SizedBox(width: 8),
                      Text("Event Date", style: Theme.of(context).textTheme.displaySmall),
                       Spacer(),
                      InkWell(
                        onTap: () {
                          chooseDate();
                        },
                        child: Text(
                          selectedDate != null ? selectedDate.toString().split(' ')[0] : "Choose Date",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  // Event Time Picker Row
                  Row(
                    children: [
                      SvgPicture.asset(AssetsManager.time),
                       SizedBox(width: 8),
                      Text("Event Time", style: Theme.of(context).textTheme.displaySmall),
                       Spacer(),
                      InkWell(
                        onTap: () {
                          chooseTime();
                        },
                        child: Text(
                          selectedTime != null ? selectedTime!.format(context) : "Choose Time",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),

                   SizedBox(height: 8),
                  CustomButton(
                    title: "Update event",
                    onClick: () {
                      updateEvent();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  chooseDate() async {
    var temp = await showDatePicker(
      initialDate: selectedDate ?? DateTime.now(),
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (temp != null) {
      setState(() {
        selectedDate = temp;
      });
    }
  }

  chooseTime() async {
    var temp = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (temp != null) {
      setState(() {
        selectedTime = temp;
      });
    }
  }

  updateEvent() async {
    var originalEvent = ModalRoute.of(context)?.settings.arguments as EventModel?;
    if (formKey.currentState!.validate()) {
      if (selectedTime != null && selectedDate != null && originalEvent != null) {
        DialogUtils.showLoadingDialog(context);

        originalEvent.title = titleController.text;
        originalEvent.desc = descController.text;
        originalEvent.type = AppConstants.types[selectedTab];
        originalEvent.dateAndTime = Timestamp.fromDate(DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute,
        ));

        await FirestoreManager.updateEvent(originalEvent);

        if (!mounted) return;
        Navigator.of(context).pop();
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text("Event updated successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text("Date and time are required")),
        );
      }
    }
  }
}