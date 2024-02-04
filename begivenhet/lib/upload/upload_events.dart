import 'dart:io';

//import 'package:begivenhet/controllers/category_controller.dart';
import 'package:begivenhet/controllers/category_controller.dart';
import 'package:begivenhet/controllers/events_controller.dart';
import 'package:begivenhet/models/category_model.dart';
import 'package:begivenhet/models/events.dart';
import 'package:begivenhet/models/group_model.dart';
import 'package:begivenhet/repository/services/category_service.dart';
import 'package:begivenhet/repository/services/events_service.dart';
import 'package:begivenhet/utils/image_picker.dart';
import 'package:begivenhet/widgets/re_usable_select_no_photo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
//import 'package:image_picker/image_picker.dart';
import '../misc/my_colors.dart';
import '../misc/my_text.dart';
import '../utils/date_and_time.dart';
import '../widgets/app_text.dart';
import '../widgets/re_usable_select_photo_button.dart';

class UploadEvents extends StatefulWidget {
  UploadEvents();
  //static const id = 'set_photo_screen';

  @override
  UploadEventsState createState() => new UploadEventsState();
}

class UploadEventsState extends State<UploadEvents> {
  final allCategories = CategoryController(CategoryRepository());
  final uploadEvents = EventsController(EventsRepository());
  final _formKey = GlobalKey<FormState>();
  String? selectedImagePath;


  File? selectedImage;
  CategoryModel? _selectedItem;
  Future<List<CategoryModel>>? _dataList;

  final TextEditingController inputControllerEventName = new TextEditingController();
  final TextEditingController inputControllerStartDate = new TextEditingController();
  final TextEditingController inputControllerLocation = new TextEditingController();
  final TextEditingController inputControllerDescription = new TextEditingController();
  final TextEditingController inputControllerEndDate = new TextEditingController();
  final TextEditingController inputControllerEVentVenue = new TextEditingController();
  final TextEditingController inputController7 = new TextEditingController();
  @override
  void initState() {
    super.initState();
    //fetch categoryList
    _dataList = allCategories.fetchCategorysLists();

    inputControllerEventName.text;
    inputControllerStartDate.text;
    inputControllerDescription.text;
    inputControllerEndDate.text;
    inputControllerEVentVenue.text;
    inputController7.text;
  }
  void _submitForm() {
    EventsModel eventsModel=EventsModel();
    GroupModel groupModel= GroupModel(id:41 );
    CategoryModel categoryModel =CategoryModel();
    categoryModel.id=_selectedItem?.id;
    String formattedDateTime = DateFormat('yyyy-MM-ddTHH:mm').format(startDateTime);
    String formattedEndDateTime = DateFormat('yyyy-MM-ddTHH:mm').format(endDateTime);


    if (_formKey.currentState!.validate()) {
      // Form is valid, retrieve form field values
      eventsModel.eventName = inputControllerEventName.text;
      eventsModel.eventStartTime= formattedDateTime;
    eventsModel.eventDescription=inputControllerDescription.text;
    eventsModel.eventEndTime=formattedEndDateTime;
    eventsModel.eventVenue=inputControllerEVentVenue.text;
    eventsModel.eventImage=selectedImage?.path;
    uploadEvents.postEvent(eventsModel, groupModel, categoryModel);


      // Process the data or make API calls with the form field values
      // ...

      // Clear the form fields
     //inputControllerEventName.clear();
     //inputControllerStartDate.clear();
     //inputControllerDescription.clear();
     //inputControllerEndDate.clear();
     //inputControllerEVentVenue.clear();
     //inputController7.clear();
    }
  }
  //@override
  //void dispose() {
  //  inputControllerEventName.dispose();
  //  inputControllerDate.dispose();
  //  inputControllerLOcation.dispose();
  //  super.dispose();
  //}

  DateTime endDateTime = DateTime(2023,03,24,5,30);
  DateTime startDateTime = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  //String? imageUrl;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        selectedImage = img;
        selectedImagePath=selectedImage?.path;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {

    //_selectedItem.name;
    // endTime in hours and minutes
    final hours = endDateTime.hour.toString().padLeft(2, '0');
    final minutes = endDateTime.minute.toString().padLeft(2, '0');

    //startTime in hours and minutes
    final startHours = startDateTime.hour.toString().padLeft(2, '0');
    final startMinutes = startDateTime.minute.toString().padLeft(2, '0');
print('my selected image is : $selectedImagePath');
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: MyColors.grey_5,
        //activate/ reactivate tool bar for android
        /*appBar: AppBar(
           backgroundColor: Colors.blue[600], systemOverlayStyle: SystemUiOverlayStyle(
           statusBarBrightness: Brightness.dark
       ),
           title: Text("Hva Skjer"),
           leading: IconButton(
             icon: Icon(Icons.chevron_left),
             onPressed: () {
               Navigator.pop(context);
             },
           ),
           actions: <Widget>[
             IconButton(
               icon: Icon(Icons.more_vert),
               onPressed: () {},
             ),
           ]
       ),*/
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          scrollDirection: Axis.vertical,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: 5),
                  Container(
                    height: 230,
                    width: double.infinity,
                    color: MyColors.grey_10,
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Column(
                            children: [
                              if (selectedImage == null)
                                Icon(Icons.image_rounded,
                                    size: 220, color: Colors.white),
                              if (selectedImage != null)
                                // Icon(Icons.cabin, size: 220, color: Colors.white),

                                Image.file(
                                  selectedImage!,
                                  width: double.infinity,
                                  height: 230,
                                  fit: BoxFit.cover,
                                ),
                            ],
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(0.0, 40.0, 0.0),
                          margin: EdgeInsets.all(15),
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            heroTag: "fab3",
                            backgroundColor: Colors.blueGrey[800],
                            elevation: 3,
                            child: Icon(Icons.add_a_photo, color: Colors.white),
                            onPressed: () async {
                              //findImage();
                              _showSelectPhotoOptions(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 35),
                  Text("EVENT NAME",
                      style: MyText.body1(context)!
                          .copyWith(color: MyColors.grey_60)),
                  Container(height: 5),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),

                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      maxLines: 1,
                      controller: inputControllerEventName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an event name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(-10),
                        border: InputBorder.none,
                        hintText: "Event Name",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  )
                  ,
                  Container(height: 15),
                  //Categories
                  Text("CATEGORY",
                      style: MyText.body1(context)!
                          .copyWith(color: MyColors.grey_60)),
                  Container(height: 5),

                  FutureBuilder<List<CategoryModel>>(
                    future: _dataList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final dataList = snapshot.data;
                        _selectedItem = dataList!.contains(_selectedItem)
                            ? _selectedItem
                            : dataList.first;

                        return Container(
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: DropdownButton<CategoryModel>(
                            hint: const Text("Select a category"),
                            icon: const Icon(Icons.expand_more,
                                color: MyColors.grey_40),
                            iconSize: 25,
                            isExpanded: true,
                            underline: SizedBox(),
                            value: _selectedItem,
                            onChanged: (CategoryModel? value) {
                              setState(() {
                                _selectedItem = value!;
                                //var ad = _selectedItem?.id;
                               // print('my id is :$ad');
                              });
                            },
                            items: dataList.map<DropdownMenuItem<CategoryModel>>(
                              (CategoryModel value) {
                                return DropdownMenuItem<CategoryModel>(
                                  value: value,
                                  child: Text(value.name ?? ''),
                                );
                              },
                            ).toList(),
                          ),
                        );
                      }
                    },
                  ),
                  Container(height: 15),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("START DATE",
                                style: MyText.body1(context)!
                                    .copyWith(color: MyColors.grey_60)),
                            Container(height: 5),
                            GestureDetector(
                              onTap: () async {
                                print('hellow world ');
                                PickdateAndTime pickTime = PickdateAndTime();
                                DateTime? startDate =
                                    await pickTime.pickDate(context);
                                TimeOfDay? starttime =
                                    await pickTime.pickTime(context);

                                if (startDate != null && starttime != null) {
                                  final newStartTime = DateTime(
                                      startDate.year,
                                      startDate.month,
                                      startDate.day,
                                      starttime.hour,
                                      starttime.minute);

                                  setState(() {
                                    startDateTime = newStartTime;

                                  });
                                } else {
                                  return null;
                                }
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: EdgeInsets.all(0),
                                elevation: 0,
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 1),
                                  child: Text.rich(
                                    TextSpan(
                                      text: ' ',
                                      children: [
                                        const WidgetSpan(
                                          alignment: PlaceholderAlignment.middle,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .date_range, // Replace with the desired icon
                                                  color: MyColors.grey_40,
                                                ),
                                                SizedBox(width: 1.0),
                                              ],
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${startDateTime.month}/${startDateTime.day}/${startDateTime.year} - $startHours:$startMinutes',
                                          style: MyText.body1(context)!
                                              .copyWith(color: MyColors.grey_40),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("END DATE",
                                style: MyText.body1(context)!
                                    .copyWith(color: MyColors.grey_60)),
                            Container(height: 5),
                            GestureDetector(
                              onTap: () async {
                                PickdateAndTime picker = PickdateAndTime();
                                DateTime? selectedDate = await picker.pickDate(context);
                                TimeOfDay? selectedTime =
                                    await picker.pickTime(context);

                                if (selectedDate != null && selectedTime != null) {
                                  final newEndDateTime = DateTime(
                                    selectedDate.year,
                                    selectedDate.month,
                                    selectedDate.day,
                                    selectedTime.hour,
                                    selectedTime.minute,
                                  );
                                  setState(() {
                                    endDateTime = newEndDateTime;
                                    //print("my time is : $newEndDateTime");
                                  });
//
                                } else {
                                  // No date selected
                                  return null;
                                }
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: EdgeInsets.all(0),
                                elevation: 0,
                                child: Container(
                                    height: 40,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 1),
                                    child: Text.rich(
                                      TextSpan(
                                        text: ' ',
                                        children: [
                                          const WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.date_range,
                                                    color: MyColors.grey_40,
                                                  ),
                                                  SizedBox(width: 1.0),
                                                ],
                                              ),
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${endDateTime.month}/${endDateTime.day}/${endDateTime.year} - $hours:$minutes',
                                            style: MyText.body1(context)!
                                                .copyWith(
                                                    color: MyColors.grey_40),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(height: 15),
                  Text("LOCATION",
                      style: MyText.body1(context)!
                          .copyWith(color: MyColors.grey_60)),
                  Container(height: 5),
                  Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Container(width: 15),
                        Expanded(
                          child: TextFormField(
                            maxLines: 1,
                            keyboardType: TextInputType.text,
                            controller: inputControllerEVentVenue,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter Location';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(-12),
                                border: InputBorder.none,
                                hintText: "Event Venue",
                                hintStyle: MyText.body1(context)!
                                    .copyWith(color: MyColors.grey_40)),
                          ),
                        ),
                        Icon(Icons.location_on_outlined, color: MyColors.grey_40)
                      ],
                    ),
                  ),
                  Container(height: 15),
                  Text("DESCRIPTION",
                      style: MyText.body1(context)!
                          .copyWith(color: MyColors.grey_60)),
                  Container(height: 5),
                  Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 200.0,
                        child: TextFormField(
                          maxLines: 200,
                          //minLines: 3,
                          keyboardType: TextInputType.multiline,
                          controller: inputControllerDescription,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please write something....';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              //contentPadding: EdgeInsets.all(-12),
                              border: InputBorder.none,
                              hintText: "Event Description...",
                              hintStyle: MyText.body1(context)!
                                  .copyWith(color: MyColors.grey_40)),
                        ),
                      )),
                  Container(height: 15),
                  Container(
                      width: double.infinity,
                      height: 50,
                      child: SelectButton(
                          textLabel: 'Add Event',
                          onTap: () {
                            _submitForm();

                          },


                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
