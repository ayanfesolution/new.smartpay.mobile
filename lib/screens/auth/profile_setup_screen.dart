import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smartpay_mobile/screens/auth/sign_in.dart';
import 'package:smartpay_mobile/screens/auth/sign_up_screen.dart';
import 'package:smartpay_mobile/utils/app_colors.dart';
import 'package:smartpay_mobile/utils/app_widgets/back_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/main_button.dart';
import 'package:smartpay_mobile/utils/app_widgets/padded.dart';
import 'package:smartpay_mobile/utils/app_widgets/text_field.dart';
import 'package:smartpay_mobile/utils/constants.dart';
import 'package:smartpay_mobile/utils/routes_navigator.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/authetication_provider.dart';
import '../../utils/dimensions.dart';

class ProfileSetUpScreen extends StatefulHookWidget {
  const ProfileSetUpScreen({
    super.key,
    required this.email,
    required this.username,
    required this.password,
  });
  final String email, username, password;

  @override
  State<ProfileSetUpScreen> createState() => _ProfileSetUpScreenState();
}

class _ProfileSetUpScreenState extends State<ProfileSetUpScreen> {
  final profileDetailsFormKey = GlobalKey<FormState>();
  void changeValue(WidgetRef ref, bool newValue) {
    ref
        .read(registerCheckingButtonProvider.notifier)
        .update((state) => newValue);
  }

  XFile? meansOfIdentification;
  Uint8List? memoryImage;

  @override
  Widget build(BuildContext context) {
    var address = useTextEditingController();
    var phoneNumberTextController = useTextEditingController();

    var imageUrl = useState('');

    var isButtonActive = useState(false);

    final cloudinary = Cloudinary.signedConfig(
      apiKey: '967447554861949',
      apiSecret: 'raK2kUfoYlcMoYJLtnkbuUL3gs4',
      cloudName: 'ddgtlk2h3',
    );

    return Scaffold(
      backgroundColor: kWHTCOLOUR,
      body: Form(
        key: profileDetailsFormKey,
        child: SingleChildScrollView(
          child: Padded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                yMargin(52),
                const SmartPayBackButton(),
                yMargin(30),
                Text.rich(
                  TextSpan(
                    text: 'Hey there! tell us a bit about',
                    children: [
                      TextSpan(
                        text: ' yourself',
                        style: kTextStyleCustom(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: kSECCOLOUR,
                        ),
                      ),
                    ],
                    style: kTextStyleCustom(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                yMargin(32),
                SmartPayTextField(
                  controller: address,
                  hintText: 'Address',
                  onChange: (value) {
                    if (value.isNotEmpty &&
                        phoneNumberTextController.value.text.isNotEmpty &&
                        imageUrl.value.isNotEmpty) {
                      isButtonActive.value = true;
                    } else {
                      isButtonActive.value = false;
                    }
                  },
                ),
                yMargin(16),
                SmartPayTextField(
                  controller: phoneNumberTextController,
                  hintText: 'Phone number',
                  keyboardType: TextInputType.phone,
                  onChange: (value) {
                    if (value.isNotEmpty &&
                        address.value.text.isNotEmpty &&
                        imageUrl.value.isNotEmpty) {
                      isButtonActive.value = true;
                    } else {
                      isButtonActive.value = false;
                    }
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Phone number';
                    } else if (value.length != 11) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                ),
                yMargin(16),
                // InkWell(
                //   onTap: () {
                //     showModalBottomSheet(
                //       context: context,
                //       backgroundColor: kTransperent,
                //       isScrollControlled: true,
                //       builder: (context) {
                //         final searchTextFeild = TextEditingController();
                //         return Container(
                //           height: getScreenHeight(617),
                //           decoration: BoxDecoration(
                //             color: kWHTCOLOUR,
                //             borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(getScreenHeight(40)),
                //               topRight: Radius.circular(
                //                 getScreenHeight(40),
                //               ),
                //             ),
                //           ),
                //           child: Padded(
                //             child: Column(
                //               children: [
                //                 yMargin(32),
                //                 Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceBetween,
                //                   children: [
                //                     SizedBox(
                //                       width: getScreenWidth(258),
                //                       child: SmartPayTextField(
                //                         controller: searchTextFeild,
                //                         hintText: 'Search',
                //                         icon: Padding(
                //                           padding: EdgeInsets.all(
                //                               getScreenHeight(16)),
                //                           child: SvgPicture.asset(
                //                               'assets/svgs/Search.svg'),
                //                         ),
                //                       ),
                //                     ),
                //                     SmartPayTextButton(
                //                       onTap: () {
                //                         RouteNavigators.pop(context);
                //                       },
                //                       title: 'Cancel',
                //                       fontSize: getScreenHeight(16),
                //                       fontWeight: FontWeight.w700,
                //                     )
                //                   ],
                //                 ),
                //                 yMargin(24),
                //                 Expanded(
                //                   child: ListView.builder(
                //                     itemCount: listOfAllUsedCountries.length,
                //                     itemBuilder: (context, index) {
                //                       int selectIndex =
                //                           selectedIndexNumber.value;
                //                       CountryListModel dataToUse =
                //                           listOfAllUsedCountries[index];
                //                       return CountryListWidget(
                //                         countryName: dataToUse.counrtyName,
                //                         countryAbbrevation:
                //                             dataToUse.countryAbbrevtion,
                //                         imagePath: dataToUse.imagePath,
                //                         currentIndex: index,
                //                         selectedIndex: selectIndex,
                //                         onTap: () {
                //                           selectedIndexNumber.value = index;
                //                           country.text = dataToUse.counrtyName;
                //                           countryCode.value =
                //                               dataToUse.countryAbbrevtion;
                //                           isSelected.value = true;
                //                           RouteNavigators.pop(context);
                //                         },
                //                       );
                //                     },
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         );
                //       },
                //     );
                //   },
                //   child: SmartPayTextField(
                //     controller: country,
                //     hintText: 'Select Country',
                //     icon: (isSelected.value == true)
                //         ? Padding(
                //             padding: EdgeInsets.all(getScreenHeight(10)),
                //             child: SvgPicture.asset(listOfAllUsedCountries[
                //                     selectedIndexNumber.value]
                //                 .imagePath),
                //           )
                //         : null,
                //     suffixIcon: Padding(
                //       padding: EdgeInsets.all(getScreenHeight(15)),
                //       child: SvgPicture.asset('assets/svgs/arrowdown.svg'),
                //     ),
                //     enable: false,
                //   ),
                // ),
                // yMargin(16),
                Container(
                  width: getScreenWidth(321),
                  height: getScreenHeight(192),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/Rectangle4084.png'),
                    ),
                  ),
                  child: Padded(
                    // size: 35,
                    child: meansOfIdentification == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //SvgPicture.asset('assets/svgs/add(1)1.svg'),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getScreenWidth(40)),
                                child: SmartPayMainButton(
                                  text: 'Browse',
                                  onTap: () async {
                                    final ImagePicker picker = ImagePicker();
                                    // Pick an image.
                                    final XFile? image = await picker.pickImage(
                                        source: ImageSource.camera,
                                        maxHeight: 1200,
                                        maxWidth: 800);
                                    if (image != null) {
                                      setState(() {
                                        meansOfIdentification = image;
                                      });

                                      meansOfIdentification!
                                          .readAsBytes()
                                          .then((value) {
                                        setState(() {
                                          memoryImage = value;
                                        });
                                      });

                                      final response = await cloudinary.upload(
                                          file: image.path,
                                          //fileBytes: image.readAsBytes(),
                                          resourceType:
                                              CloudinaryResourceType.image,
                                          folder: 'SmartPay',
                                          // fileName: 'some-name',
                                          progressCallback: (count, total) {
                                            print(
                                                'Uploading image from file with progress: $count/$total');
                                          });

                                      if (response.isSuccessful) {
                                        imageUrl.value = response.url ?? '';
                                        print(
                                            'Get your image from with ${response.secureUrl}');
                                      }

                                      // CloudinaryResponse response =
                                      //     await cloudinary.uploadFile(
                                      //   CloudinaryFile.fromFile(
                                      //     image.path,
                                      //     resourceType:
                                      //         CloudinaryResourceType.Image,
                                      //   ),
                                      // );

                                      if (imageUrl.value.isNotEmpty &&
                                          phoneNumberTextController
                                              .value.text.isNotEmpty &&
                                          address.value.text.isNotEmpty) {
                                        isButtonActive.value = true;
                                      } else {
                                        isButtonActive.value = false;
                                      }
                                    }
                                  },
                                  cornerRadius: 5,
                                  height: 30,
                                ),
                              ),
                              yMargin(10),
                              Text(
                                'Upload Profile Image',
                                textAlign: TextAlign.center,
                                style: kTextStyleCustom(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        : Center(
                            child: Stack(
                              children: [
                                Align(
                                  child: memoryImage != null
                                      ? Image.memory(memoryImage!)
                                      : Container(),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        meansOfIdentification = null;
                                        memoryImage = null;
                                      });
                                    },
                                    child: const Icon(Icons.delete),
                                  ),
                                )
                              ],
                            ),
                          ),
                  ),
                ),
                yMargin(20),
                Consumer(builder: (context, ref, child) {
                  final isItLoading =
                      ref.watch(verifyEmaillCheckingButtonProvider);
                  return !isItLoading
                      ? SmartPayMainButton(
                          text: 'Continue',
                          backgroundColor: isButtonActive.value
                              ? kBLKCOLOUR
                              : kINACTIVECOLOR,
                          onTap: () async {
                            if (profileDetailsFormKey.currentState!
                                    .validate() &&
                                isButtonActive.value == true) {
                              changeValue(ref, true);
                              //The api response was giving error 422, a database error, so to make it flow without the call.
                              // RouteNavigators.route(
                              //   context,
                              //   const CreatePinScreen(),
                              // );
                              final action = await ref
                                  .read(emaillCheckingProvider.notifier)
                                  .register(
                                    image: imageUrl.value,
                                    username: widget.username,
                                    email: widget.email,
                                    phoneNumber: phoneNumberTextController.text,
                                    password: widget.password,
                                    address: address.text,
                                  );
                              if (action == true) {
                                // ignore: use_build_context_synchronously
                                kToastMsgPopUp('Registration Successful');
                                RouteNavigators.route(
                                  context,
                                  const SignInScreen(),
                                );
                              }
                              print(action);

                              changeValue(ref, false);
                            }
                          },
                        )
                      : const LoadingWidget();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
