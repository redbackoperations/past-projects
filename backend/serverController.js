const express = require("express");
const bodyParser = require("body-parser");
const https = require("https");
const mongoose = require("mongoose");
const User = require("./Model/User");
const Book = require("./Model/bookSchema");
const Conclusion = require("./Model/conclusionSchema");
const StudentDetail = require("./Model/StudentDetailSchema");
const validator = require("validator");
const bcrypt = require("bcrypt");
const fs = require("fs");
const { match } = require("assert");
const jwt = require("jsonwebtoken");
const { encode } = require("punycode");
const StudentDetailSchema = require("./Model/StudentDetailSchema");
require("dotenv").config();

const port = process.env.TOKEN_SERVER_PORT;
multer = require("multer");
require("dotenv").config();
const saltRounds = 10;

//send user value to MongoDB
async function PostNewUser(req, res) {
  try {
    const salt = bcrypt.genSaltSync(saltRounds);
    const hash = bcrypt.hashSync(req.body.password, salt);

    var img = fs.readFileSync("./uploads/default.jpg");
    var encode_img = img.toString("base64");
    var final_img = {
      contentType: "image/jpeg",
      data: new Buffer(encode_img, "base64"),
    };

    const user = new User({
      username: req.body.username,
      firstname: req.body.firstname,
      lastname: req.body.lastname,
      email: req.body.email,
      password: hash,
      redbackCoins: req.body.redbackCoins,
      telephone: req.body.telephone,
      userLevel: req.body.userLevel,
      img: final_img,
    });
    var followers = {
      username: req.body.followUser,
    };
    user.followers.push(followers);
    var following = {
      username: req.body.following,
    };
    user.following.push(following);
    user.save().catch((err) => res.send(err));

    if (res.statusCode === 200) {
      res.send("Success send!");
    } else {
      res.send("Something wrong?");
    }
  } catch (err) {
    console.error(`Error while posting new user:`, err.message);
  }
}

//login with username and password (generates access token)
function PostLogin(req, res) {
  if (req.body.password) {
    try {
      User.findOne({ username: req.body.username }, async (err, list) => {
        if (list == null) res.status(404).send("User does not exist");
        const match = bcrypt.compare(req.body.password, list.password);
        if (await bcrypt.compare(req.body.password, list.password)) {
          const accessToken = generateAccessToken({ user: req.body.name });
          const refreshToken = generateRefreshToken({ user: req.body.name });
          res.json({ accessToken: accessToken, refreshToken: refreshToken });
        } else {
          res.status(401).send("Password Incorrect");
        }
      });
    } catch (err) {
      console.error(`Error while sending login request:`, err.message);
    }
  } else {
    throw new Error("request cannot be empty");
  }
}

//find all user
async function FindAllUser(req, res) {
  try {
    User.find((err, list) => {
      if (err) {
        res.send(err);
      } else {
        res.send(list);
      }
    });
  } catch (err) {
    console.error(`Error while getting all users:`, err.message);
  }
}

//find a user with username: return password
async function FindUsername(req, res) {
  try {
    User.findOne(
      { username: req.params.username },
      ["password"],
      (err, list) => {
        if (list) res.send(list.password);
        else res.send("Cannot find username");
      }
    );
  } catch (err) {
    console.error(`Error while getting user by username:`, err.message);
  }
}

//find specific user with user ID or username
async function FindUser(req, res) {
  try {
    User.findOne({ _id: req.params.id }, (err, list) => {
      if (list) res.send(list);
      else {
        User.findOne({ username: req.params.id }, (err, list) => {
          if (list) {
            res.send(list);
          } else res.send("Cannot find a user with given id or username");
        });
      }
    });
  } catch (err) {
    console.error(`Error while getting user by ID:`, err.message);
  }
}

//delete with user ID or username
async function DeleteUserID(req, res) {
  try {
    User.deleteOne({ _id: req.params.id }, function (err, list) {
      if (err) {
        User.deleteOne({ username: req.params.id }, function (err, list) {
          if (err) {
            res.send("Cannot find user id or username");
          } else {
            res.send(list);
          }
        });
      } else {
        res.send(list);
      }
    });
  } catch (err) {
    console.error(`Error while deleting user by ID:`, err.message);
  }
}

//change with user ID or username
async function UpdateUser(req, res) {
  try {
    const salt = bcrypt.genSaltSync(saltRounds);
    const hash = bcrypt.hashSync(req.body.password, salt);
    User.update(
      { _id: req.params.id },
      {
        $set: {
          username: req.body.username,
          password: hash,
          telephone: req.body.telephone,
          email: req.body.email,
        },
      },
      (err) => {
        if (!err) {
          res.send("Successfully update a user with user id");
        } else {
          User.update(
            { username: req.params.id },
            {
              $set: {
                username: req.body.username,
                password: hash,
                telephone: req.body.telephone,
                email: req.body.email,
              },
            },
            (err) => {
              if (!err) {
                res.send("Successfully update a user with username");
              } else {
                res.send("User does not exist");
              }
            }
          );
        }
      }
    );
  } catch (err) {
    console.error(`Error while updating user:`, err.message);
  }
}

//Upload picture for certain user with user ID or username
async function UploadUserPicture(req, res) {
  try {
    var img = fs.readFileSync(req.file.path);
    fs.unlinkSync(req.file.path);
    var encode_img = img.toString("base64");
    var final_img = {
      contentType: req.file.mimetype,
      data: new Buffer(encode_img, "base64"),
    };
    console.log(final_img);
    User.update({ _id: req.params.id }, { $set: { img: final_img } }, (err) => {
      if (!err) {
        res.send("Successfully upload a picture for a user with user id");
      } else {
        User.update(
          { username: req.params.id },
          { $set: { img: final_img } },
          (err) => {
            if (!err) {
              res.send(
                "Successfully upload a picture for a user with username"
              );
            } else {
              res.send("User does not exist");
            }
          }
        );
      }
    });
  } catch (err) {
    console.error(`Error while updating user picture:`, err.message);
  }
}

// Get profile picture with user ID or username
async function GetUserPicture(req, res) {
  try {
    User.findById(req.params.id, (err, user) => {
      if (!err) {
        res.contentType(user.img.contentType);
        res.send(user.img.data);
      } else {
        User.findOne({ username: req.params.id }, (err, user) => {
          if (user) {
            res.contentType(user.img.contentType);
            res.send(user.img.data);
          } else {
            res.send(err);
          }
        });
      }
    });
  } catch (err) {
    console.error(`Error while getting user picture:`, err.message);
  }
}
function generateAccessToken(user) {
  return jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, { expiresIn: "15m" });
}
// refreshTokens
let refreshTokens = [];
function generateRefreshToken(user) {
  const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET, {
    expiresIn: "20m",
  });
  refreshTokens.push(refreshToken);
  return refreshToken;
}

function RefreshToken(req, res) {
  if (!refreshTokens.includes(req.body.token))
    res.status(400).send("Refresh Token Invalid");
  refreshTokens = refreshTokens.filter((c) => c != req.body.token);
  //remove the old refreshToken from the refreshTokens list
  const accessToken = generateAccessToken({ user: req.body.username });
  const refreshToken = generateRefreshToken({ user: req.body.username });
  //generate new accessToken and refreshTokens
  res.json({ accessToken: accessToken, refreshToken: refreshToken });
}

function Logout(req, res) {
  refreshTokens = refreshTokens.filter((c) => c != req.body.token);

  res.status(204).send("Logged out");
}
// conclusion function
async function FindAllConclusion(req, res) {
  try {
    Conclusion.find((err, list) => {
      if (err) {
        res.send(err);
      } else {
        res.send(list);
      }
    });
  } catch (err) {
    console.error(`Error while getting all Conculsions:`, err.message);
  }
}


async function PostNewConclusion(req, res) {
  const conclusion = new Conclusion({
    dotpoints: req.body.dotpoints,
    information: req.body.information,
  });
  conclusion.save().catch((err) => res.send(err));
}




//books functions

async function FindAllBook(req, res) {
  try {
    Book.find((err, list) => {
      if (err) {
        res.send(err);
      } else {
        res.send(list);
      }
    });
  } catch (err) {
    console.error(`Error while getting all books:`, err.message);
  }
}

//kane's work
async function FindBookById(req, res) {
  try {
    Book.findById({ _id: req.params.id }, (err, list) => {
      if (err) {
        res.send(err);
      } else {
        res.send(list);
      }
    });
  } catch (err) {
    console.error(`Error while getting Book:`, err.message);
  }
}
//test

// Emad's worker
async function GetTotalCountOfTheBook(req, res) {
  try {
    res.send((await Book.count("id")).toString());
  } catch (err) {
    console.error(`Error while counting books:`, err.message);
  }
}

// Hemantsingh work
async function FindBookByTitle(req, res) {
  try {
    Book.find((err, list) => {
      if (err) {
        res.send(err);
      } else {
        x = list.filter((name) =>
          name.title.toLowerCase().includes(req.params.title.toLowerCase())
        );
        res.send(x);
      }
    });
  } catch (err) {
    console.error(`Error while getting all books:`, err.message);
  }
}

async function UpdateConclusionDetail(req, res) {
  Conclusion.updateOne(
    { _id: req.params.id },
    {
      $set: {
        _id: req.params.id,
        dotpoints: req.body.dotpoints,
        information: req.body.information,
      },
    }
  ).catch((err) => res.send(err));
}

async function DeleteConclusion(req, res) {
  try {
    Conclusion.deleteOne({ _id: req.params.id }, function (err, list) {
      res.send("sucess");
    });
  } catch (err) {
    console.error(`Error while deleting user by ID:`, err.message);
  }
}

//Luv's worker
//only get the content tiltle and ID , not the actual content
async function GetContentTitle(req, res) {
  try {
    Book.find((err, list) => {
      if (err) {
        res.send(err);
      } else {
        let listObject = [];
        list.forEach((element) => {
          listObject.push({ id: element.id, title: element.title });
        });
        res.send(listObject);
      }
    });
  } catch (err) {
    console.error(`Error while getting all books:`, err.message);
  }
}

async function PostNewBok(req, res) {
  const book = new Book({
    title: req.body.title,
    content: req.body.content,
  });
  book.save().catch((err) => res.send(err));
}

async function DeleteBook(req, res) {
  try {
    Book.deleteOne({ _id: req.params.id }, function (err, list) {
      res.send("sucess");
    });
  } catch (err) {
    console.error(`Error while deleting user by ID:`, err.message);
  }
}

async function UpdateBookDetail(req, res) {
  Book.updateOne(
    { _id: req.params.id },
    {
      $set: {
        _id: req.params.id,
        title: req.body.title,
        content: req.body.content,
      },
    }
  ).catch((err) => res.send(err));
}

async function PostNewStudentDetail(req, res) {
  var img = fs.readFileSync(req.files[0].path);
  fs.unlinkSync(req.files[0].path);
  var encode_img = img.toString("base64");
  var final_img = {
    contentType: req.files[0].mimetype,
    data: new Buffer(encode_img, "base64"),
  };
  const studentDetail = new StudentDetail({
    heading: req.body.heading,
    student: [
      {
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        description: req.body.description,
        img: final_img,
      },
    ],
  });
  studentDetail.save().catch((err) => res.send(err));
}

async function PutNewStudentDetail(req, res) {
  var img = fs.readFileSync(req.files[0].path);
  fs.unlinkSync(req.files[0].path);
  var encode_img = img.toString("base64");
  var final_img = {
    contentType: req.files[0].mimetype,
    data: new Buffer(encode_img, "base64"),
  };
  StudentDetail.updateOne(
    { heading: req.body.heading },
    {
      $push: {
        student: {
          firstName: req.body.firstName,
          lastName: req.body.lastName,
          description: req.body.description,
          img: final_img,
        },
      },
    }
  ).catch((err) => res.send(err));
}

async function FindAllStudentDetail(req, res) {
  try {
    StudentDetail.find((err, list) => {
      if (err) {
        res.send(err);
      } else {
        res.send(list);
      }
    });
  } catch (err) {
    console.error(`Error while getting all student details:`, err.message);
  }
}

async function DeleteStudentDetail(req, res) {
  try {
    StudentDetail.deleteOne(
      { heading: req.body.heading },
      function (err, list) {
        res.send("success");
      }
    );
  } catch (err) {
    console.error(`Error while deleting student by ID:`, err.message);
  }
}

//delete with student ID
async function DeleteStudentID(req, res) {
  try {
    Book.deleteOne({ _id: req.params.id }, function (err, list) {
      res.send("sucess");
    });
  } catch (err) {
    console.error(`Error while deleting student by ID:`, err.message);
  }
}

async function PostNewStudentDetail(req, res) {
  const studentDetail = new StudentDetailSchema({
    heading: req.body.heading,
    student: [
      {
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        description: req.body.description,
      },
    ],
  });
  studentDetail.save().catch((err) => res.send(err));
}

async function PutNewStudentDetail(req, res) {
  StudentDetailSchema.updateOne(
    { heading: req.body.heading },
    {
      $push: {
        student: {
          firstName: req.body.firstName,
          lastName: req.body.lastName,
          description: req.body.description,
        },
      },
    }
  ).catch((err) => res.send(err));
}

async function FindAllStudentDetail(req, res) {
  try {
    StudentDetailSchema.find((err, list) => {
      if (err) {
        res.send(err);
      } else {
        res.send(list);
      }
    });
  } catch (err) {
    console.error(`Error while getting all student details:`, err.message);
  }
}

async function DeleteStudentDetail(req, res) {
  try {
    StudentDetailSchema.deleteOne(
      { heading: req.body.heading },
      function (err, list) {
        res.send("success");
      }
    );
  } catch (err) {
    console.error(`Error while deleting student by ID:`, err.message);
  }
}



module.exports = {
  PostNewUser,
  PostLogin,
  FindAllUser,
  FindUsername,
  FindUser,
  DeleteUserID,
  UpdateUser,
  UploadUserPicture,
  GetUserPicture,
  RefreshToken,
  Logout,
  FindAllBook,
  GetTotalCountOfTheBook,
  PostNewBok,
  DeleteBook,
  UpdateBookDetail,
  GetContentTitle,
  FindBookByTitle,
  FindBookById,
  PostNewStudentDetail,
  FindAllStudentDetail,
  DeleteStudentDetail,
  PutNewStudentDetail,
  DeleteStudentID,
  FindAllConclusion,
  PostNewConclusion,
  UpdateConclusionDetail,
  DeleteConclusion
};
