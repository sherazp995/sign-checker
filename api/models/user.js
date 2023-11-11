const mongoose = require('mongoose');

const Schema = mongoose.Schema;

const User = new Schema({
    firstName: String,
    lastName: String,
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
}, { timestamps: true })

// Export Model
module.exports = mongoose.model('User', User);