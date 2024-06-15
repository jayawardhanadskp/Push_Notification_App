import 'dart:io';

import 'package:authentication_app/services/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendNotificationScreen extends StatefulWidget {

  final String token;
  const SendNotificationScreen({
    Key? key,
    required this.token
  }): super(key: key);

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {

  late final TextEditingController title;
  late final TextEditingController body;
  late final ImagePicker _picker;

  @override
  void initState() {
    title = TextEditingController();
    body = TextEditingController();
    _picker = ImagePicker();
    super.initState();
  }

  XFile? xFile;
  bool isLoading = false;
  String image = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Notification'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                key: UniqueKey(),
                keyboardType: TextInputType.text,
                controller: title,
                decoration: InputDecoration(
                  labelText: 'Enter notification tytle',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  )
                ),
                onChanged: (value) {
                  title.text = value;
                },
              ),

              TextFormField(
                key: UniqueKey(),
                keyboardType: TextInputType.text,
                controller: body,
                decoration: InputDecoration(
                  labelText: 'Enter notification body',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  )
                ),
                onChanged: (value) {
                  body.text = value;
                },
                maxLines: 3,
              ),

              InkWell(
                onTap: () async {
                  isLoading = true;
                  setState(() {});

                    xFile = await _picker.pickImage(source: ImageSource.gallery);
                    if (xFile != null) {
                      setState(() {});

                      // upload file
                      final String? url =
                          await FirebaseHelper.uploadImage(File(xFile!.path));

                      if (url != null) {
                        image = url;
                        isLoading = false;
                        setState(() {});
                        return;
                      }
                    }

                  isLoading = false;
                  setState(() {});

                },
                child: Container(
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(width: 8, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                    image: xFile?.path != null
                      ? DecorationImage(
                        image: FileImage(
                          File(xFile!.path),
                        ),
                      fit: BoxFit.cover
                    )
                        : null,
                  ),
                  child: xFile?.path != null
                    ? null
                    : const Center(
                    child: Icon(Icons.photo),
                  ),
                ),
              ),
              Padding(padding: const EdgeInsets.all(20),
                child: isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed: () => FirebaseHelper.sendNotification(
                      title: title.text,
                      body: body.text,
                      token: widget.token,
                      image: image,
                    ),
                    child: const Text('Send Notification')
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
