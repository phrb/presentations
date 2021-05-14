for i in *.svg; do echo $i; inkscape -D -z --file=$i --export-pdf=$i.pdf --export-latex; done
