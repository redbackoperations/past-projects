const { default: mongoose } = require("mongoose");


// Hemantsingh and Luv to work of conclusion api

// contentBullentPoints: [String],
// description:String
let conclusionSchema = new mongoose.Schema({
    dotpoints: { type: String, required: true },
    information: String,


});


module.exports = mongoose.model("Conclusion", conclusionSchema);
