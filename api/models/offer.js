const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const Offer = new Schema({
    name: {
        type: String,
        required: true,
        unique: true
    },
    description: String,
    price: Number,
}, { timestamps: true })

// Export Model
module.exports = mongoose.model('Offer', Offer);