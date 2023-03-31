package com.rememberme.gcs.GcsService;

import com.rememberme.gcs.DataBucketUtil;
import com.rememberme.gcs.GcsDto;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;

@Service
@Transactional
@RequiredArgsConstructor
public class GcsServiceImpl implements GcsService {

    private static final Logger LOGGER = LoggerFactory.getLogger(GcsServiceImpl.class);

    private final DataBucketUtil dataBucketUtil;

    public String uploadFiles(MultipartFile file) {

        String originalFileName = file.getOriginalFilename();
        if (originalFileName == null) {
            throw new RuntimeException("업로드 시, 파일 이름을 설정해주어야 합니다.");
        }

        Path path = new File(originalFileName).toPath();
        String fileUrl = null;
        try {
            String contentType = Files.probeContentType(path);
            GcsDto gcsDto = dataBucketUtil.uploadFile(file, originalFileName, contentType);

            if (gcsDto != null) {
                fileUrl = gcsDto.getFileUrl();
            }
        } catch (Exception e) {
            throw new RuntimeException("파일 업로드 중 에러가 발생했습니다.");
        }
        return fileUrl;
    }
}