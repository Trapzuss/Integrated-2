import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class overviewForm extends StatefulWidget {
  final data;
  const overviewForm({Key? key, required this.data}) : super(key: key);

  @override
  State<overviewForm> createState() => _overviewFormState();
}

class _overviewFormState extends State<overviewForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return widget.data?['firstname'] != null
        ? Column(
            children: [
              Container(
                height: height / 3.5,
                margin: EdgeInsets.only(bottom: 5),
                child: Image.asset('assets/images/Collaboration-bro.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Personal Infomation',
                      style: AppTheme.style.primaryFontStyle,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Flexible(
                        child: Container(
                      child: Row(
                        children: [
                          Text(
                            'Firstname:',
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.style.secondaryFontStyle,
                          ),
                          Flexible(
                            child: Text(
                              widget.data['firstname'],
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.style.primaryFontStyle,
                            ),
                          )
                        ],
                      ),
                    )),
                    Flexible(
                        child: Container(
                      child: Row(
                        children: [
                          Text(
                            'Lastname:',
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.style.secondaryFontStyle,
                          ),
                          Flexible(
                            child: Text(
                              widget.data['lastname'],
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.style.primaryFontStyle,
                            ),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Flexible(
                        child: Container(
                      child: Row(
                        children: [
                          Text(
                            'Email:',
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.style.secondaryFontStyle,
                          ),
                          Flexible(
                            child: Text(
                              widget.data['email'],
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.style.primaryFontStyle,
                            ),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Flexible(
                        child: Container(
                      child: Row(
                        children: [
                          Text(
                            'Password:',
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.style.secondaryFontStyle,
                          ),
                          Text(
                            widget.data['password'],
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.style.primaryFontStyle,
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Address Infomation',
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.style.primaryFontStyle,
                    ),
                  ),
                ],
              ),
              // Container(
              //   margin: EdgeInsets.only(bottom: 5),
              //   child: Row(
              //     children: [
              //       Flexible(
              //           child: Container(
              //         child: Row(
              //           children: [
              //             Text(
              //               'Street:',
              //               overflow: TextOverflow.ellipsis,
              //               style: AppTheme.style.secondaryFontStyle,
              //             ),
              //             Flexible(
              //               child: Text(
              //                 widget.data['street'],
              //                 maxLines: 4,
              //                 overflow: TextOverflow.ellipsis,
              //                 style: AppTheme.style.primaryFontStyle,
              //               ),
              //             )
              //           ],
              //         ),
              //       )),
              //     ],
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Flexible(
                        child: Container(
                      child: Row(
                        children: [
                          Text(
                            'City:',
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.style.secondaryFontStyle,
                          ),
                          Flexible(
                            child: Text(
                              widget.data['city'],
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.style.primaryFontStyle,
                            ),
                          )
                        ],
                      ),
                    )),
                    Flexible(
                        child: Container(
                      child: Row(
                        children: [
                          Text(
                            'Province:',
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.style.secondaryFontStyle,
                          ),
                          Flexible(
                            child: Text(
                              widget.data['province'],
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.style.primaryFontStyle,
                            ),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    // Flexible(
                    //     child: Container(
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         'Zip code:',
                    //         overflow: TextOverflow.ellipsis,
                    //         style: AppTheme.style.secondaryFontStyle,
                    //       ),
                    //       Flexible(
                    //         child: Text(
                    //           widget.data['zipcode'],
                    //           maxLines: 4,
                    //           overflow: TextOverflow.ellipsis,
                    //           style: AppTheme.style.primaryFontStyle,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )),
                    Flexible(
                        child: Container(
                      child: Row(
                        children: [
                          Text(
                            'Country:',
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.style.secondaryFontStyle,
                          ),
                          Flexible(
                            child: Text(
                              widget.data['country'],
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.style.primaryFontStyle,
                            ),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ],
          )
        : Container();
  }
}
