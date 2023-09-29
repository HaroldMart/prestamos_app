import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberpwd = false;
  bool sec = true;
  var visable = const Icon(
    Icons.visibility,
    color: Color(0xff4c5166),
  );
  var visableoff = const Icon(
    Icons.visibility_off,
    color: Color(0xff4c5166),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff65b0bb),
                      Color(0xff5a9ea8),
                      Color(0xff508c95),
                      Color(0xff467b82),
                      Color(0xff3c6970),
                      Color(0xff32585d),
                      Color(0xff28464a),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 100,),
                        // const ext(
                        //   "Hello User! ☺️",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 40,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        const SizedBox(height: 100,),
                        buildEmail(),
                        const SizedBox(height: 50,),
                        buildPassword(),
                        const SizedBox(height: 50,),
                        Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           buildRememberassword(),
                           buildForgetPassword()
                         ],
                       ),
                        const SizedBox(height: 30,),
                        buildLoginButton(),
                        const SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildFacebook(),
                            buildGoogle(),
                            buildTwitter()
                          ],
                        ),
                        const SizedBox(height: 60,),
                        const Text("الشروط والاحكام",style: TextStyle(color: Colors.white,fontSize: 10),)

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10,),
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(

            color: const Color(0xffebefff),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
            )]
          ),
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.email,color: Color(0xff4c5166),),
              hintText: 'Email',hintStyle: TextStyle(color: Colors.black38)
            ),

          ),
        ),
      ],
    );
  }
  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Password", style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),),
        const SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xffebefff),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 2)
              )
            ],
          ),
          height: 60,
          child: TextField(
            obscureText: sec,
            style: const TextStyle(
                color: Colors.black
            ),
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      sec = !sec;
                    });
                  },
                  icon: sec ? visableoff : visable,


                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14),
                prefixIcon: const Icon(Icons.vpn_key,
                  color: Color(0xff4c5166),
                ),
                hintText: "pwd",
                hintStyle: const TextStyle(
                    color: Colors.black38
                )
            ),
          ),
        )
      ],
    );
  }
  Widget buildRememberassword(){
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          Theme(data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Checkbox(
            value:  rememberpwd,
            checkColor: Colors.blueGrey,
            activeColor: Colors.white,
            onChanged: (value)
            {
              // setState(() {
              //   rememberpwd= value;
              // });
            },
          )),
          const Text("Remember me", style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white),),
        ],
      ),
    );
  }
  Widget buildForgetPassword(){
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(child: const Text("Forget Password !",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),onPressed: (){},),
    );
  }
  Widget buildLoginButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Container(
        width: double.infinity,
        child:  ElevatedButton(
          onPressed: (){},
          child: const Text("Login", style: TextStyle(fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
  Widget buildFacebook(){
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset("assets/facebook.png"),
    );
  }
  Widget buildGoogle(){
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset("assets/search.png"),
    );
  }
  Widget buildTwitter(){
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset("assets/twitter.png"),
    );
  }
}