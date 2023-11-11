const express = require('express');
const router = express.Router();
const { Offer } = require('../models');

router.get('/all', async (req, res) => {
    try {
        let result = await Offer.find();
        res.json({ status: 200, result });
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: 'Something went wrong' });
    }
});

router.get('/:id', async (req, res) => {
    try {
      let result = await Offer.findOne({ _id: req.params.id });
      res.json({ status: 200, result })
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: 'Something went wrong' });
    }
});

router.post("/new", async (req, res) => {
    try {
      let offer = req.body;
      let result = await Offer.findOne({ name: offer.name });
      let message = '';
      if (result) {
        message = 'Offer Already Exist!';
      }
      else {
        result = await Offer.create(offer);
        message = 'Offer Created Successfully!';
      }
      res.json({ status: 200, result, message });
    } catch (error) {
      console.log(error);
      res.status(500).json({ message: 'Something went wrong' });
    }
});
  
router.post('/delete/:id', async (req, res) => {
  try {
    let result = await Offer.findByIdAndUpdate(req.params.id, { $set: { status: 2 } }, { new: true });
    res.json({ status: 200, result, message: 'Offer Deleted Successfully' });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Something went wrong' });
  }
});

router.post('/update/:id', async (req, res) => {
  try {
    let offer = req.body;
    let result = await Offer.findByIdAndUpdate(req.params.id, {
    $set: offer
    }, { new: true });
    res.json({ status: 200, result, message: 'Updated Successfully' });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Something went wrong' });
  }
});

module.exports = router;