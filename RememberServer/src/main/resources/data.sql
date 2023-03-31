--CREATE SCHEMA IF NOT EXISTS `rmdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin ;

USE rmdb ;
ALTER DATABASE rmdb DEFAULT CHARACTER SET UTF8;

-- nostalgia_item
INSERT INTO nostalgia_item (title, img_url) VALUES ('도시락', 'https://user-images.githubusercontent.com/77563814/224518194-b45c1103-1de2-4e7d-9267-66ae4637c53a.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('못난이', 'https://user-images.githubusercontent.com/77563814/224518214-fd6cc6b1-b434-4401-aa24-be2b320bcb95.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('뽀빠이', 'https://user-images.githubusercontent.com/77563814/224518227-b0e1763f-4759-424b-86a7-eec9b6ec8b9d.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('하니만화', 'https://user-images.githubusercontent.com/77563814/224518255-7c3507a3-61b0-44a6-bea1-fba0ef1205b2.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('크레파스', 'https://user-images.githubusercontent.com/77563814/224518247-42e48290-c9e6-4746-9b4f-c9d650fc2682.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('사이다', 'https://user-images.githubusercontent.com/77563814/224518223-b9b2d0e1-8724-4394-b865-c4063a616d90.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('축음기', 'https://user-images.githubusercontent.com/77563814/224518244-556547ad-33d0-49cd-a326-414007ddfa5d.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('전화기', 'https://user-images.githubusercontent.com/77563814/224518236-d7b91ef0-6a23-4197-9922-2495c6e399e1.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('보석함', 'https://user-images.githubusercontent.com/77563814/224518233-1754aa30-3751-4b85-a54a-6141b24e44c9.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('빨래', 'https://user-images.githubusercontent.com/77563814/224518230-ad2ef68f-c6a9-44ad-bb27-5189d9338568.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('카세트', 'https://user-images.githubusercontent.com/77563814/224518246-69a88783-af07-4006-9b85-6a9cbcd25f16.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('공중전화', 'https://user-images.githubusercontent.com/77563814/224518191-e1692288-6a76-439e-a835-fb6d44ee32e4.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('사탕', 'https://user-images.githubusercontent.com/77563814/224518221-2d82e9b9-7ec0-4b2f-a513-c357a9321e03.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('옥수수빵', 'https://user-images.githubusercontent.com/77563814/224518219-0abc87f3-7467-438a-aaf9-ae1a8530279c.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('메주', 'https://user-images.githubusercontent.com/77563814/224518218-484d4dae-3a09-45a0-92af-7ac14373d945.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('게임기', 'https://user-images.githubusercontent.com/77563814/224518175-838008e0-b96d-4d84-a65a-8f67c2bab413.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('티비', 'https://user-images.githubusercontent.com/77563814/224518254-88cd4f06-fd0d-48f1-b7ae-ffb569b6cec9.png');
INSERT INTO nostalgia_item (title, img_url) VALUES ('타자기', 'https://user-images.githubusercontent.com/77563814/224518251-585c4708-6e9f-4b71-826a-a00c54bde45e.png');

-- 샘플 : Member1이 환자, Member2이 보호자 (Member1이과 2는 같은 가족)
-- Member
-- 비번은 다 'aaabbb'
INSERT INTO member (member_id, username, password, phone, nickname, role, birth, gender, profile_img, address)
VALUES (1, 'username1', '$2a$10$bZCMzd3n6oKh2ST5CQ6l3.hxIZmhdiFViedT.jdHmJrtVJnsZ.oiu', '01099991111', 'fullname', 'PATIENT', '1950-10-01', 'MALE', '이미지 주소', '주소');
INSERT INTO member (member_id, username, password, phone, nickname, role, birth, gender, profile_img, address)
VALUES (2, 'username2', '$2a$10$bZCMzd3n6oKh2ST5CQ6l3.hxIZmhdiFViedT.jdHmJrtVJnsZ.oiu', '01099991112', 'fullname', 'CAREGIVER', '1950-10-01', 'MALE', '이미지 주소', '주소');
INSERT INTO member (member_id, username, password, phone, nickname, role, birth, gender, profile_img, address)
VALUES (3, 'username3', '$2a$10$bZCMzd3n6oKh2ST5CQ6l3.hxIZmhdiFViedT.jdHmJrtVJnsZ.oiu', '01099991113', 'fullname', 'PATIENT', '1950-10-01', 'MALE', '이미지 주소', '주소');
INSERT INTO member (member_id, username, password, phone, nickname, role, birth, gender, profile_img, address)
VALUES (4, 'username4', '$2a$10$bZCMzd3n6oKh2ST5CQ6l3.hxIZmhdiFViedT.jdHmJrtVJnsZ.oiu', '01099991114', 'fullname', 'PATIENT', '1950-10-01', 'MALE', '이미지 주소', '주소');
INSERT INTO member (member_id, username, password, phone, nickname, role, birth, gender, profile_img, address)
VALUES (5, 'username5', '$2a$10$bZCMzd3n6oKh2ST5CQ6l3.hxIZmhdiFViedT.jdHmJrtVJnsZ.oiu', '01099991115', 'fullname', 'PATIENT', '1950-10-01', 'MALE', '이미지 주소', '주소');

-- Family
INSERT INTO family (family_id, patient_id) VALUES (1, 1);

-- family 관계
UPDATE member SET family_id = 1 WHERE member_id = 1;
UPDATE member SET family_id = 1 WHERE member_id = 2;

-- Memory
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (1, 1, "놀이 공원", "여행", "가족끼리 놀이 공원가서 재밌게 놀았었어요.", "https://images.unsplash.com/photo-1563564120768-da63ef4f7446?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1168&q=80");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (2, 1, "부산 가족 여행", "여행","가족끼리 부산 가서 재밌었던 기억이 있어요.", "https://images.unsplash.com/photo-1633335718204-670c3d4efe2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (3, 1, "가족 제주 여행", "여행","16년도 여름 제주 여행을 가족 모두 함께 갔었어요.", "https://images.unsplash.com/photo-1579169326371-ccb4e63f7889?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (4, 1, "어버이날", "여행","18년도 어버이날 아주 큰 꽃을 해드렸어요. 다들 좋아하셨던게 기억이 나네요.", "https://images.unsplash.com/photo-1679502460197-549139d981e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (5, 1, "보라 유채꽃밭", "여행", "가족끼리 보라색 유채꽃밭에 갔었어요. 막내가 사진찍고 놀던 기억이 나네요.", "https://images.unsplash.com/photo-1679505528631-9f1ac50c9d72?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80");

INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (6, 1, "한강 나들이", "여행", "강아지 순이랑 다같이 한강 나들이 갔었어요. 날씨도 좋고 다들 재밌게 놀았네요.", "https://images.unsplash.com/photo-1679521184597-7481325cb060?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDF8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (7, 1, "크리스마스", "여행", "집에서 크리스마스 파티 했던 기억이 나네요.", "https://images.unsplash.com/photo-1670509684960-101c061c9c5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDd8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (8, 1, "벚꽃 축제", "여행", "지난 봄 벚꽃 축제에 갔었어요.", "https://images.unsplash.com/photo-1522383225653-ed111181a951?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1176&q=80");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (9, 1, "붕어빵", "여행", "막내가 좋아하는 붕어빵을 아버지가 사오셨어요.", "https://images.unsplash.com/photo-1614251948216-a9741023c2d5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (10, 1, "궁 나들이", "여행", "가족끼리 궁 나들이를 갔었어요.", "https://images.unsplash.com/photo-1572608957299-4657d90691ca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (11, 1, "북촌 한옥 마을", "여행", "가족끼리 북촌 한옥 마을에 갔었어요.", "https://images.unsplash.com/photo-1512059555341-6a121e7d4d86?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80");

INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (12, 1, "제라늄 선물", "일상", "어머니가 좋아하시는 제라늄을 선물로 드렸어요.", "https://images.unsplash.com/photo-1579169558076-260989da7cc8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (13, 1, "한라산 등반", "여행", "18년도 가족끼리 제주 여행갔을 때 한라산을 등반했었어요.", "https://images.unsplash.com/photo-1565990181375-f86518c9aa8d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (14, 1, "재래 시장", "일상", "가족끼리 함께 재래시장에 갔었어요. 그때 막내가 좋아하는 어묵을 많이 먹었던 기억이 있네요.", "https://images.unsplash.com/photo-1545984929-f28d9e323a00?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=503&q=80");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (15, 1, "삼청동 집", "일상", "이사 오기전 예전에 가족이 살던 삼청동 집이예요.", "https://images.unsplash.com/photo-1485186018847-dbe7e901d86b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80");

INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (16, 1, "바베큐 파티", "일상", "지난 여름 집에서 직접 바베큐를 해먹었어요.", "https://images.unsplash.com/photo-1508615263227-c5d58c1e5821?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (17, 1, "달고나 커피", "일상", "집에서 직접 달고나를 만들어 먹었어요.", "https://images.unsplash.com/photo-1629350120356-57bf899d2496?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80");
INSERT INTO Memory (memory_id, family_id, title, category, content, img_url)
VALUES (18, 1, "남산 타워", "일상", "남산 타워에 같이 걸어간 적이 있었어요.", "https://images.unsplash.com/photo-1538669715315-155098f0fb1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1025&q=80");

