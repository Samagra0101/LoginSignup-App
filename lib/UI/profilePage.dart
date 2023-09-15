import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          automaticallyImplyLeading: false,
          title: Text('Profile',style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                width: 120,height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                    child: Image(image: AssetImage('lib/assets/images/profileImg.jpeg'),)),
              ),

              SizedBox(height: 10),

              Text('Samagra',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),),
              Text('samagra@resoluteai.com',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15),),

              SizedBox(height: 20),

              SizedBox(width: 200,
                child: ElevatedButton(onPressed: (){},
                    child: Text('Edit Profile',style: TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)),),
              ),

              SizedBox(height: 30),
              Divider(),
              SizedBox(height: 10),

              ProfileMenuWidget(title: "Settings", icon: LineAwesomeIcons.cog, onPress: (){},),
              ProfileMenuWidget(title: "Connect", icon: LineAwesomeIcons.connect_develop, onPress: (){}),
              ProfileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check, onPress: (){}),
              Divider(color: Colors.grey,),
              SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPress: (){}),
              ProfileMenuWidget(title: "LogOut",endIcon: false, icon: LineAwesomeIcons.alternate_sign_out, onPress: (){}, textColor: Colors.red,),


            ],
          ),
        )
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    this.endIcon = true,
    required this.icon,
    required this.onPress,
    this.textColor,
    required this.title
  });
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 30, height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.purple.withOpacity(0.1),
        ),
        child: Icon(icon, color: Colors.purple,),
      ),
      title: Text(title,style: TextStyle(color: textColor),),
      trailing: endIcon ? Container(
        width: 30, height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1),
        ),
        child: Icon(LineAwesomeIcons.angle_right, color: Colors.grey,)) : null,

    );
  }
}
