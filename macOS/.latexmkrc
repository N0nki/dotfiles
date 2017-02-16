$latex = 'uplatex -synctex=1 -src-specials -interaction=nonstopmode';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'pbibtex %O %B';
$makeindex = 'upmendex %O -o %D %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$pdf_mode = '3';
$pdf_previewer = 'open -ga /Applications/Skim.app';
