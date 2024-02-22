from application import create_app
from flask import Blueprint, render_template, request, redirect
import numpy as np
import cv2
import pytesseract

app = create_app()

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        img = request.files['file']
        team_tag = request.form['team_tag']
        enemy_tag = request.form['enemy_tag']
        texts = ocr(img)
        calc_result, team_score, enemy_score = calculate_score(texts, team_tag, enemy_tag)
        print(texts)

        return render_template("index.html", texts=texts, calc_result=calc_result, team_score=team_score, enemy_score=enemy_score)

    return render_template("index.html")

# 文字認識
def ocr(img):
    texts = []
    width = 275; height = 40 #切り出す画像のサイズ
    x = 675; y = 54 # 基準点

    img = cv2.imdecode(np.fromstring(img.read(), np.uint8), cv2.IMREAD_GRAYSCALE)

    for _ in range(12):
        # 分割、2値化
        img_cropped = img[y:y+height, x:x+width]
        y = y + height + 12
        ret, img_thresh = cv2.threshold(img_cropped, 180, 255, cv2.THRESH_BINARY)

        if img_thresh[0][0] == 0:
            img_thresh = 255 - img_thresh

        #文字認識
        text = pytesseract.image_to_string(img_thresh, lang='jpn')
        texts.append(text)

    return texts

# 得点計算
def calculate_score(texts, team_tag, enemy_tag):
    rank_dict = {}
    team_score, enemy_score = 0, 0
    score_array = [15, 12, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

    for i, text in enumerate(texts):
        if team_tag in text:
            rank_dict[i+1] = team_tag
            team_score += score_array[i]
        elif enemy_tag in text:
            rank_dict[i+1] = enemy_tag
            enemy_score += score_array[i]
        else:
            rank_dict[i+1] = "Error: " + text

    return rank_dict, team_score, enemy_score


if __name__ == '__main__':
    app.run(debug=True)

