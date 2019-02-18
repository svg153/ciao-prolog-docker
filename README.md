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

Then type `C-c C-s` to save and `C-x C-c` to exit emacs. Then type `ciaoc hello.pl` to compile and execute it: `./hello`

- Emacs GUI 

Type `emacs hello.pl`

```
main :-
     write('Hello World'),
     nl.
```

Then type `C-c C-s` to save, `C-c l` to compile and `C-c x` to make an executable.

```bash
emacser@ciao-docker:~/workspace$ ./hello
Hello World
```

### Your custom emacs config

Not for now... PRs are welcome.

## Alternatives

Install ciao on unix based S.O. without docker container.
https://gist.github.com/jfagoagas/56d6633a741e831f8a109cab397d129f

Debian VM with the full developer environment working along with emacs. 

## THANKS

* [docker-emacs](https://github.com/JAremko/docker-emacs)
* [GuillermoPL95](https://github.com/GuillermoPL95)
* [jfagoagas](https://github.com/jfagoagas)
