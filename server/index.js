const express= require("express");
const mongoose=require("mongoose");

const app=express();
const port=5000;
mongoose.connect().then(()=>{

}).catch((e)=>{

})
app.get("/",(req,res)=>{

    return res.status(200).send("Page");
});


app.get("/about",(req,res)=>{
   return res.json({"Done":"Finish"});
})

app.post("all",(req,res)=>{
    req.body={}
})


app.listen(port,"127.0.0.1",()=>{
    console.log(`Started at port ${port}`);
})

