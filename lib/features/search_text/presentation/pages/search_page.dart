import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/assets/animations/animations.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/core/spacing/whitspacing.dart';
import 'package:gemini/core/usecase/usecase.dart';
import 'package:gemini/core/widgets/bottom_sheet.dart';
import 'package:gemini/core/widgets/default_button.dart';
import 'package:gemini/features/search_text/presentation/widgets/data_add.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gemini/features/search_text/presentation/bloc/search_bloc.dart';
import 'package:gemini/features/search_text/presentation/widgets/buttons_below.dart';
import 'package:gemini/features/search_text/presentation/widgets/history_shimmer.dart';
import 'package:gemini/features/search_text/presentation/widgets/search_type.dart';
import 'package:gemini/features/search_text/presentation/widgets/show_error.dart';
import 'package:gemini/features/search_text/presentation/widgets/slidable_action.dart';
import 'package:gemini/features/sql_database/entities/text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lottie/lottie.dart';




class SearchTextPage extends StatefulWidget {
  const SearchTextPage({super.key});
  @override
  State<SearchTextPage> createState() => _SearchTextPage();
}

class _SearchTextPage extends State<SearchTextPage> {
  final searchBloc = sl<SearchBloc>();
  final searchBloc2 = sl<SearchBloc>();
  final searchBloc3 = sl<SearchBloc>();
  final userBloc = sl<AuthenticationBloc>();
  final ScrollController _scrollController=ScrollController();

  final form = GlobalKey<FormState>();
  List<Uint8List> all = [];
  List<Uint8List> newAll = [];
  List<String> imageExtensions = [];
  int imageLength = 0;

  List<String> snapInfo = [];
  String info = "How can I help you today?";
  int type = RequestType.stream.value;
  bool isTextImage = false;
  bool isAdded = false;
  String? question;
  String repeatQuestion = "";
  String name = "";
  String joinedSnapInfo = "";
  String? email;
  String? userName;
  String initText = "";
  final controller = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
   Uint8List? byte;
  bool isAvailable = false;
  bool isSpeechTextEnabled = false;
  

  getTime() {
    Timer.periodic(const Duration(seconds: 90), (timer) {
      print(timer.tick);
    });
  }

  @override
  void initState() {
    super.initState();
    initText = controller.text;
  }

  List<TextEntity>? data = [];
 
    void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeInOut,
      ),
    );
  }
  void execute({required String data,required int eventType})async{
                final newId = await searchBloc.readData();
                datas.add(DataAdd(
                  images: all,
                  data: data,
                  title: question!.isNotEmpty ? question! : repeatQuestion,
                  searchBloc: searchBloc,
                ));
                final params = {
                  "textId": newId!.isNotEmpty ? newId.last.textId + 1 : 0 + 1,
                  "textTopic":
                      (question!.isNotEmpty ? question! : repeatQuestion),
                  "textData": data,
                  "dateTime": DateTime.now().toString(),
                  "eventType": eventType,
                };
                searchBloc.addData(params);
                searchBloc.add(ReadAllEvent());
                _scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    // userBloc.add(GetUserCacheDataEvent());
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          backgroundColor: Theme.of(context).brightness != Brightness.dark
              ? Colors.white
              : Colors.black,
          title: const Text("Jerrito Gemini AI"),
          leading: IconButton(
              onPressed: () async {
                scaffoldKey.currentState?.openDrawer();
                 searchBloc2.add(ReadSQLDataEvent());
                // userBloc.add(GetUserCacheDataEvent());
               
              },
              icon: const Icon(Icons.menu)),
          centerTitle: true,
          actions: [
            BlocListener(
              bloc: searchBloc3,
              listener: (context, state) {
                if (state is OnSpeechResultLoaded) {
                  controller.text = state.result;
                  setState(() {});
                }
                if (state is IsSpeechTextEnabledError) {
                  if (!context.mounted) return;
                  showErrorSnackbar(context, state.errorMessage);
                }
                if (state is IsSpeechTextEnabledLoaded) {
                  searchBloc3.add(
                    ListenSpeechTextEvent(),
                  );
                  setState(() {
                    isSpeechTextEnabled = !isSpeechTextEnabled;
                  });
                }
                if (state is StopSpeechTextLoaded) {
                  setState(() {
                    isSpeechTextEnabled = !isSpeechTextEnabled;
                  });
                }
              },
              child: GestureDetector(
                onTap: () => searchBloc3.add(isSpeechTextEnabled
                    ? StopSpeechTextEvent()
                    : IsSpeechTextEnabledEvent()),
                child: isSpeechTextEnabled
                    ? Container(
                        height: Sizes().height(context, 0.07),
                        width: Sizes().width(context, 0.14),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 18, 33, 207),
                            shape: BoxShape.circle),
                        child: const Icon(Icons.mic, color: Colors.red),
                      )
                    : const Icon(Icons.mic),
              ),
            ),
            Space().width(context, 0.04)
          ]),
      bottomSheet: Form(
        key: form,
        child: Container(
          color: Theme.of(context).brightness != Brightness.dark
              ? Colors.white
              : Colors.black,
          child: BottomSheetTextfield(
            byte: byte,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "";
              }
              if (isTextImage) {
                if (all.isEmpty) {
                  return "image is required";
                }
              }
              return null;
            },
            onChanged: (value) {

              if (value!.isEmpty) {
                isAvailable = false;
                setState((){});
              }
              if (value.isNotEmpty) {
                isAvailable = true;
                setState((){});
              }
              initText = value;
            },
            controller: controller,
            onPressed: !isAvailable
                ? null
                : () {
                    if (form.currentState?.validate() == true &&
                        controller.text.isNotEmpty) {
                      Map<String, dynamic> params = {
                        "text": controller.text,
                      };
                      Map<String, dynamic> paramsWithImage = {
                        "text": controller.text,
                         "ext": imageExtensions,
                        "image": all,
                        "images": imageLength,
                      };
                      switch (type) {
                        case 4:
                          searchBloc.add(
                            SearchTextEvent(
                              params: params,
                            ),
                          );
                          break;

                        case 3:
                          searchBloc.add(
                            ChatEvent(
                              params: params,
                            ),
                          );
                          break;

                        case 2:
                          searchBloc.add(
                            SearchTextAndImageEvent(
                              params: paramsWithImage,
                            ),
                          );
                          break;
                        case 1:
                          searchBloc.add(
                            GenerateStreamEvent(
                              params: params,
                            ),
                          );
                          break;
                        case 5:
                          searchBloc.add(
                            GenerateContentEvent(
                              params: params,
                            ),
                          );
                        default:
                          searchBloc.add(
                            GenerateStreamEvent(
                              params: params,
                            ),
                          );
                          break;
                      }
                    }
                  },
            onTap: () {
              searchBloc2.add(AddMultipleImageEvent(
                noParams: NoParams(),
              ));
            },
            isTextAndImage: isTextImage,
            isTextEmpty: isAvailable,
            isAdded:isAdded
           
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes().width(
            context,
            0.02,
          ),
          vertical: Sizes().height(
            context,
            0.02,
          ),
        ),
        child: BlocListener(
          bloc: searchBloc2,
          listener: (context, state) async {
            if (state is AddMultipleImageLoaded) {
              all.clear();
              imageExtensions.clear();
              imageLength = 0;
              //  info = "";
              question = "";

              for (int i = 0; i < state.data.length; i++) {
                all.addAll(state.data.keys.elementAt(i));
                imageExtensions.addAll(state.data.values.elementAt(i));
              }
              imageLength = all.length;
              byte=all[0];
              setState((){});

              isTextImage = false;
              isAdded=true;


              // final dataGet = await Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) {
              //     return ConfirmImageWithTextPage(
              //       all: all,
              //       textData: controller.text,
              //     );
              //   }),
              // );

              // if (dataGet != null) {
                // controller.text = dataGet["text"];
                
              // }
            }
            if (state is AddMultipleImageLoading) {
              //all.clear();
            }
          },
          child: BlocConsumer(
            bloc: searchBloc,
            listener: (context, state) async {
              if (state is SearchTextLoaded) {
                final data = state.data;
                execute(data: data, eventType: 4);
              }

              if (state is ChatLoaded ) {
                final data = state.data;
                execute(data: data, eventType: 3);
                
              }

              if (state is GenerateStreamStop) {
                all.clear();
                if (snapInfo.isNotEmpty) {
                  final newId = await searchBloc.readData();
                  joinedSnapInfo = snapInfo.join("");

                  final params = {
                    "textId": newId!.isNotEmpty ? newId.last.textId + 1 : 0 + 1,
                    "textTopic":
                        (question!.isNotEmpty ? question! : repeatQuestion),
                    "textData": joinedSnapInfo,
                    "dateTime": DateTime.now().toString(),
                    "eventType": 1,
                  };
                  searchBloc.addData(params);
                }
              }

              if (state is SearchTextAndImageLoaded) {
                final data = state.data;
                execute(data: data, eventType: 2);
                isAdded=false;
                setState((){});
              }

              if (state is GenerateContentError) {
                if (!context.mounted) return;
                showErrorSnackbar(context, state.errorMessage);
              }
              if (state is SearchTextAndImageError) {
                if (!context.mounted) return;
                showErrorSnackbar(context, state.errorMessage);
              }
              if (state is SearchTextError) {
                if (!context.mounted) return;
                showErrorSnackbar(context, state.errorMessage);
              }

              if (state is GenerateStreamError) {
                controller.text = "";
                if (!context.mounted) return;
                showErrorSnackbar(context, state.errorMessage);
              }
              if (state is ChatError) {
                if (!context.mounted) return;
                showErrorSnackbar(context, state.errorMessage);
              }
              if (state is SearchTextAndImageLoading ||
                  state is SearchTextLoading ||
                  state is ChatLoading ||
                  state is GenerateStreamLoading) {
                question = controller.text;
                controller.text = "";
                isAvailable=false;
              }
            },
            builder: (context, state) {
              if (state is SearchTextAndImageLoading ||
                  state is SearchTextLoading ||
                  state is ChatLoading ||
                  state is GenerateStreamLoading) {
                return Column(
                  children: [
                    Center(
                      child: Lottie.asset(
                        aiJson,
                      ),
                    ),
                  ],
                );
                
              }
              if (state is GenerateStream) {
                final params = {"text": question};

                return StreamBuilder(
                    stream: searchBloc.generateStream(params),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        snapInfo.clear();
                        return Center(
                          child: Lottie.asset(
                            aiJson,
                          ),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        searchBloc.add(GenerateStreamStopEvent());
                      }
                      if (snapshot.hasError) {
                        // final data = snapshot.error;

                        // return SingleChildScrollView(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(question!.isNotEmpty
                        //           ? question!
                        //           : repeatQuestion),
                        //       Space().height(context, 0.02),
                        //       Text(data.toString()),
                        //       Space().height(context, 0.03),
                        //     ],
                        //   ),
                        // );
                      }
                      if (snapshot.hasData) {
                        final data = snapshot.data?.text ??
                            snapshot.data?.promptFeedback?.blockReasonMessage;
                        snapInfo.add(data!);
                        return Column(
                          children: [
                            Flexible(
                              child: ListView.builder(
                                itemCount: snapInfo.length,
                                itemBuilder: (context, index) {
                                  final dataFromSnap = snapInfo[index];
                                  return Text(dataFromSnap);
                                },
                              ),
                            ),
                            Space().height(context, 0.1),
                          ],
                        );
                      }
                      return const SizedBox();
                    });
              }
              // if(state is GenerateStreamError){
              //   final error=state.errorMessage;

              //    return Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Lottie.asset(noJson),
              //         Space().height(context, 0.02),
              //         Text(error,
              //             style:
              //              const   TextStyle(fontSize: 18, color: Colors.red,),),
              //       ]);
              //       }

              if (state is GenerateStreamStop) {
                String copyTextData =
                    (question!.isNotEmpty ? question! : repeatQuestion) +
                        joinedSnapInfo;

                final params = {
                  "text": copyTextData,
                };
                if (snapInfo.isEmpty) {

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Lottie.asset(noJson),
                      Space().height(context, 0.02),
                      const Text("Invalid request",
                          style: TextStyle(fontSize: 18, color: Colors.red)),
                      Space().height(context, 0.05),
                      DefaultButton(
                          label: "Retry",
                          onTap: () {
                            final param = {
                              "text": (question!.isNotEmpty
                                  ? question!
                                  : repeatQuestion),
                            };
                            searchBloc.add(
                              GenerateStreamEvent(
                                params: param,
                              ),
                            );
                          })
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Text(question!.isNotEmpty ? question! : repeatQuestion,
                          style: const TextStyle(
                              fontSize: 16,
                              decorationStyle: TextDecorationStyle.solid)),
                      Flexible(
                        child: ListView.builder(
                          itemCount: snapInfo.length,
                          itemBuilder: (context, index) {
                            final dataFromSnap = snapInfo[index];
                            return Text(dataFromSnap);
                          },
                        ),
                      ),
                      ButtonsBelowResult(
                          onCopy: () async {
                            searchBloc.copyText(params);
                          },
                          onRetry: null,
                          onShare: () async {
                            await Share.share((question!.isNotEmpty
                                    ? question!
                                    : repeatQuestion) +
                                joinedSnapInfo);
                          }),
                      Space().height(context, 0.1),
                    ],
                  );
                }
              }
              if (state is ReadAll) {
                // final data = state.data;
                return Column(
                    children: [
                     Expanded(
                       child: ListView.builder(
                          controller: _scrollController,
                         shrinkWrap: true,
                           itemCount: datas.length,
                          //  physics: const NeverScrollableScrollPhysics(),
                           itemBuilder: (context, index) {
                             final da = datas[index];
                             return DataAdd(
                               title: da.title,
                               images: da.images,
                               data: da.data,
                               searchBloc: searchBloc,
                             );
                           },
                         ),
                     ),
                       Space().height(context, 0.09)
                    ],
                  );
              }
          
              if (state is ReadDataDetailsLoaded) {
                final data = state.textEntity;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(data!.textTopic,
                          style: const TextStyle(
                              fontSize: 16,
                              decorationStyle: TextDecorationStyle.solid)),
                      Space().height(context, 0.02),
                      if (data.imageData != null) Image.memory(data.imageData!),
                      Space().height(context, 0.02),
                      Text(data.textData),
                      ButtonsBelowResult(
                          onCopy: () async {
                            searchBloc.copyText({"text": data.textData});
                          },
                          onRetry: data.eventType == 2 || data.eventType == 1
                              ? null
                              : () {
                                  repeatQuestion = data.textTopic;
                                  switch (data.eventType) {
                                    case 3:
                                      searchBloc.add(
                                        ChatEvent(
                                            params: {"text": repeatQuestion}),
                                      );
                                      break;
                                    case 4:
                                      searchBloc.add(
                                        SearchTextEvent(
                                            params: {"text": repeatQuestion}),
                                      );
                                      break;
                                    default:
                                      searchBloc.add(
                                        GenerateStreamEvent(
                                            params: {"text": repeatQuestion}),
                                      );
                                      break;
                                  }
                                },
                          onShare: () async {
                            await Share.share(data.textTopic + data.textData);
                          }),
                      Space().height(context, 0.1),
                    ],
                  ),
                );
              }
              if (isSpeechTextEnabled) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'Listening',
                      ),
                    ),
                    Text("00:01"),
                  ],
                );
              } else {
               return SingleChildScrollView(
                 child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Space().height(context, 0.1),
                              Center(child: Lottie.asset(ai2Json)),
                            ]),
               );
                    
              }
            },
          ),
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              BlocListener(
                bloc: userBloc,
                listener: (context, state) async {
                  if (state is GetUserCachedDataLoaded) {
                    email = state.user.email;
                    userName = state.user.userName;
                  }
                  if (state is GetUserCacheDataError) {}
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        child: Text(
                          userName?.substring(0, 1).toUpperCase() ??
                              email?.substring(0, 1).toUpperCase() ??
                              "",
                        ),
                      ),
                      Text(
                        userName ?? email ?? "",
                      ),
                    ]),
              ),
              SearchTypeWidget(
                value:type ,
                type: RequestType.stream,
                onTap: () {
                  type=RequestType.stream.value;
                  RequestType.stream;
                  isTextImage = false;
                  isAdded=false;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              SearchTypeWidget(
                value:type,
                type:RequestType.textImage,
                onTap: () {
                  type=RequestType.textImage.value;
                   RequestType.textImage;
                  isTextImage = true;
                  isAdded=false;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              SearchTypeWidget(
                value:type ,
               type: RequestType.chat,
                onTap: () async {
                  type=RequestType.chat.value;
                  RequestType.chat;
                  isTextImage = false;
                  isAdded=false;
                  Navigator.pop(context);
                  setState(() {});
                },
              ),
              SearchTypeWidget(
                value:type ,
                onTap: () {
                type=RequestType.future.value;
                  isTextImage = false;
                  isAdded=false;
                  Navigator.pop(context);
                  setState(() {});
                },
                type:RequestType.future
              ),
              const Divider(
                thickness: 2,
              ),
              const Center(
                child: Text("History",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline)),
              ),
              BlocConsumer(
                bloc: searchBloc2,
                builder: (context, state) {
                  if (state is ReadDataLoading) {
                    //  print("dd");
                    return const HistoryShimmer();
                  }

                  if (state is ReadDataLoaded) {
                    final response = state.data;
                    return response!.isEmpty
                        ? Lottie.asset(historyJson)
                        : Flexible(
                            child: ListView.builder(
                              //reverse: true,
                              shrinkWrap: response.length > 7 ? false : true,
                              itemCount: response.isEmpty ? 0 : response.length,
                              itemBuilder: (context, index) {
                                final datas = response[index];
                                final params = {
                                  "textId": datas.textId,
                                  "textTopic": datas.textTopic,
                                  "textData": datas.textData,
                                  "imageData": datas.imageData,
                                  "eventType": datas.eventType,
                                  "dateTime": datas.dateTime,
                                };
                                return Slidable(
                                  // Specify a key if the Slidable is dismissible.
                                  key: const ValueKey(0),
                                  startActionPane: ActionPane(
                                    // A motion is a widget used to control how the pane animates.
                                    motion: const ScrollMotion(),

                                    // A pane can dismiss the Slidable.
                                    // dismissible: DismissiblePane(onDismissed: () {}),

                                    // All actions are defined in the children parameter.
                                    children: [
                                      // A SlidableAction can have an icon and/or a label.
                                      SlidableActionWidget(
                                        onPressed: (context) async {
                                          await Share.share(
                                              datas.textTopic + datas.textData);
                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                        },
                                        isDeleteButton: false,
                                      ),

                                      SlidableActionWidget(
                                        onPressed: (context) async {
                                          await searchBloc2.deleteData(params);
                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                        },
                                        isDeleteButton: true,
                                      ),
                                    ],
                                  ),

                                  // The end action pane is the one at the right or the bottom side.
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableActionWidget(
                                        onPressed: (context) async {
                                          await Share.share(
                                              datas.textTopic + datas.textData);
                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                        },
                                        isDeleteButton: false,
                                      ),
                                      SlidableActionWidget(
                                        onPressed: (context) async {
                                          await searchBloc2.deleteData(params);
                                          if (!context.mounted) return;
                                          Navigator.pop(context);
                                        },
                                        isDeleteButton: true,
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      searchBloc.add(
                                        ReadDataDetailsEvent(params: params),
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical:
                                            Sizes().height(context, 0.005),
                                        horizontal:
                                            Sizes().width(context, 0.02),
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(Sizes()
                                                      .height(context, 0.01)),
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.black
                                                  : Colors.black12),
                                          padding: EdgeInsets.symmetric(
                                            vertical:
                                                Sizes().height(context, 0.01),
                                            horizontal:
                                                Sizes().width(context, 0.02),
                                          ),
                                          child: Center(
                                              child: Text(
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      letterSpacing: 1.2),
                                                  datas.textTopic))),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                  }
                  return const SizedBox();
                },
                listener: (BuildContext context, Object? state) {
                  if (state is ReadDataError) {
                    showErrorSnackbar(context, state.errorMessage);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  

  List<DataAdd> datas = [];
}

enum RequestType{
  stream(label:"Stream content",icon:Icons.stream,color:Colors.green,value:1),
  textImage(label:"Search text with image",icon:Icons.stream,color:Colors.green,value:2),
  chat(label:"Chat with bot",icon:Icons.chat,color:Colors.green,value:3),
  future(label:"Await content",icon:Icons.text_format,color:Colors.green,value:4);
  final String label;
  final IconData? icon;
  final Color? color;
  final int value;
 

  const RequestType({required this.value, required this.label,
  required this.icon,required this.color});
}