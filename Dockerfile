FROM --platform=linux/amd64 alpine:3.20

RUN echo "y" | apk add --no-cache alpine-sdk nasm bash valgrind

WORKDIR /app

COPY . .

CMD ["bash"]