const express=require("express")
const userModel=require("../models/user")
const signupRouter=express.Router();


signupRouter.post("/jerrito_gemini/signup",async(req,res)=>{
    try{
    const {name,email,password}=req.body;
    
    const emailAlreadyExist=userModel.findOne({email})
    if(emailAlreadyExist){
        return res.status(400).json({msg:"Email already exist"});
    }
    const passwordHashed=await bcrypt.hash(password,8);

    let user=  userModel({
      userName:name,
        email,
    password
    })

    const data= await user.save();
    res.status(200).json({msg:"Saved successfully"})

   

    }
    catch(e){

        res.status(500).json({error:e.message});
    }

  

})

module.export=signupRouter;