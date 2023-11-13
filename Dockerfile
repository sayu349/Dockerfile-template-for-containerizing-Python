# pythonのバージョンを指定
FROM python:3.9.10

# ルートディレクトリ指定（コンテナ側の作業ディレクトリを指定する）
# 後続のコマンドの作業ディレクトリをルーティングする
WORKDIR /

# FlaskにどのPythonファイルを読み込ませるか
ENV FLASK_APP=app.py

# どのアドレスで待ち受けるか
# "0.0.0.0"で全ての公開IPアドレスで利用可能
ENV FLASK_RUN_HOST=0.0.0.0

# "requirements.txt"を、コンテナ内のルートディレクトリ上に配置
COPY requirements.txt ./

# コンテナ内でpipコマンドを使用する
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install -r requirements.txt

# ホストマシンの現在のディレクトリ（Dockerfileがあるディレクトリ）の内容を、
# コンテナの現在の作業ディレクトリにコピーする
# "COPY requirements.txt ./"を先に実行しているのは更新時にキャッシュを
# 有効活用できるため
COPY . .

# コンテナが起動した際に実行されるコマンドを設定
# flask run
CMD ["flask", "run"]