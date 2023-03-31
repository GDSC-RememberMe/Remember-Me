# Remember-Me
Memory recall and quiz application for dementia prevention
  
## 1. Main Function
![page1](https://user-images.githubusercontent.com/83996346/229087035-143739c2-9c65-4aa0-a764-8865e1da0c8a.gif)
![image](https://user-images.githubusercontent.com/83996346/228998788-a7300c69-3ea7-4195-9718-477fd4fedfc1.png)
![image](https://user-images.githubusercontent.com/83996346/228998871-3d4a9420-93fd-4a30-a992-086c2ab22221.png)
![image](https://user-images.githubusercontent.com/83996346/228998950-edcee11a-45cd-46b1-9204-0f316a15927f.png)
![onboarding](https://user-images.githubusercontent.com/83996346/229087189-aa883f1f-1692-4b64-a231-91f7a9c05d7b.gif)
![page6](https://user-images.githubusercontent.com/83996346/229088611-1ea7c7dd-daac-409b-8c3b-c1b77a0c47c3.gif)
![page7](https://user-images.githubusercontent.com/83996346/229089533-384044bc-8c4c-4a45-8438-960964aab5de.gif)
![page8](https://user-images.githubusercontent.com/83996346/229088651-bb1cda05-c305-44dd-9c4f-49b30e13d9c6.gif)
![page9](https://user-images.githubusercontent.com/83996346/229088655-3adbc6d8-26e9-468f-b12e-1927fe56590a.gif)
![page10](https://user-images.githubusercontent.com/83996346/229088751-efdb64b2-999b-425f-a532-a14b7473c3f2.png)
![page11](https://user-images.githubusercontent.com/83996346/229088867-ba309993-98fe-4978-adc9-d7012b97e354.png)


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
