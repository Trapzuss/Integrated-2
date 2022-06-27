import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class ProfileImageEditing extends StatefulWidget {
  String? imageUrl;
  var pickImageAction;
  ProfileImageEditing({Key? key, this.imageUrl, required this.pickImageAction})
      : super(key: key);

  @override
  State<ProfileImageEditing> createState() => _ProfileImageEditingState();
}

class _ProfileImageEditingState extends State<ProfileImageEditing> {
  File? _mediaFile;
  String? _imageUrl;
  Future _selectFile() async {
    try {
      // print('select file');
      final result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg', 'mp4', 'avi', 'mov']);
      if (result == null) return;
      final path = result.files.single.path!;

      setState(() {
        _mediaFile = File(path.toString());
      });
      widget.pickImageAction(_mediaFile);
    } on PlatformException catch (e) {
      print('Failed to pick files: $e');
    }
  }

  @override
  void initState() {
    _imageUrl = widget.imageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      child: _buildImage(),
      onTap: () {
        _selectFile();
      },
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        Opacity(
          opacity: 0.8,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 32,
            child: ClipOval(child: _buildImageComputed()),
          ),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 12,
              child: Icon(
                Icons.camera_alt,
                size: 16,
                color: AppTheme.colors.darkFontColor,
              ),
            ))
      ],
    );
  }

  Widget _buildImageComputed() {
    print(_imageUrl);
    if (_mediaFile == null) {
      if (_imageUrl == null) {
        return Icon(
          Icons.person,
          color: AppTheme.colors.darkFontColor,
          size: 28,
        );
      } else {
        return Image.network(_imageUrl!, fit: BoxFit.cover);
      }
    }
    if (_mediaFile != null) {
      if (_imageUrl == null) {
        return Image.file(_mediaFile!, fit: BoxFit.cover);
      } else {
        return Image.network(_imageUrl!, fit: BoxFit.cover);
      }
    }
    return Center(
        child: CircularProgressIndicator(
      color: AppTheme.colors.primary,
    ));
  }
}
