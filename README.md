# 距離計算

[![CircleCI](https://circleci.com/gh/odt/distance.svg?style=svg)](https://circleci.com/gh/odt/distance)

始点の緯度経度、終点の緯度経度が並んだ CSV があります。

``` csv
1,2,3,4
5,6,7,8
```

これが

``` csv
1.0,2.0,3.0,4.0,313680.0720366019
5.0,6.0,7.0,8.0,312932.51527830923
```

こうなる。距離/メートルをつけ加えます。

標準入力から読み込んで標準出力に書き出します。
