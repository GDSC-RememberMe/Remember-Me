# Remember-Me
Memory recall and quiz application for dementia prevention
  
## 1. Main Function
![시작1_AdobeExpress (1)](https://user-images.githubusercontent.com/83996346/228998533-267c0ea6-84dd-4f10-8e77-6317e7203455.gif)
![image](https://user-images.githubusercontent.com/83996346/228998788-a7300c69-3ea7-4195-9718-477fd4fedfc1.png)
![image](https://user-images.githubusercontent.com/83996346/228998871-3d4a9420-93fd-4a30-a992-086c2ab22221.png)
![image](https://user-images.githubusercontent.com/83996346/228998950-edcee11a-45cd-46b1-9204-0f316a15927f.png)
![page4](https://user-images.githubusercontent.com/83996346/228999248-9ac7d442-77df-42ab-8c4e-cbb4af7bdb82.gif)

여기 gif가 화면이 갑자기 확 작아져서... 큰 화면으로 gif를 넣어야 할 거 같긴 합니다..! (저녁때 논의)

## 2. Service Architecture

## 3. How to RUN
### ✅ Server RUN
1. FCM Private key IMPORT
  - ### 링크 ###
2. MySQL DB SETTING
3. Spring server RUN or BUILD
```Markfile
gradle bootRun // RUN

gradlew build // BUILD
java -jar {생성 파일명}
```

<br>

### 🤖 RememberAI RUN

```markdown
+---RememberAI
    ---doc_cluster.py
    ---main.py
    ---requirements.txt
```

1. `git clone 레포주소`
2. `cd RememberAI`
3. `pip install -r requirements.txt`
4. ❗ Before you run each code, you have to install `Mecab` at your local. See Here!(하면서 주소)
5. if you run `doc_cluster.py`, you can see the model’s clustering and extracting keyword like below!

![Untitled (1)](https://user-images.githubusercontent.com/83996346/229000387-d5ca2150-2451-4d6a-9e15-3c3a662603e6.png)

Til now, the RememberAI is only fitted in Korean. Soon, we will update the model to gather English Events even without Event Description!
