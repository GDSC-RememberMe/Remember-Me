package com.rememberme.gcs;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.storage.Blob;
import com.google.cloud.storage.Bucket;
import com.google.cloud.storage.Storage;
import com.google.cloud.storage.StorageOptions;
import net.bytebuddy.utility.RandomString;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.apache.commons.io.FileUtils;

import java.io.*;
import java.util.concurrent.ThreadLocalRandom;

@Component
public class DataBucketUtil {

    @Value("${gcp.config.file}")
    private String gcpConfigFile;

    @Value("${gcp.project.id}")
    private String gcpProjectId;

    @Value("${gcp.bucket.id}")
    private String gcpBucketId;

    @Value("${gcp.dir.name}")
    private String gcpDirectoryName;


    public GcsDto uploadFile(MultipartFile multipartFile, String fileName, String contentType) {

        try{
            byte[] fileData = FileUtils.readFileToByteArray(convertFile(multipartFile));

            InputStream inputStream = new ClassPathResource(gcpConfigFile).getInputStream();

            StorageOptions options = StorageOptions.newBuilder().setProjectId(gcpProjectId)
                    .setCredentials(GoogleCredentials.fromStream(inputStream)).build();

            Storage storage = options.getService();
            Bucket bucket = storage.get(gcpBucketId, Storage.BucketGetOption.fields());

            RandomString id = new RandomString(6, ThreadLocalRandom.current());
            Blob blob = bucket.create(gcpDirectoryName + "/" + fileName + "-" + id.nextString() + checkFileExtension(fileName), fileData, contentType);

            String publicFileUrl= "https://storage.cloud.google.com/" + gcpBucketId  + "/" + blob.getName(); //  공개된 파일 주소

            if(blob != null){

                return new GcsDto(blob.getName(), publicFileUrl);
            }

        }catch (Exception e){
            throw new RuntimeException("GCS에 업로드 중 에러가 발생하였습니다.");
        }
        throw new RuntimeException("GCS에 저장 중에 에러가 발생하였습니다.");
    }

    private File convertFile(MultipartFile file) {

        try{
            if(file.getOriginalFilename() == null){
                throw new RuntimeException("업로드 시 파일명을 지정해주어야 합니다.");
            }
            File convertedFile = new File(file.getOriginalFilename());
            FileOutputStream outputStream = new FileOutputStream(convertedFile);
            outputStream.write(file.getBytes());
            outputStream.close();

            return convertedFile;
        }catch (Exception e){
            throw new RuntimeException("파일 변환 중 에러가 발생하였습니다.");
        }
    }

    private String checkFileExtension(String fileName) {
        if(fileName != null && fileName.contains(".")){
            String[] extensionList = {".png", ".jpeg", ".pdf", ".doc", ".mp3"};

            for(String extension: extensionList) {
                if (fileName.endsWith(extension)) {
                    return extension;
                }
            }
        }
        throw new RuntimeException("업로드 가능한 파일 형식이 아닙니다.");
    }
}
