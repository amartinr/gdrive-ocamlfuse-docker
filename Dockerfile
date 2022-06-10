FROM alpine
ENV OPAMROOTISOK=true
ENV OPAMYES=true
WORKDIR /root
RUN apk update && apk add build-base autoconf automake pkgconf
RUN apk add ocaml ocaml-findlib ocaml-ocamldoc ocaml-compiler-libs opam curl-dev fuse-dev gmp-dev sqlite-dev zlib-dev && opam init && eval $(opam env --switch=default) && opam install ocamlfind && opam install google-drive-ocamlfuse
COPY config /root/.gdfuse/default/config
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
