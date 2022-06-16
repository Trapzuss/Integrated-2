import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildPostImage extends StatefulWidget {
  var pickImageAction;
  BuildPostImage({Key? key, required this.pickImageAction}) : super(key: key);

  @override
  State<BuildPostImage> createState() => _BuildPostImageState();
}

class _BuildPostImageState extends State<BuildPostImage> {
  File? mediaFile;
  Future selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg', 'mp4', 'avi', 'mov']);
      if (result == null) return;
      final path = result.files.single.path!;

      setState(() {
        mediaFile = File(path.toString());
      });
      widget.pickImageAction(mediaFile);
    } on PlatformException catch (e) {
      print('Failed to pick files: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: mediaFile == null
            ? EmptyImageTypeCreatePost()
            : Container(
                margin:
                    EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    mediaFile!,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
        onTap: () {
          selectFile();
        });
  }
}
