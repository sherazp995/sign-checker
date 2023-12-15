const express = require('express');
const router = express.Router();
const User = require('../models/user');
const {sign} = require('jsonwebtoken');
const passwordHash = require('password-hash');

router.get('/all', async (req, res) => {
  let result = await User.find()
  res.json({ status: 200, result })
});

router.get('/:id', async (req, res) => {
  try {
    let result = await User.findOne({ _id: req.params.id });
    res.json({ status: 200, result })
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Something went wrong' });
  }
});

router.post("/register", async (req, res) => {
  try {
    let user = req.body;
    let result = await User.findOne({ email: user.email });
    let message = '';
    if (result) {
      message = 'User Already Exist!';
    }
    else {
      user.password = passwordHash.generate(user.password);
      result = await User.create(user);
      message = 'User Created Successfully!';
    }
    res.json({ status: 200, result, message });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Something went wrong' });
  }
});

router.post('/delete/:id', async (req, res) => {
  try {
    let result = await User.findByIdAndUpdate(req.params.id, { $set: { status: 2 } }, { new: true });
    res.json({ status: 200, result, message: 'User Deleted Successfully' });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Something went wrong' });
  }
});

router.post('/update/:id', async (req, res) => {
  try {
    let user = req.body;
    let dbUser = await User.findById(req.params.id);
    if (passwordHash.verify(user.oldPassword, dbUser.password)) {
      if (user.newPassword) {
        user.password = passwordHash.generate(user.newPassword);
      }
      let result = await User.findByIdAndUpdate(req.params.id, {
        $set: user
      }, { new: true });
      res.json({ status: 200, result, message: 'Updated Successfully' });
    } else {
      res.json({status: 500, message: "Incorrect Old Password"});
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Something went wrong' });
  }
});

router.post('/login', async (req, res) => {
  try {
    let result = await User.findOne({ email: req.body.email });
    console.log(result)

    if (result) {
      if (passwordHash.verify(req.body.password, result.password)) {
        let jwtToken = sign({ _id: result["_id"] }, process.env.privateKey);
        res.json({ status: 200, result, jwtToken, message: 'Successfully logged in' });
      }
      else {
        res.json({ status: 500, message: 'Incorrect password' });
      }
    }
    else {
      res.json({ status: 500, message: 'User does not exist' });
    }
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Something went wrong' });
  }
});

module.exports = router;