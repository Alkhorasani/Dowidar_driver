import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:dowidardriver/ClassModules/cmGlobalVariables/cmGlobalVariables.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../MVVM/Model/ModChat/chat_message_model.dart';
import '../CustomWidgets/app_string_constants.dart';
import '../CustomWidgets/color_util.dart';
import '../CustomWidgets/custom_icon_btn.dart';
import '../CustomWidgets/custom_text_field.dart';
import '../CustomWidgets/text.dart';
import '../CustomWidgets/text_style_util.dart';
import '../CustomWidgets/utils.dart';
import '../components/custom_image_viewer.dart';
import '../components/view_image_list.dart';
import '../provider/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.fromSupport});

  final bool fromSupport;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isFirstTime = true;

  String fullPath = '';
  List<String>? receiverId;

  String? orderId;

  String senderId = '';

  final pattern = RegExp(r"\+\d{10,}");
  bool isNumber = false;

  final ImagePicker picker = ImagePicker();
  List<File>? selectedAttachment;
  bool isAttachment = false;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    setReceiverId();
    super.initState();
  }

  setReceiverId() {
    setState(() {
      receiverId = [cmGlobalVariables.pbUserID!];
      senderId = cmGlobalVariables.pbDriberID!;
      orderId = cmGlobalVariables.pBOntapOrderId!.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: widget.fromSupport ? AppConstants.suport : AppConstants.chat,
            styleElement: LmsTextUtil.CustomText18(
              ColorUtil.textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: SingleChildScrollView(
                  reverse: true,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    StreamBuilder(
                        stream: FirebaseDatabase.instance
                            .ref('threads')
                            .child("orders/${chatProvider.getSortedId(orderId!, senderId, receiverId!.first)}/messages")
                            .onValue,
                        builder: (context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            // Deserialize the chat messages from the snapshot
                            if (snapshot.data!.snapshot.value != null) {
                              Map<Object?, Object?>? messagesJson = snapshot.data!.snapshot.value;

                              if (messagesJson != null) {
                                List<ChatMessage> messages =
                                    messagesJson.entries.map((entry) => ChatMessage.fromJson(entry.value)).toList();

                                print(messages.last.message);

                                messages.sort((a, b) {
                                  return a.dateTime.compareTo(b.dateTime);
                                });
                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ...messages.map((e) {
                                        if (e.message.isNotEmpty) {
                                          final match = pattern.firstMatch(e.message);
                                          if (match != null) {
                                            isNumber = true;
                                          } else {
                                            isNumber = false;
                                          }
                                        }
                                        return Container(
                                            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                            padding: EdgeInsets.only(
                                                left: (e.senderId == cmGlobalVariables.pbDriberID ? 130.w : 0),
                                                right: (e.senderId != cmGlobalVariables.pbDriberID ? 130.w : 0)),
                                            alignment: e.senderId == cmGlobalVariables.pbDriberID
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                            child: Column(
                                                mainAxisAlignment: e.senderId == cmGlobalVariables.pbDriberID
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.start,
                                                children: [
                                                  if ((e.attachments != null && e.attachments!.isNotEmpty)) ...[
                                                    Row(children: [
                                                      if (e.attachments!.length < 4)
                                                        if (e.message.isNotEmpty) ...[
                                                          Expanded(
                                                              child: SizedBox(
                                                                  height: (e.message.isEmpty) ? 160.h : 180.h,
                                                                  child: Card(
                                                                      margin: EdgeInsets.zero,
                                                                      color: ColorUtil.bgColor,
                                                                      child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Row(
                                                                                children: [
                                                                                  for (var attachment
                                                                                      in e.attachments!) ...[
                                                                                    Expanded(
                                                                                      child: Card(
                                                                                        child: Container(
                                                                                          padding: EdgeInsets.all(2.sp),
                                                                                          child: showAttachement(
                                                                                            attachment.toString(),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ]
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            const Divider(),
                                                                            Padding(
                                                                              padding: EdgeInsets.symmetric(
                                                                                  horizontal: 8.0.w, vertical: 2.h),
                                                                              child: CustomText(
                                                                                text: e.message,
                                                                                styleElement: LmsTextUtil.CustomText12(
                                                                                  ColorUtil.textWhite,
                                                                                  fontWeight: FontWeight.w300,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(height: 3.h)
                                                                          ]))))
                                                        ] else
                                                          for (var attachment in e.attachments!) ...[
                                                            Expanded(child: showAttachement(attachment.toString()))
                                                          ]
                                                      else ...[
                                                        Expanded(
                                                            child: InkWell(
                                                                onTap: () {
                                                                  Navigator.of(context).push(CupertinoPageRoute(
                                                                      builder: (_) =>
                                                                          ViewImageList(images: e.attachments!)));
                                                                },
                                                                child: SizedBox(
                                                                    height: (e.message.isEmpty) ? 160.h : 180.h,
                                                                    child: Card(
                                                                        margin: EdgeInsets.zero,
                                                                        // color: ColorUtil.bgColor,
                                                                        child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Expanded(
                                                                                  child: Row(children: [
                                                                                Expanded(
                                                                                    child: Card(
                                                                                        child: showAttachement(e
                                                                                            .attachments![0]
                                                                                            .toString()))),
                                                                                Expanded(
                                                                                    child: Card(
                                                                                        child: showAttachement(e
                                                                                            .attachments![1]
                                                                                            .toString())))
                                                                              ])),
                                                                              Expanded(
                                                                                  child: Row(children: [
                                                                                Expanded(
                                                                                  child: Card(
                                                                                    child: showAttachement(
                                                                                        e.attachments![2].toString()),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                    child: Card(
                                                                                        child: Center(
                                                                                            child: CustomText(
                                                                                  text:
                                                                                      "+ ${e.attachments!.length - 3}",
                                                                                  styleElement:
                                                                                      LmsTextUtil.CustomText12(
                                                                                    ColorUtil.smallText,
                                                                                    fontWeight: FontWeight.w300,
                                                                                  ),
                                                                                ))))
                                                                              ])),
                                                                              const Divider(),
                                                                              Padding(
                                                                                  padding: EdgeInsets.symmetric(
                                                                                      horizontal: 8.0.w, vertical: 2.h),
                                                                                  child: CustomText(
                                                                                    text: e.message,
                                                                                    styleElement:
                                                                                        LmsTextUtil.CustomText12(
                                                                                      ColorUtil.smallText,
                                                                                      fontWeight: FontWeight.w300,
                                                                                    ),
                                                                                  ))
                                                                            ])))))
                                                      ]
                                                    ])
                                                  ],
                                                  if ((e.message.isNotEmpty) && e.attachments!.isEmpty)
                                                    Row(
                                                        mainAxisAlignment: e.senderId == cmGlobalVariables.pbDriberID
                                                            ? MainAxisAlignment.end
                                                            : MainAxisAlignment.start,
                                                        children: [
                                                          Flexible(
                                                              child: Card(
                                                                  elevation: 5.0,
                                                                  color: e.senderId == cmGlobalVariables.pbDriberID
                                                                      ? ColorUtil.splashScreenColor
                                                                      : Colors.grey,
                                                                  child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: isNumber
                                                                          ? InkWell(
                                                                              onTap: () async {
                                                                                var url =
                                                                                    "tel:${e.message.substring(e.message.indexOf('+'))}";
                                                                                if (await canLaunch(url)) {
                                                                                  await launch(url);
                                                                                } else {
                                                                                  throw 'Could not launch $url';
                                                                                }
                                                                              },
                                                                              child: Row(children: [
                                                                                CircleAvatar(
                                                                                    backgroundColor: Colors.white,
                                                                                    radius: 20.r,
                                                                                    child: Icon(Icons.person,
                                                                                        color: ColorUtil
                                                                                            .splashScreenColor)),
                                                                                SizedBox(width: 5.w),
                                                                                Expanded(
                                                                                    child: CustomText(
                                                                                  text: e.message ?? "",
                                                                                  styleElement:
                                                                                      LmsTextUtil.CustomText12(
                                                                                    ColorUtil.textWhite,
                                                                                    fontWeight: FontWeight.w300,
                                                                                  ),
                                                                                ))
                                                                              ]))
                                                                          : CustomText(
                                                                              text: e.message ?? "",
                                                                              styleElement: LmsTextUtil.CustomText12(
                                                                                ColorUtil.textWhite,
                                                                                fontWeight: FontWeight.w400,
                                                                              ),
                                                                            ))))
                                                        ]),
                                                  Align(
                                                      alignment: e.senderId == cmGlobalVariables.pbDriberID
                                                          ? Alignment.centerRight
                                                          : Alignment.centerLeft,
                                                      child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                          child: CustomText(
                                                            text: AppUtils.getTimeFromData(e.dateTime),
                                                            styleElement: LmsTextUtil.CustomText12(
                                                              ColorUtil.smallText,
                                                              fontWeight: FontWeight.w300,
                                                            ),
                                                          )))
                                                ]));
                                      }).toList(),
                                      (chatProvider.isSendingMessage && chatProvider.messageText.isNotEmpty)
                                          ? Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Flexible(
                                                  child: Card(
                                                    elevation: 5.0,
                                                    color: ColorUtil.chipText,
                                                    child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Wrap(
                                                          children: [
                                                            CustomText(
                                                              text: chatProvider.messageText ?? "",
                                                              styleElement: LmsTextUtil.CustomText12(
                                                                ColorUtil.smallText,
                                                                fontWeight: FontWeight.w300,
                                                              ),
                                                            ),
                                                            SizedBox(width: 5.w),
                                                            Icon(
                                                              CupertinoIcons.clock,
                                                              color: Colors.white,
                                                              size: 14.sp,
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                      SizedBox(height: 5.h),
                                      (chatProvider.isSendingMessage &&
                                              (chatProvider.messageText.isEmpty || chatProvider.messageText == ''))
                                          ? Align(
                                              alignment: Alignment.bottomCenter,
                                              child: SizedBox(
                                                height: 60.h,
                                                width: 1.sw,
                                                child: const Center(child: CircularProgressIndicator()),
                                              ),
                                            )
                                          : Container()
                                    ]);
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          } else {
                            return AppUtils.showLoader();
                          }
                        })
                  ]))),
          isAttachment
              ? Container(
                  color: ColorUtil.splashScreenColor.withOpacity(0.2),
                  height: 120.h,
                  child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedAttachment!.length,
                      itemBuilder: (context, index) {
                        return Stack(children: [
                          AppUtils.isImageUrl(selectedAttachment![index].path)
                              ? Container(
                                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.file(selectedAttachment![index], fit: BoxFit.cover)))
                              : Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child:
                                          Center(child: Icon(_getIconForExtension(selectedAttachment![index].path))))),
                          Positioned(
                              right: 0,
                              child: InkWell(
                                  onTap: () {
                                    if (selectedAttachment!.length == 1) {
                                      isAttachment = false;
                                      setState(() {});
                                    }
                                    selectedAttachment!.removeAt(index);
                                    setState(() {});
                                  },
                                  child: Icon(Icons.cancel, size: 25.sp, color: Colors.red)))
                        ]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 8.w);
                      }))
              : Container(),
          // SizedBox(
          //   height: 5.h,
          // ),
          StreamBuilder<Object>(
              stream: FirebaseDatabase.instance
                  .ref('threads')
                  .child(chatProvider.getSortedId(orderId!, senderId, receiverId!.first))
                  .child('status')
                  .onValue,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                String messagesJson = snapshot.data != null && snapshot.data!.snapshot.value != null
                    ? snapshot.data!.snapshot.value
                    : "-1";
                return Wrap(children: [
                  Container(
                      color: ColorUtil.chipText,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Expanded(
                                child: CustomTextField1(
                                    readOnly: chatProvider.isSendingMessage,
                                    onChange: (value) {
                                      setState(() {
                                        value = messageController.text;
                                        chatProvider.messageText = value;
                                      });
                                    },
                                    width: 255.w,
                                    hintText: "Type Message...",
                                    controller: messageController,
                                    receiverId: '',
                                    suffixIcon: SizedBox(
                                        width: messageController.text.isEmpty ? 80.w : 40.w,
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                          messageController.text.isEmpty
                                              ? CustomIconButton(
                                                  onPressed: !chatProvider.isSendingMessage
                                                      ? () {
                                                          _showPicker();
                                                        }
                                                      : null,
                                                  icon: Icons.camera_alt_outlined,
                                                  color: ColorUtil.splashScreenColor,
                                                  size: 30.sp)
                                              : Container()
                                        ])))),
                            SizedBox(width: 8.w),
                            InkWell(
                                onTap: !chatProvider.isSendingMessage
                                    ? () async {
                                        if (isAttachment || messageController.text.isNotEmpty) {
                                          FocusScope.of(context).unfocus();
                                          if (messageController.text.isNotEmpty || selectedAttachment!.isNotEmpty) {
                                            chatProvider
                                                .sendAttachmentMessage(
                                              cmGlobalVariables.pbDriberID!,
                                              [cmGlobalVariables.pbUserID!],
                                              selectedAttachment ?? [],
                                              messageController.text,
                                              cmGlobalVariables.pBOntapOrderId.toString()!,
                                            )
                                                .then((value) {
                                              print(value);
                                              chatProvider.messageText = '';
                                            });
                                            selectedAttachment = [];
                                            isAttachment = false;
                                            messageController.clear();
                                          }
                                        }
                                      }
                                    : null,
                                child: Container(
                                    width: 55.h,
                                    height: 55.h,
                                    decoration:
                                        BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
                                    child: Center(
                                        child: Icon(Icons.send, color: ColorUtil.splashScreenColor, size: 30.sp))))
                          ])))
                ]);
              })
        ])));
  }

  Widget showAttachement(String url) {
    String updatedUrl = url.replaceFirst("", '');
    // print(updatedUrl);
    if (AppUtils.isImageUrl(url)) {
      return InkWell(
          onTap: () async {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => CustomImageViewer(
                      url: updatedUrl,
                    )));
          },
          child: CachedNetworkImage(
              imageUrl: updatedUrl,
              height: 150.h,
              width: 100.w,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error)));
    } else {
      List<String> fileName = updatedUrl.split('/');
      return InkWell(
          onTap: () async {
            Uri uri = Uri.parse(updatedUrl);
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          },
          child: SizedBox(
              height: 55.h,
              child: Card(
                  color: ColorUtil.bgColor,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      child: Row(children: [
                        Icon(Icons.attachment, size: 16.w),
                        const SizedBox(width: 3),
                        Expanded(
                          child: CustomText(
                            text: fileName.last,
                            styleElement: LmsTextUtil.CustomText12(
                              ColorUtil.smallText,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                      ])))));
    }
  }

  IconData _getIconForExtension(String extension) {
    final mimeType = AppUtils.isDocUrl(extension);
    if (mimeType != null && mimeType == '.pdf') {
      return Icons.picture_as_pdf;
    } else if (mimeType != null && (mimeType == '.doc' || mimeType == '.docx')) {
      return CupertinoIcons.doc_richtext;
    }
    // Add more cases for other file types as needed
    return Icons.insert_drive_file; // Default icon
  }

  Future getImage() async {
    await Permission.storage.request();
    var picture = await picker.pickImage(source: ImageSource.camera);
    if (picture != null) {
      setState(() {
        selectedAttachment = [File(picture.path)];
        isAttachment = true;
      });
    }
  }

  void _showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: CustomText(
                      text: AppConstants.photoLibrary,
                      styleElement: LmsTextUtil.CustomText24(
                        ColorUtil.dishListText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () async {
                      final List<XFile> pickedImage = await picker.pickMultipleMedia();
                      if (pickedImage.isNotEmpty) {
                        for (var media in pickedImage) {
                          selectedAttachment?.add(File(media.path));
                        }
                        setState(() {
                          isAttachment = true;
                        });
                      }
                      Navigator.pop(context);
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: CustomText(
                      text: AppConstants.camera,
                    styleElement: LmsTextUtil.CustomText24(
                      ColorUtil.dishListText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () async {
                    final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      setState(() {
                        selectedAttachment = [File(pickedImage.path)];
                        isAttachment = true;
                      });
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}
