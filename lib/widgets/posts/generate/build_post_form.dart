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
  var formKey = GlobalKey<FormState>();
  var pickImageAction;
  var getGeneralInfoAction;
  var getAddressInfoAction;
  var getCostInfoAction;
  var controllerTitle = TextEditingController();
  var controllerDescription = TextEditingController();
  var controllerPetname = TextEditingController();
  var controllerSex = TextEditingController();
  var controllerAge = TextEditingController();
  var controllerWeight = TextEditingController();
  var controllerDistrict = TextEditingController();
  var controllerProvince = TextEditingController();
  var controllerCountry = TextEditingController();
  var controllerPrice = TextEditingController();
  BuildPostForm({
    Key? key,
    required this.scaffoldKey,
    required this.formKey,
    required this.getGeneralInfoAction,
    required this.getAddressInfoAction,
    required this.getCostInfoAction,
    required this.pickImageAction,
    required this.controllerTitle,
    required this.controllerDescription,
    required this.controllerPetname,
    required this.controllerSex,
    required this.controllerAge,
    required this.controllerWeight,
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
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              BuildPostImage(
                pickImageAction: widget.pickImageAction,
              ),
              BuildGeneralForm(
                scaffoldKey: widget.scaffoldKey,
                controllerAge: widget.controllerAge,
                controllerDescription: widget.controllerDescription,
                controllerPetname: widget.controllerPetname,
                controllerSex: widget.controllerSex,
                controllerTitle: widget.controllerTitle,
                controllerWeight: widget.controllerWeight,
                getGeneralInfoAction: widget.getGeneralInfoAction,
              ),
              BuildAddressForm(
                controllerCountry: widget.controllerCountry,
                controllerDistrict: widget.controllerDistrict,
                controllerProvince: widget.controllerProvince,
                getAddressInfoAction: widget.getAddressInfoAction,
              ),
              BuildCostForm(
                controllerPrice: widget.controllerPrice,
                getCostInfoAction: widget.getCostInfoAction,
              ),
            ],
          )),
    );
  }
}
