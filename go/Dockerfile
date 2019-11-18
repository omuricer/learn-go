# FROM golang:1.13-alpine
# alpineにはgitコマンドがなく、go getできないため、開発環境では使わない
# 本番用のマルチステージビルドのときは軽量化のためにalipineを使用する
FROM golang:1.13

RUN go get -u github.com/gorilla/mux \
    github.com/oxequa/realize

WORKDIR /var/app/src
