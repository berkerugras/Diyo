Hi, we are Group Ugras and this is a detailed instruction of Diyo App.

0.1 WHAT IS DIYO?
First of all Diyo is a Social Media app that you can ask anything to anyone
and anytime anonymously.In addition to this, you can send a message to your friends by using
their 'ChattingID's.

0.2 How DIYO is implemented?
For the frontend part of the DIYO we have used Flutter and for the backend part we have used Firebase and Flutter again.
While implementing of the database connection and authentication we have used Firebase Authentication
Firebase Core and Cloud Firestore plugins. You can investigate the versions of these plugins at the end of
the ReadMe file.


1 How to use DIYO?

1.1 How to download DIYO?
First of all, a user should set up flutter and an android emulator on his/her personal computer.Then the user has to download 
the application folder containing lib, assets, android ,and .ios ,etc., folders. After, by using an IDE
(you can select one of these IDE's IntellijIdea WebStorm, Android Studio, Visual Studio) user should open 
this application folder. Finally the user should type 'flutter pub get' command in the integrated terminal of the IDE.
and then user can start app by running the 'main.dart' file. Users can find related documents about setting up Flutter
on 'Links' topic of this file.   

1.2 How to create a post and write into these posts?
After a correct installation, to use the application, the user should create an account by tapping the 'register' and then 
ther user can log in with the password and email address, provided during registration. Now user is ready to use DIYO.
One of the most important features of the DIYO is creating a topic and asking about anything publicly. Users can create a topic and ask
something by clicking the 'Add' button at the end of the main page. He/She can set group names and add descriptions after clicking this
button. Do not forget you must give input to the 'Group Name' section, it can be related to your questions. Then you are ready to wait
for advices and answers from the people. While waiting you can also enter someone's topic and share your own ideas anonymously with other people.
To refresh the page and see new topics you have to click the 'refresh' icon at the top of the application.


1.3 How to send message to my friend?
In DIYO we have a token which name is 'ChattingID'. You can access this token by tapping  the 'profile' icon which is at the top of the 
application. You can easily copy this token by tapping on it. Then the user going to see its own unique 'ChattingID'. By sharing this token, users 
can send and recieve messages from his/her friends.To send a message, user should tap to the conversation icon at the top of the page.Then by clicking 
the 'Chat with Your Friend' button on the messages page, user will able to create a 'Conversation Topic'. On this page the user must enter the 'ChattingID' 
to start a conversation. Finally, the sender can enter to the message topic and send a message to his/her friend. 


1.4 How to change my username and password?
You can change your username and password in the Profile Page. 





Versions:
firebase_core: ^0.7.0
firebase_auth: ^0.20.1
cloud_firestore: ^0.16.0+1
provider: ^5.0.0
cupertino_icons: ^1.0.2


Links:
LINK TO OUR PROJECT VIDEO: https://www.youtube.com/watch?v=xtTtkFfSOGY
Flutter installation and setup for IntellijIdea and Android Studio: https://flutter.dev/docs/development/tools/android-studio
Flutter installation and setup for VSCODE: https://flutter.dev/docs/development/tools/vs-code

Credits:
https://flutter.dev/docs
https://www.youtube.com/watch?v=NOrUazt9vNI&t=3s
https://www.youtube.com/watch?v=d5PpeNb-dOY
https://www.youtube.com/watch?v=rDFJhIobj7I
https://www.youtube.com/watch?v=wme9FQgcF58
https://www.youtube.com/watch?v=gSl-MoykYYk
https://www.youtube.com/watch?v=AS183vv0xxU
https://www.youtube.com/watch?v=fy-rCZVcw78&t=2s
https://firebase.flutter.dev/docs/overview/
https://firebase.flutter.dev/docs/firestore/usage/
https://stackoverflow.com/
https://www.youtube.com/watch?v=LAf6gvrNt_s
