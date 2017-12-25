
### Usage:

```
ruby password_genetator.rb [options]

        -l, --length LENGTH          生成するパスワードの長さを指定します。

        --exclude_confusing_letters  紛らわしい文字（大文字のアイ、小文字のエル、数字のイチ、大文字のオー、数字のゼロ ）
                                     を除いてパスワードを生成します。  
```

### 実行例:

```
$ ruby password_genetator.rb -l 10 --exclude_confusing_letters
Your password: ut5dBf4as8
```
