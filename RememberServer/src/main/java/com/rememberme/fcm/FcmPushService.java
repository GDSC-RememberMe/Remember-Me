package com.rememberme.fcm;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.rememberme.memory.MemoryService;
import com.rememberme.memory.dto.MemoryRandomResponseDto;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.util.Arrays;
import java.util.concurrent.ExecutionException;

@Slf4j
@Service
@RequiredArgsConstructor
public class FcmPushService {

    @Value("${fcm.key.path}")
    private String FCM_PRIVATE_KEY;

    private String FIREBASE_SCOPE = "https://www.googleapis.com/auth/firebase.messaging";

    private FirebaseMessaging firebaseMessaging;

    private final MemoryService memoryService;
    private final String PUSH_QUESTION = " 추억이 기억나시나요?";
    private final String NOTIFICATION_IMG = "https://user-images.githubusercontent.com/77563814/226938199-87be0d00-4856-4d07-b873-44d57ecb0fe9.png";

    // 1. fcm 기본 설정 진행
    @PostConstruct // 의존성 주입 후, 실행
    public void fcmInit() throws IOException {
        GoogleCredentials googleCredentials = GoogleCredentials
                .fromStream(new ClassPathResource(FCM_PRIVATE_KEY).getInputStream())
                .createScoped((Arrays.asList(FIREBASE_SCOPE)));
        FirebaseOptions firebaseOptions = FirebaseOptions.builder()
                .setCredentials(googleCredentials)
                .build();

        if (FirebaseApp.getApps().isEmpty()) {
            log.info("Firebase 어플리케이션을 초기화 했습니다.");
        }
        FirebaseApp app = FirebaseApp.initializeApp(firebaseOptions);
        this.firebaseMessaging = FirebaseMessaging.getInstance(app);
    }

    // 2. 테스트 - 비동기
    public void pushAlarmTestAsync(Long familyId, String token) throws FirebaseMessagingException, ExecutionException, InterruptedException {
        log.info("알림 테스트 시작");

        MemoryRandomResponseDto memoryDto = memoryService.getRandomMemory(familyId);

        Notification notification = Notification.builder()
                .setTitle("Remember Me")
                .setBody(memoryDto.getTitle() + PUSH_QUESTION)
                .setImage(NOTIFICATION_IMG)
                .build();

        Message message = Message.builder()
                .setToken(token) // 사용자 디바이스 토큰
                .setNotification(notification)
                .putData("memoryId", memoryDto.getMemoryId().toString())
                .build();

        this.firebaseMessaging.sendAsync(message).get(); // 비동기
    }

    @Scheduled(cron = "0 0 09,18 * * ?")
    public void pushMorningAlarm(Long familyId, String token) throws ExecutionException, InterruptedException {
        log.info("FCM 푸시 알림");
        MemoryRandomResponseDto memoryDto = memoryService.getRandomMemory(familyId);
        Notification notification = Notification.builder()
                .setTitle("Remember Me")
                .setBody(memoryDto.getTitle() + PUSH_QUESTION)
                .setImage(NOTIFICATION_IMG)
                .build();

        Message message = Message.builder()
                .setToken(token) // 사용자 디바이스 토큰
                .setNotification(notification) // 기본 알림 템플릿
                .putData("memoryId", memoryDto.getMemoryId().toString()) // 이외의 정보
                .build();

        this.firebaseMessaging.sendAsync(message).get(); // 비동기
    }
}