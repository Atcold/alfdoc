# alfdoc

`alfdoc` gives every document of mine the same look, whatever project it comes from. `alfdoc.sty` holds the [Set3](https://colorbrewer2.org/#type=qualitative&scheme=Set3&n=12) and tone colours, `\name`, the listings and boxes, the logos (`\svglogo`), and the review marks. `revision.pl`, a Perl script that latexmk runs from its `.latexmkrc` (Perl too), writes each document's revision from git, a line in the title page's header and a `\revisiontable` at the end, and `boox-review.py` sends each successful build to an e-reader's review folder.

```latex
\usepackage{alfdoc}
… \maketitle … \here[a new paragraph] … \revisiontable
```

## Install

Link the files where LaTeX finds them, and run `revision.pl` from the document folder's `.latexmkrc`:

```sh
mkdir -p ~/Library/texmf/tex/latex/alfdoc && ln -s "$PWD"/{alfdoc.sty,revision.pl,boox-review.py} $_
echo 'do "$ENV{HOME}/Library/texmf/tex/latex/alfdoc/revision.pl";' >> .latexmkrc
```

## Settings

- `$jobname` in `.latexmkrc` makes the folder one lesson, whose main document's history covers the whole folder. Without it, every `.tex` file has its own history.
- `$alfdoc_boox` in `~/.latexmkrc` names the e-reader's synced folder. Each build of a document with `\revisiontable` is copied to its `Review/`, unless the copy there carries notes. This needs `uv`.

## Rules the package cannot enforce

- Names of things (programs, files, folders, hosts) go in sans with `\name{}`, and monospace only for literal text. A name that is a link gets `\lk{}`, the only underline.
- TikZ uses plain `->` tips, the default line width, and labels clear of the arrows.
- Pinyin and characters are always tone-coloured.
- Each feedback round marks every edit with `\here[short][long]`: a hand in the margin, and the long note in the changes box, which takes a page of its own before the title, so the document keeps the layout it will have once the round closes. `\reviewfalse` hides both.
