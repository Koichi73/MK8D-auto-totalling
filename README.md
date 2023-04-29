# MK8D_auto_totalling
【マリオカート8DX】合計得点を自動で集計する

## Demo


## Summary
マリオカート8デラックスの対戦(野良を除く)では、以下のように順位に応じたポイントを得る。<br>
1位：+15、2位：+12、3位：+10、4位：+9、・・・、12位：+1

<img src="data/screenshot.png" width="700">
https://www.youtube.com/live/yzJC35iwXOM?feature=share

<br>
6vs6のチーム戦(交流戦など)では、毎レースで合計何点獲得したかを素早く知ることが重要である。<br>
そこで、画像から文字認識を行い、自動で総獲得ポイントを計算するツールを作成した。

なお、即時集計ツールには下記などがあるが、これらはチームメンバーの順位を手入力する必要がある。<br>
https://gungeespla.github.io/mk8dx_sokuji/

## Setup
#### ライブラリの構築
requirements.txtにて構築
```
pip install -r requirements.txt
```

## Usage
1. main_gui.ipynbを実行
2. ファイルを選択
3. それぞれのタグを入力
4. 「実行」をクリック

## Note
誤認識をカバーするために、大文字・小文字の区別をなくすif文を追加

☆やγなどの特殊文字は読み取り不可

## Reference
画像は下記から引用<br>
https://www.youtube.com/live/yzJC35iwXOM?feature=share

