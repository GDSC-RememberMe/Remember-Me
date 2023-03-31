package com.rememberme.gcs.GcsService;

import org.springframework.web.multipart.MultipartFile;

public interface GcsService {

    String uploadFiles(MultipartFile files);
}