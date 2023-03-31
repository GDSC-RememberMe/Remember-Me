# Remember-Me

<p align="center"><img src="https://user-images.githubusercontent.com/83996346/229106792-4f8ef8ce-8eeb-431c-a26c-cd52c7953173.png" width="300" height="300"></p>

**<p align="center">🧓Memory recall and quiz application for dementia prevention👨‍🦳</p>**
  
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

![image](https://user-images.githubusercontent.com/77563814/229105532-780a0633-399e-4641-afb8-a9c6ff0e00bf.png)


## 3. How to RUN
### 💻 Server RUN

1. **MySQL Local DB SETTING**

    > MySQL must be installed first : https://dev.mysql.com/downloads/installer

    > INPUT MySQL LOCAL USERNAME & PASSWORD
    
    - `application.yml`
        ```makefile
        spring:
          server:
            address: localhost
            port: 8080
          datasource:
            driver-class-name: com.mysql.cj.jdbc.Driver
            url: jdbc:mysql://localhost:3306/rmdb?createDatabaseIfNotExist=true&serverTimezone=Asia/Seoul
            username: {INPUT MySQL LOCAL USERNAME}
            password: {INPUT MySQL LOCAL PASSWORD} // !HERE!
        ```
        
2. **Spring server RUN**
    > java 11 must be installed first : https://www.oracle.com/kr/java/technologies/downloads/#java11
    ```makefile
    git clone https://github.com/GDSC-RememberMe/Remember-Me.git
    cd RememberServer
    gradlew bootRun
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
4. ❗ Before you run each code, you have to install `Mecab` at your local. See [Here!](https://konlpy.org/ko/v0.4.0/install/)
5. if you run `doc_cluster.py`, you can see the model’s clustering and extracting keyword like below!

![Untitled (1)](https://user-images.githubusercontent.com/83996346/229000387-d5ca2150-2451-4d6a-9e15-3c3a662603e6.png)

Til now, the RememberAI is only fitted in Korean. Soon, we will update the model to gather English Events even without Event Description!

### 📱 Client RUN
1. Flutter SDK SETTING
  - Check [Flutter Installation](https://docs.flutter.dev/get-started/install).
2. INSTALLATION
```bash
git clone https://github.com/GDSC-RememberMe/Remember-Me.git
cd RememberClient
```
3. Before Application Run
- If You want to run the client with Server, You should change ip address!
- [Windows](https://support.microsoft.com/en-us/windows/find-your-ip-address-in-windows-f21a9bbc-c582-55cd-35e0-73431160a1b9#Category=Windows_10)
- Mac
```bash 
ifconfig | grep inet
```
  - use this command and you can find your ip like this!
  - copy the highlighted line(not this photo)
  ![ip](https://user-images.githubusercontent.com/63589031/229101145-e283cfde-4163-46ba-8d12-969aa0bae3e0.png)
- Change the `RememberMeClient/lib/common/const/data.dart` line 4 like this.
- Don't forget the `${enterYourIP}` should be changed to your IP!
```
const APP_BASE_URL = "http://${enterYourIP}:8080";
```

4. Running Application
- You should open emulator from android studio and then run project!
- Please be careful that you are in the RememberMeClient folder!
```bash
flutter run
```
5. When you see the LOGIN PAGE
- You can login the account when the this project's server is running on your computer!
  - Patient User ID&PASSWORD
    - ID:
    - PASSWORD:
  - Caregiver User ID&PASSWORD
    - ID:
    - PASSWORD:
<br>
