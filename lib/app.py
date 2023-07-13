from flask import Flask, request, jsonify
from flask_cors import CORS
import subprocess
import opennsfw2 as n2
import cv2
import numpy as np
from deepface import DeepFace
import tensorflow as tf




app = Flask(__name__)
CORS(app)

@app.route('/run_script', methods=['POST'])
def run_script():



# To get the NSFW probability of a single image.
    image_path = "d.png"

    nsfw_probability = n2.predict_image(image_path)
    objs = DeepFace.analyze(img_path = image_path, 
    actions = ['age', 'gender', 'race', 'emotion']
    )

    print("nsfw_probabilitys:", nsfw_probability)
    print("Age =",objs[0]['age'])

    key = True
    if((nsfw_probability<.09)&(objs[0]['age']>18)):
        key = False
        
    # Return the result as JSON response
    return jsonify({'output': key})

if __name__ == '__main__':
    app.run()