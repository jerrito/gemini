const express= require("express");
const {people,products}=require("./data/data");
const mongoose=require("mongoose");

const app=express();

const auth=require("./middlewares/auth")

const databaseUrl="mongodb+srv://jerrito0240:kI02PBzyF2U1WL9A@cluster0.gldghvy.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";



const port=5000;
mongoose.connect(databaseUrl).then(()=>{
console.log("Database connected successfully");
}).catch((e)=>{
  console.log("Error connecting to database");
});

app.use(express.json());
app.use(auth)





app.get("/",(req,res)=>{

    return res.status(200).send("Page");
});


app.get("/about",(req,res)=>{
   return res.json({"Done":"Finish"});
})

app.get("/all",(req,res)=>{
   const data=people.map((e)=>e.name);

   res.send(data);
})

app.get("/people/:nameReq",(req,res)=>{
    const {nameReq}=req.params;
    console.log(nameReq);
    console.log(req.params);
    console.log(req.body);

    const person=people.find((e)=>
    {return  e.name==nameReq});
   if(!person){
    return res.status(404).send("Unknown");
   }
  return  res.status(200).send(person.name);
    
})

app.get("*",(req,res)=>
{
  res.status(404).send("Page not found");  
});


app.listen(port,"127.0.0.1",()=>{
    console.log(`Started at port ${port}`);
})

