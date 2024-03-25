const express=require("express")
const userModel=require("../models/user")
const loginRouter=express.Router();

loginRouter.post("jerrito_gemini/login",async(req,res)=>{

    const {name,email,password}=req.body;

    const loginUser=await userModel.findOne({
        email, name
    })

  if(!loginUser){
    return res.status(404).json({msg:"No user found"})
  }

  const passwordCheck=bcrypt.compare(password,user.password);
  if(!passwordCheck){
    return res
    .status(400)
    .json({msg:"Password is incorrect"});
  }

const token=  jwt.sign({id:user._id},"tokenPassword")
  res.json({ token, ...user._doc});

  
})

// loginRouter.get("/",auth,async(req,res)=>{
//     //console.log(req.user);
  
//     const user=await userModel.findById(req.user);
//    // console.log(user)
//     res.json({...user._doc,token:req.token});
//   })
  
  module.exports=loginRouter;