import 'package:gemini/features/authentication/presentation/pages/landing_page.dart';
import 'package:gemini/features/authentication/presentation/pages/signin_page.dart';
import 'package:gemini/features/authentication/presentation/pages/signup_page.dart';
import 'package:gemini/features/connection_page.dart';
import 'package:gemini/features/search_text/presentation/pages/search_page.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(
  
  initialLocation: "/searchPage",
  routes: [
 
 GoRoute(path: "/searchPage",
  name: "searchPage",
  builder: (context, state) =>const SearchTextPage(),),
  GoRoute(path: "/",
  name:"connection",
  builder: (context, state) => const ConnectionPage(),),
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
