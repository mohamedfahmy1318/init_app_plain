/// ========================================================
/// Image Picker Helper - مساعد اختيار الصور
/// ========================================================
/// تسهيل عملية اختيار وقص الصور
/// ========================================================

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../services/permission_service.dart';
import 'toast_helper.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  // ==================== Pick Image from Gallery ====================
  static Future<File?> pickImageFromGallery({
    bool crop = false,
    CropAspectRatio? aspectRatio,
    int imageQuality = 85,
  }) async {
    try {
      // Check permission
      final hasPermission = await PermissionService.requestPhotosPermission();
      if (!hasPermission) {
        ToastHelper.error('صلاحية الوصول للصور مطلوبة');
        return null;
      }

      // Pick image
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: imageQuality,
      );

      if (image == null) return null;

      File imageFile = File(image.path);

      // Crop if needed
      if (crop) {
        imageFile = await _cropImage(imageFile, aspectRatio) ?? imageFile;
      }

      return imageFile;
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
      ToastHelper.error('حدث خطأ أثناء اختيار الصورة');
      return null;
    }
  }

  // ==================== Pick Image from Camera ====================
  static Future<File?> pickImageFromCamera({
    bool crop = false,
    CropAspectRatio? aspectRatio,
    int imageQuality = 85,
  }) async {
    try {
      // Check permission
      final hasPermission = await PermissionService.requestCameraPermission();
      if (!hasPermission) {
        ToastHelper.error('صلاحية الكاميرا مطلوبة');
        return null;
      }

      // Take photo
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: imageQuality,
      );

      if (image == null) return null;

      File imageFile = File(image.path);

      // Crop if needed
      if (crop) {
        imageFile = await _cropImage(imageFile, aspectRatio) ?? imageFile;
      }

      return imageFile;
    } catch (e) {
      debugPrint('Error taking photo: $e');
      ToastHelper.error('حدث خطأ أثناء التقاط الصورة');
      return null;
    }
  }

  // ==================== Show Image Source Dialog ====================
  static Future<File?> showImageSourceDialog(
    BuildContext context, {
    bool crop = false,
    CropAspectRatio? aspectRatio,
    int imageQuality = 85,
  }) async {
    return await showModalBottomSheet<File?>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'اختر مصدر الصورة',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // === الكاميرا ===
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('الكاميرا'),
                onTap: () async {
                  final image = await pickImageFromCamera(
                    crop: crop,
                    aspectRatio: aspectRatio,
                    imageQuality: imageQuality,
                  );
                  if (sheetContext.mounted) {
                    Navigator.pop(sheetContext, image);
                  }
                },
              ),

              // === المعرض ===
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('المعرض'),
                onTap: () async {
                  final image = await pickImageFromGallery(
                    crop: crop,
                    aspectRatio: aspectRatio,
                    imageQuality: imageQuality,
                  );
                  if (sheetContext.mounted) {
                    Navigator.pop(sheetContext, image);
                  }
                },
              ),

              // === الإلغاء ===
              ListTile(
                leading: const Icon(Icons.close, color: Colors.red),
                title: const Text('إلغاء'),
                onTap: () => Navigator.pop(sheetContext),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== Crop Image ====================
  static Future<File?> _cropImage(
    File imageFile,
    CropAspectRatio? aspectRatio,
  ) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: aspectRatio,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'قص الصورة',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: aspectRatio != null,
          ),
          IOSUiSettings(
            title: 'قص الصورة',
            aspectRatioLockEnabled: aspectRatio != null,
          ),
        ],
      );

      if (croppedFile != null) {
        return File(croppedFile.path);
      }
      return null;
    } catch (e) {
      debugPrint('Error cropping image: $e');
      return null;
    }
  }

  // ==================== Pick Multiple Images ====================
  static Future<List<File>> pickMultipleImages({
    int maxImages = 10,
    int imageQuality = 85,
  }) async {
    try {
      final hasPermission = await PermissionService.requestPhotosPermission();
      if (!hasPermission) {
        ToastHelper.error('صلاحية الوصول للصور مطلوبة');
        return [];
      }

      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: imageQuality,
        limit: maxImages,
      );

      return images.map((image) => File(image.path)).toList();
    } catch (e) {
      debugPrint('Error picking multiple images: $e');
      ToastHelper.error('حدث خطأ أثناء اختيار الصور');
      return [];
    }
  }

  // ==================== Pick Video ====================
  static Future<File?> pickVideo({
    ImageSource source = ImageSource.gallery,
    Duration? maxDuration,
  }) async {
    try {
      final hasPermission = source == ImageSource.camera
          ? await PermissionService.requestCameraPermission()
          : await PermissionService.requestPhotosPermission();

      if (!hasPermission) {
        ToastHelper.error('الصلاحية مطلوبة');
        return null;
      }

      final XFile? video = await _picker.pickVideo(
        source: source,
        maxDuration: maxDuration,
      );

      if (video == null) return null;

      return File(video.path);
    } catch (e) {
      debugPrint('Error picking video: $e');
      ToastHelper.error('حدث خطأ أثناء اختيار الفيديو');
      return null;
    }
  }
}
