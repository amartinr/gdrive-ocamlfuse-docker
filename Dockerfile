FROM alpine AS builder
ENV OPAMROOTISOK=true
ENV OPAMYES=true
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
COPY config /root/.gdfuse/default/config
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
