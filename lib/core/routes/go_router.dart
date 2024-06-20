import 'package:gemini/features/authentication/presentation/pages/landing_page.dart';
import 'package:gemini/features/authentication/presentation/pages/no_internet_page.dart';
import 'package:gemini/features/authentication/presentation/pages/signin_page.dart';
import 'package:gemini/features/authentication/presentation/pages/signup_page.dart';
import 'package:gemini/features/connection_page.dart';
import 'package:gemini/features/search_text/presentation/pages/search_page.dart';
import 'package:gemini/features/search_text/presentation/pages/user_profile.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  
  initialLocation: "/",
  routes: [
 
 GoRoute(path: "/searchPage",
  name: "searchPage",
  builder: (context, state) =>const SearchTextPage(),
  routes: [
  GoRoute(path:"user",
  name:"user",
  builder: (context, state) => const  UserProfile(

  ))
  ]
  ),
  GoRoute(path: "/",
  name:"connection",
  builder: (context, state) => const ConnectionPage(),),
  GoRoute(
    path:"/no_internet",
    name:"noInternet",
    builder: (context, state) => const NoInternetPage() ,
  ),
  GoRoute(path: "/landing",
  name:"landing",
  builder: (context, state) => const LandingPage(),
  routes: [
    GoRoute(path: "signup",
    name:"signup",
    builder: (context, state) => const SignupPage(),),
     GoRoute(path: "signin",
    name:"signin",
    builder: (context, state) => const SigninPage(),),

  ]),
  

]);
