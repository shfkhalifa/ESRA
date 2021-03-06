import 'dart:io';

import 'package:division/division.dart';

///
/// By Younss Ait Mou
///

import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/manageChildrenBloc/mangeChildren.dart';
import '../../bloc/predictionBloc/prediction.dart';
import '../../components/dialogs/infoDialog.dart';
import '../../components/errorWidget/errorWidget.dart';
import '../../components/feedbackWidget/feedBackWidget.dart';
import '../../components/loadingWidget/loadingWidget.dart';
import '../../components/predictionResultsWidget/predictionResultsWidget.dart';
import '../../models/child.dart';
import '../../repositories/predictionRepository.dart';
import '../../repositories/userRepository.dart';
import '../../styles.dart';
import 'package:http/http.dart' as http;

enum PredictionImageSource { camera, gallery }

class EvaluatePage extends StatefulWidget {
  const EvaluatePage({Key key}) : super(key: key);

  @override
  _EvaluatePageState createState() => _EvaluatePageState();
}

class _EvaluatePageState extends State<EvaluatePage> {
  Child _selectedChild;
  File _selectedImage;
  File _croppedImage;
  PredictionBloc _predictionBloc;
  http.Client httpClient;

  @override
  void initState() {
    super.initState();
    var url = Strings.INFERENCE_URL;
    _predictionBloc =
        PredictionBloc(context.repository<PredictionRepository>());
    httpClient = http.Client();
    // httpClient.post(
    //       url);
  }

  @override
  void dispose() {
    super.dispose();
    _predictionBloc.close();
  }

  void _makePrediction(PredictionImageSource source) async {
    switch (source) {
      case PredictionImageSource.gallery:
        _selectedImage =
            await ImagePicker.pickImage(source: ImageSource.gallery);
        if (_selectedImage != null)
          _croppedImage = await ImageCropper.cropImage(
            sourcePath: _selectedImage.path,
          );
        break;
      case PredictionImageSource.camera:
        _selectedImage =
            await ImagePicker.pickImage(source: ImageSource.camera);
        if (_selectedImage != null)
          _croppedImage =
              await ImageCropper.cropImage(sourcePath: _selectedImage.path);
        await GallerySaver.saveImage(_selectedImage.path);
        break;
      default:
    }
    if (_selectedImage != null)
      _predictionBloc.add(GetPrediction(imagePath: _selectedImage.path));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PredictionBloc, PredictionState>(
          bloc: _predictionBloc,
          listener: (context, state) async {
            if (state.isFeedbackSent != null && state.isFeedbackSent) {
              // Acknowledge feedback sent dialog
              await infoDialog(
                context,
                Strings.FEEDBACK_CONFIRMATION_DIALOG_TITLE,
                Strings.FEEDBACK_CONFIRMATION_DIALOG_BODY,
              );
            } else if (state.isPredictionSaved) {
              // Acknowledge prediction saved successfully dialog
              BlocProvider.of<ManagechildrenBloc>(context).add(GetChildren());
              await infoDialog(
                context,
                Strings.PREDICTION_SAVED_CONFIRMATION_DIALOG_TITLE,
                Strings.PREDICTION_SAVED_CONFIRMATION_DIALOG_BODY,
              );
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyles.darkBlue,
          title: Text(Strings.EVALUATE_TITLE),
        ),
        floatingActionButton: (_selectedChild != null)
            ? SpeedDial(
                // child: Image(
                //   image: AssetImage(AppIcons.analyze),
                //   color: Colors.white,
                // ),
                animatedIcon: AnimatedIcons.add_event,
                children: [
                  SpeedDialChild(
                    child: Icon(Icons.collections),
                    label: Strings.UPLOAD_BTN_LABEL,
                    onTap: () {
                      _makePrediction(PredictionImageSource.gallery);
                    },
                  ),
                  SpeedDialChild(
                    child: Icon(Icons.camera_alt),
                    label: Strings.CAPTURE_BTN_LABEL,
                    onTap: () {
                      _makePrediction(PredictionImageSource.camera);
                    },
                  ),
                ],
              )
            : null,
        body: BlocBuilder<ManagechildrenBloc, ManagechildrenState>(
          builder: (context, state) {
            if (state.childrenList.isEmpty) {
              return Center(child: Text(Strings.NO_CHILD_MESSAGE));
            }
            List<DropdownMenuItem<Child>> childrenMenuItems = [];
            List<Child> children = state.childrenList;
            children.forEach((child) {
              childrenMenuItems.add(DropdownMenuItem(
                value: child,
                child: Text(child.name),
              ));
            });
            return BlocBuilder<PredictionBloc, PredictionState>(
              bloc: _predictionBloc,
              builder: (context, state) {
                if (state.isPredicting) {
                  return LoadingWidget();
                } else if (state.isSuccess) {
                  if (_croppedImage == null) {
                    print("_croppedImage is null");
                  }
                  return PredictionResultWidget(
                    label: state.prediction.label,
                    score: state.prediction.score,
                    image: _croppedImage,
                    onDismiss: (bool shouldSave) {
                      if (shouldSave) {
                        // Save prediction result
                        _predictionBloc.add(
                          SavePrediction(
                            imagePath: _croppedImage.path,
                            prediction: state.prediction,
                            childId: _selectedChild.id,
                          ),
                        );
                      } else {
                        _predictionBloc.add(DismissPrediction());
                      }
                    },
                  );
                } else if (state.isPredictionDismissed) {
                  return FeedbackWidget(
                    onSubmit: (String feedback) async {
                      String token = await context
                          .repository<UserRepository>()
                          .readToken();
                      _predictionBloc.add(SendFeedback(
                        feedbackMsg: feedback,
                        childId: _selectedChild.id,
                        imagePath: _selectedImage.path,
                        prediction: state.prediction,
                        token: token,
                      ));
                    },
                  );
                } else if (state.isFailure) {
                  return EsraErrorWidget(
                    errorMsg: state.errorMsg,
                  );
                }
                return Parent(
                  style: ParentStyle()..alignment.center(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage(AppIllustrations.addDrawing),
                        width: 300,
                      ),
                      SizedBox(height: 24),
                      Parent(
                        style: AppStyles.dropDownStyle,
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(border: InputBorder.none),
                          hint: Text(Strings.EVALUATE_SELECT_CHILD_HINT),
                          items: childrenMenuItems,
                          onChanged: (Child value) {
                            setState(() {
                              _selectedChild = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
