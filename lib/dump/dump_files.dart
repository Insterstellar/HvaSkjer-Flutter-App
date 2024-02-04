/*

import 'dart:io';

//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class PickImage {
  File ? image;
  String? imageUrl ;
  final  ImagePicker _imagePicker = ImagePicker();
  //PickImage(this.image);



  Future PickImageGallery(BuildContext context) async {

    await showModalBottomSheet(context: context, builder: (context)=>BottomSheet(
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(leading: Icon(Icons.camera),title: Text('Choose Camera'), onTap: ()  async{
            Navigator.of(context).pop();
            _pickImage(ImageSource.gallery);


          }),
          ListTile(leading: Icon(Icons.photo_album),title: Text('Choose Gallery'), onTap: ()async{
            Navigator.of(context).pop();
            _pickImage(ImageSource.gallery);
          })
        ],
      ),onClosing: (){
      print ('the experiemental image is this and printed here : $image');

    },

    ));




*/
/*final image =await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image==null) return;

   final imageTemporary = File(image.path);
  this.image=imageTemporary;

  return this.image=imageTemporary;*//*
*/
/*
*//*

*/
/*


  }

  Future _pickImage(ImageSource source) async{
    final pickedFile = await _imagePicker.pickImage(source: source, imageQuality: 50);
    if (pickedFile==null) {return;}

    var file = await ImageCropper().cropImage(sourcePath: pickedFile.path, aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file==null) {return;}
    // print('the actual cropped image is here ${file.path}');
    // CroppedFile? compressedFile = (await compressImage(file.path, 35)) as CroppedFile?;
    final compressedFIle =(await compressImage(file.path, 35))  ;
    this.image =compressedFIle;
    // print('the actual cropped image is here $image ');
    //return image =file;
    await UploadEventImage(image! );
    //  print('the actual cropped image is here ${toll?.path} ');
    // return toll?.path;
  }

  Future compressImage(String path, int quality) async{
    final newPath =p.join((await getTemporaryDirectory()).path, '${DateTime.now()}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality:quality,
    );
    return result!;


  }


  Future<File> UploadEventImage(File file) async{

    return image!;

  }


}


*//*
*/
/*

*/
