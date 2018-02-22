FROM golang
ADD kongExample /go/src/github.com/narenaryan/kongExample
RUN go get github.com/gorilla/mux
RUN go install github.com/narenaryan/kongExample
ENTRYPOINT /go/bin/kongExample