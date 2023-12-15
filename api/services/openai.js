const fs = require('fs');
const axios = require('axios');


const api_key = process.env.OPEN_AI_KEY;

// Function to encode the image
function encodeImage(imagePath) {
  const imageBuffer = fs.readFileSync(imagePath);
  return imageBuffer.toString('base64');
}

// Path to your image
const imagePath = "sharingan.jpg";

// Getting the base64 string
const base64Image = encodeImage(imagePath);

const headers = {
  "Content-Type": "application/json",
  "Authorization": `Bearer ${api_key}`
};

const payload = {
  "model": "gpt-4-vision-preview",
  "messages": [
    {
      "role": "user",
      "content": [
        {
          "type": "text",
          "text": "What’s in this image?"
        },
        {
          "type": "image_url",
          "image_url": {
            "url": `data:image/jpeg;base64,${base64Image}`
          }
        }
      ]
    }
  ],
  "max_tokens": 300
};

axios.post("https://api.openai.com/v1/chat/completions", payload, { headers })
  .then(response => {
    console.log(response.data);
  })
  .catch(error => {
    console.error(error);
  });
