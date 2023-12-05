const { default: mongoose } = require("mongoose");

// Emad and Kane develop the table for storing student image and detail
/*  we need properties={
        heading: "Trimester 2", 
        list:[{
        image:{data:Buffer,contentType: String},
        firstName:"",
        lastname:"",
        description:""      
        }]
        
// } */
let studentDetailSchema = new mongoose.Schema({
  heading: { type: String },
  student: [
    {
      firstName: { type: String, required: true },
      lastName: { type: String },
      description: { type: String },
      img: { data: Buffer, contentType: String },
    },
  ],
});

module.exports = mongoose.model("studentDetail", studentDetailSchema);
