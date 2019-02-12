ciao-prolog-docker
==================

## TLDR

Copy your files to edit into the [`WS`](./WS) folder.

Type `make` and wait...

```bash
make
```

## Hello World

- Ciao CLI 

Type `emacs hello.pl`

```
main :-
     write('Hello World'),
     nl.
```

Then type `ciaoc hello.pl` to compile and execute it `./hello`

- Emacs GUI 

Type `emacs hello.pl`

```
main :-
     write('Hello World'),
     nl.
```

Then type `C-c l` to compile it and `C-c x` to make an executable

### Your custom emacs config

Not for now... PRs are welcome.

## THANKS

* [docker-emacs](https://github.com/JAremko/docker-emacs)
* [GuillermoPL95](https://github.com/GuillermoPL95)
* [jfagoagas](https://github.com/jfagoagas)
