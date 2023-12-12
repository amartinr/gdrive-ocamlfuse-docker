FROM alpine AS builder
ARG OPAMROOTISOK=true
ARG OPAMYES=true
WORKDIR /root
RUN apk --no-cache add opam m4 git make \
                       libc-dev ocaml-compiler-libs ocaml-ocamldoc \
                       sqlite fuse-dev curl-dev gmp-dev sqlite-dev zlib-dev
RUN opam init  --disable-sandboxing  -y \
    && opam update \
    && opam install -y --no-depexts ocamlfuse google-drive-ocamlfuse

FROM alpine
RUN apk add --no-cache fuse libgmpxx sqlite-libs libcurl libressl ncurses-libs
COPY --from=builder /root/.opam/default/bin/google-drive-ocamlfuse /bin/google-drive-ocamlfuse
ARG UID=1000
ARG GID=1000
ARG HOME=/var/lib/gdfuse
WORKDIR $HOME
COPY config $HOME/.gdfuse/default/config
RUN addgroup -g $UID gdfuse \
    && adduser -u $UID -G gdfuse -D -h $HOME gdfuse \
    && mkdir $HOME/gdrive \
    && chown -R $UID:$GID $HOME
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
