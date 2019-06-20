# Some dockers to use [Bookdown.org](https://bookdown.org/)

Different docker images to use [Bookdown.org](https://bookdown.org/) to prepare [PDF](https://bookdown.org/yihui/bookdown/latexpdf.html), [Ebooks](https://bookdown.org/yihui/bookdown/e-books.html) or [HTML site](https://bookdown.org/yihui/bookdown/html.html#gitbook-style) from R Markdown.

* [Getting Started](#getstart)
 * [Prerequisities](#getstart.prereq)
 * [Bookdown Base](#getstart.bookdownbase)
 * [Bookdown Extended](#getstart.bookdownext)
 * [Bookdown User](#getstart.bookdownuser)
* [Authors](#authors)
* [Licence](#Licence)
* [Acknowledgments](#acknow)

## Getting Started
(#getstart)
### Prerequisities
(#getstart.prereq)
In order to run this container you'll need docker installed.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

### Bookdown Base
(#getstart.bookdownbase)
This docker image is based on [r-base:3.6.0](https://hub.docker.com/_/r-base).
It includes the packages needed to create PDF (LaTeX), EPUB ([Pandoc](https://pandoc.org/)), HTML sites ([Gitbook](https://www.gitbook.com/)) using the [R bookdown](https://bookdown.org/) package.
Note that the image already contains the necessary to include Pyton 2 and Python 3 code in your book.

#### Environment Variables
(#getstart.bookdownbase.env)
* `mainFile` - Path to the main file used to create your book. Default: `index.Rmd`

#### Volumes
(#getstart.bookdownbase.vol)
* `/book` - Working directory used to create the book. All your files must be in this folder.

#### Usage
(#getstart.bookdownbase.use)
You can simply run the following command to compile your book in the folder `./path/to/my/fodler`, with main file `index.Rmd` into PDF, EPUB, and HTML.
```shell
docker run --rm -e "mainFile=index.Rmd" -v ./path/to/my/fodler:/book pcourbin/bookdown:base
```

If you want to run a specific `bookdown::render_book` command, for example `pdf_book` you can use:
```shell
docker run --rm -e "mainFile=index.Rmd" -v ./path/to/my/fodler:/book pcourbin/bookdown:base bookdown pdf_book
```
it will run: `bookdown::render_book('index.Rmd', 'bookdown::pdf_book')`

### Bookdown Extended
(#getstart.bookdownext)
Based on the previous image, it simply add support for:

* [devtools package](https://cran.r-project.org/web/packages/devtools/index.html)
* [ropenscilabs/icon package](https://github.com/ropenscilabs/icon)
* [phantomjs](http://phantomjs.org/)
* [webshot package](https://cran.r-project.org/web/packages/webshot/index.html) -- Which activates [HTML Widgets](https://bookdown.org/yihui/bookdown/html-widgets.html)

### Bookdown User
(#getstart.bookdownuser)
If you want to use docker images on Linux, it may be convenient to prepare a specific image using a `uid` equivalent to yours.
The file `Dockerfile.user` helps you.

#### Environment Variables
(#getstart.bookdownuser.env)
* `bookdownuser` - Define the name of the user you want to create in the image.
* `uid` - Define the `uid` of the user you want to create in the image.

#### Usage
(#getstart.bookdownuser.use)
Copy the file `Dockerfile.user`, choose `$USER` and `$UID` to correspond to your local user and run
```shell
docker build -t mybookdown:user \
  --build-arg bookdownuser=$USER \
  --build-arg uid=$UID \
  -f Dockerfile.user .
```

You can then simply use:
```shell
docker run --rm -e "mainFile=index.Rmd" -v ./path/to/my/fodler:/book mybookdown:user
```
to compile your book and create the files belonging to the user `$UID`.

## Authors
(#authors)
* **Pierre Courbin** - *Initial work* - [PCourbin](https://github.com/pcourbin)

## License
(#Licence)
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments
(#acknow)
* Thanks to [Mohamad Ghassany](https://github.com/mghassany) for the discovery of [Bookdown](https://bookdown.org/).
