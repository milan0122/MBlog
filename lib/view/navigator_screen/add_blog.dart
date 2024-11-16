import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mblog/Utils/Components/RoundButton.dart';
import 'package:mblog/Utils/Route/RouteName.dart';
import 'package:mblog/Utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final auth = FirebaseAuth.instance;

  final postRef = FirebaseDatabase.instance.ref().child('Post');
  final storage= FirebaseStorage.instance;
  bool loading = false;
  File? _image;
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  final picker = ImagePicker();

  Future getGalleryImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile!=null){
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    else{
      Utils.toastMessage('No image picked');
    }
  }
  Future getCameraImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if(pickedFile!=null){
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    else{
      Utils.toastMessage('No image picked');
    }
  }

  @override
  void dispose(){
    super.dispose();
    titleController.dispose();
    titleFocusNode.dispose();
    descriptionController.dispose();
    descriptionController.dispose();
  }


  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Blog'),
        centerTitle: true,

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  dialog(context);
                },
                child: Center(
                  child: Container(
                    height:MediaQuery.of(context).size.height* .2,
                    width:MediaQuery.of(context).size.height* 1,
                    child: _image != null ?  ClipRect(
                      child: Image.file(
                        _image!.absolute,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),

                    ):Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.blue,),
                    )
                    ),

                  ),
              ),
              SizedBox(height: 30,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        focusNode: titleFocusNode,
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          labelText: 'Title',
                          hintText: 'Enter post title',
                          hintStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                          labelStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),

                        ),
                        onFieldSubmitted: (value){
                          Utils.fieldFocusChange(context, titleFocusNode, descriptionFocusNode);
                        },

                      ),

                    ),
                    SizedBox(height: 20,),
                     Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          focusNode: descriptionFocusNode,
                          controller: descriptionController,
                          minLines: 1,
                          maxLines: 5,
                          maxLength: 100,
                          decoration: InputDecoration(
                              border:
                              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),

                              labelText: 'Description',
                            hintText: 'Enter post description',
                            hintStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                            labelStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),
                        ),

                      )
                    ),
                    SizedBox(height: 20,),
                    RoundButton(title: 'Upload',
                        loading: loading,
                        onPress: ()async{
                      setState(() {
                        loading  = true;
                      });
                      try{
                        DateTime now = DateTime.now();
                        String formattedDate = DateFormat('dd-MM-yyyy').format(now);
                        //generate a unique id using user's  ud
                        final User? user = auth.currentUser;
                        if(user== null){
                          Utils.toastMessage("NO user is logged in");
                        }
                        String postId = '${user?.uid}-${now.millisecondsSinceEpoch}';
                       Reference ref = FirebaseStorage.instance.ref('/blogApp$postId');
                       UploadTask upload = ref.putFile(_image!.absolute);
                       await Future.value(upload);
                       var newUrl = await ref.getDownloadURL();
                       postRef.child('Post List').child(postId.toString()).set({
                         'pid':postId.toString(),
                         'PImage':newUrl.toString(),
                         'PTime': formattedDate,
                         'PTitle':titleController.text.toString(),
                         'pDescription':descriptionController.text.toString(),
                         'uEmail':user!.email.toString(),
                         'uId':user.uid.toString()

                       }).then((value){
                         Utils.toastMessage('Post published');
                         // Clear the text fields
                         titleController.clear();
                         descriptionController.clear();

                         // Clear the selected image
                         setState(() {
                           _image = null;
                           loading = false;
                         });

                       }).onError((error,StackTrace){
                         setState(() {
                           loading  =false;
                         });
                         Utils.toastMessage(error.toString());
                       });

                      }
                      catch(e){
                        setState(() {
                          loading  =false;
                        });
                        Utils.toastMessage(e.toString());

                      }

                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void dialog(context){
    showDialog(context: context,
        builder: (BuildContext context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)
        ),
        content: Container(
          height: 120,
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  getCameraImage();
                  Navigator.pop(context);

                },
                child: ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                ),
              ),
              InkWell(
                onTap: (){
                  getGalleryImage();
                  Navigator.pop(context);

                },
                child: ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Gallery'),
                ),
              )
            ],
          ),
        ),

      );
        }

    );
  }
}
