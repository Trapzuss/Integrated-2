import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/widgets/posts/generate/build_address_form.dart';
import 'package:pet_integrated/widgets/posts/generate/build_cost_form.dart';
import 'package:pet_integrated/widgets/posts/generate/build_general_form.dart';
import 'package:pet_integrated/widgets/posts/generate/build_post_image.dart';

class BuildPostForm extends StatefulWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var post;
  var formKey = GlobalKey<FormState>();
  var pickImageAction;
  var getGeneralInfoAction;
  var getAddressInfoAction;
  var getCostInfoAction;
  // var controllerTitle = TextEditingController();
  var controllerDescription = TextEditingController();
  var controllerPetname = TextEditingController();
  // var controllerSex = TextEditingController();
  // var controllerAge = TextEditingController();
  // var controllerWeight = TextEditingController();
  var controllerDistrict = TextEditingController();
  var controllerProvince = TextEditingController();
  var controllerCountry = TextEditingController();
  var controllerPrice = TextEditingController();
  BuildPostForm({
    Key? key,
    this.post,
    required this.scaffoldKey,
    required this.formKey,
    required this.getGeneralInfoAction,
    required this.getAddressInfoAction,
    required this.getCostInfoAction,
    required this.pickImageAction,
    // required this.controllerTitle,
    required this.controllerDescription,
    required this.controllerPetname,
    // required this.controllerSex,
    // required this.controllerAge,
    // required this.controllerWeight,
    required this.controllerDistrict,
    required this.controllerProvince,
    required this.controllerCountry,
    required this.controllerPrice,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  State<BuildPostForm> createState() => _BuildPostFormState();
}

class _BuildPostFormState extends State<BuildPostForm> {
  @override
  void initState() {
    // TODO: implement initState
    _initialPostData();
    super.initState();
  }

  void _initialPostData() {
    if (widget.post != null) {
      widget.controllerPetname.text = widget.post['petName'];
      widget.controllerDescription.text = widget.post['description'];
      widget.controllerCountry.text = widget.post?['address']['country'];
      widget.controllerDistrict.text = widget.post?['address']['district'];
      widget.controllerProvince.text = widget.post?['address']['province'];
      widget.controllerPrice.text = widget.post['price'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              BuildPostImage(
                post: widget.post,
                pickImageAction: widget.pickImageAction,
              ),
              BuildGeneralForm(
                post: widget.post,
                scaffoldKey: widget.scaffoldKey,
                // controllerAge: widget.controllerAge,
                controllerDescription: widget.controllerDescription,
                controllerPetname: widget.controllerPetname,
                // controllerSex: widget.controllerSex,
                // controllerTitle: widget.controllerTitle,
                // controllerWeight: widget.controllerWeight,
                getGeneralInfoAction: widget.getGeneralInfoAction,
              ),
              BuildAddressForm(
                post: widget.post,
                controllerCountry: widget.controllerCountry,
                controllerDistrict: widget.controllerDistrict,
                controllerProvince: widget.controllerProvince,
                getAddressInfoAction: widget.getAddressInfoAction,
              ),
              BuildCostForm(
                post: widget.post,
                controllerPrice: widget.controllerPrice,
                getCostInfoAction: widget.getCostInfoAction,
              ),
            ],
          )),
    );
  }
}
